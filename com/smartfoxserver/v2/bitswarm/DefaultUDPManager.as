package com.smartfoxserver.v2.bitswarm
{
   import com.smartfoxserver.v2.SmartFox;
   import flash.utils.ByteArray;
   
   public class DefaultUDPManager implements IUDPManager
   {
      private var _sfs:SmartFox;
      
      public function DefaultUDPManager(sfs:SmartFox)
      {
         super();
         this._sfs = sfs;
      }
      
      public function initialize(udpAddr:String, udpPort:int) : void
      {
         this.logUsageError();
      }
      
      public function nextUdpPacketId() : Number
      {
         return -1;
      }
      
      public function send(binaryData:ByteArray) : void
      {
         this.logUsageError();
      }
      
      public function get inited() : Boolean
      {
         return false;
      }
      
      public function set sfs(sfs:SmartFox) : void
      {
      }
      
      public function reset() : void
      {
      }
      
      private function logUsageError() : void
      {
         if(this._sfs.udpAvailable)
         {
            this._sfs.logger.warn("UDP protocol is not initialized yet. Pleas use the initUDP() method. If you have any doubts please refer to the documentation of initUDP()");
         }
         else
         {
            this._sfs.logger.warn("You are not currently enabled to use UDP protocol. UDP is available only for Air 2 runtime and higher.");
         }
      }
   }
}

