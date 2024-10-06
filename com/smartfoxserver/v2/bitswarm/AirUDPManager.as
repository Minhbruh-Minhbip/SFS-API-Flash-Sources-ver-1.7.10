package com.smartfoxserver.v2.bitswarm
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.core.DefaultPacketEncrypter;
   import com.smartfoxserver.v2.core.IPacketEncrypter;
   import com.smartfoxserver.v2.core.SFSEvent;
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   import com.smartfoxserver.v2.entities.data.SFSObject;
   import com.smartfoxserver.v2.kernel;
   import com.smartfoxserver.v2.logging.Logger;
   import com.smartfoxserver.v2.protocol.serialization.DefaultObjectDumpFormatter;
   import flash.errors.IOError;
   import flash.events.DatagramSocketDataEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.DatagramSocket;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   public class AirUDPManager implements IUDPManager
   {
      private var _sfs:SmartFox;
      
      private var _packetId:Number;
      
      private var _udpSocket:DatagramSocket;
      
      private var _inited:Boolean = false;
      
      private var _log:Logger;
      
      private var _locked:Boolean = false;
      
      private var _initSuccess:Boolean = false;
      
      private const MAX_RETRY:int = 3;
      
      private const RESPONSE_TIMEOUT:int = 3000;
      
      private var _initThread:Timer;
      
      private var _currentAttempt:int;
      
      private var packetEncrypter:IPacketEncrypter;
      
      public function AirUDPManager()
      {
         super();
         this._packetId = 0;
         this._currentAttempt = 1;
      }
      
      public function initialize(udpAddr:String, udpPort:int) : void
      {
         if(this._initSuccess)
         {
            this._log.warn("UDP Channel already initialized!");
            return;
         }
         if(!this._locked)
         {
            this._locked = true;
            this._udpSocket = new DatagramSocket();
            this._udpSocket.addEventListener(DatagramSocketDataEvent.DATA,this.onUDPData);
            this._udpSocket.addEventListener(IOErrorEvent.IO_ERROR,this.onUDPError);
            this._udpSocket.connect(udpAddr,udpPort);
            this._udpSocket.receive();
            this._initThread = new Timer(this.RESPONSE_TIMEOUT,1);
            this._initThread.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeout);
            this.sendInitializationRequest();
         }
         else
         {
            this._log.warn("UPD initialization is already in progress!");
         }
      }
      
      public function nextUdpPacketId() : Number
      {
         return this._packetId++;
      }
      
      public function send(binaryData:ByteArray) : void
      {
         if(this._initSuccess)
         {
            try
            {
               this._udpSocket.send(binaryData);
               if(this._sfs.debug)
               {
                  this._log.info("UDP Data written: " + DefaultObjectDumpFormatter.hexDump(binaryData));
               }
            }
            catch(err:IOError)
            {
               _log.warn("WriteUDP operation failed due to I/O Error: " + err.toString());
            }
         }
         else
         {
            this._log.warn("UDP protocol is not initialized yet. Please use the initUDP() method.");
         }
      }
      
      public function get inited() : Boolean
      {
         return this._initSuccess;
      }
      
      public function set sfs(sfs:SmartFox) : void
      {
         this._sfs = sfs;
         this._log = sfs.logger;
         this.packetEncrypter = new DefaultPacketEncrypter(sfs.kernel::socketEngine);
      }
      
      public function reset() : void
      {
         if(this._initThread != null && this._initThread.running)
         {
            this._initThread.stop();
         }
         this._currentAttempt = 1;
         this._inited = false;
         this._initSuccess = false;
         this._locked = false;
         this._packetId = 0;
         if(this._udpSocket.connected)
         {
            this._udpSocket.close();
         }
      }
      
      private function onUDPData(evt:DatagramSocketDataEvent) : void
      {
         var evtParams:Object = null;
         var bytes:ByteArray = evt.data as ByteArray;
         if(bytes.bytesAvailable < 4)
         {
            this._log.warn("Too small UDP packet. Len: " + bytes.length);
            return;
         }
         if(this._sfs.debug)
         {
            this._log.info("UDP Data Read: " + DefaultObjectDumpFormatter.hexDump(bytes));
         }
         var header:int = bytes.readByte();
         var compressed:Boolean = (header & 0x20) > 0;
         var encrypted:Boolean = (header & 0x40) > 0;
         var dataSize:int = bytes.readShort();
         if(dataSize != bytes.bytesAvailable)
         {
            this._log.warn("Insufficient UDP data. Expected: " + dataSize + ", got: " + bytes.bytesAvailable);
            return;
         }
         var objBytes:ByteArray = new ByteArray();
         bytes.readBytes(objBytes,0,bytes.bytesAvailable);
         if(encrypted)
         {
            this.packetEncrypter.decrypt(objBytes);
         }
         if(compressed)
         {
            objBytes.uncompress();
         }
         var reqObj:ISFSObject = SFSObject.newFromBinaryData(objBytes);
         if(reqObj.containsKey("h"))
         {
            this._initThread.stop();
            this._locked = false;
            this._initSuccess = true;
            evtParams = {};
            evtParams.success = true;
            this._sfs.dispatchEvent(new SFSEvent(SFSEvent.UDP_INIT,evtParams));
            return;
         }
         this._sfs.kernel::socketEngine.ioHandler.codec.onPacketRead(reqObj);
      }
      
      private function onUDPError(evt:IOErrorEvent) : void
      {
         this._log.warn("Unexpected UDP I/O Error. " + evt.text);
      }
      
      private function sendInitializationRequest() : void
      {
         var message:ISFSObject = new SFSObject();
         message.putByte("c",1);
         message.putByte("h",1);
         message.putLong("i",this.nextUdpPacketId());
         message.putInt("u",this._sfs.mySelf.id);
         var binData:ByteArray = message.toBinary();
         var writeBuffer:ByteArray = new ByteArray();
         writeBuffer.writeByte(128);
         writeBuffer.writeShort(binData.length);
         writeBuffer.writeBytes(binData);
         this._udpSocket.send(writeBuffer);
         this._initThread.start();
      }
      
      private function onTimeout(evt:Event) : void
      {
         var evtParams:Object = null;
         if(this._currentAttempt < this.MAX_RETRY)
         {
            ++this._currentAttempt;
            this._log.debug("UDP Init Attempt: " + this._currentAttempt);
            this.sendInitializationRequest();
            this._initThread.start();
         }
         else
         {
            this._currentAttempt = 0;
            this._locked = false;
            evtParams = new Object();
            evtParams.success = false;
            this._sfs.dispatchEvent(new SFSEvent(SFSEvent.UDP_INIT,evtParams));
         }
      }
   }
}

