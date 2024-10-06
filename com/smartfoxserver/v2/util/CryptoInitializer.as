package com.smartfoxserver.v2.util
{
   import com.hurlant.util.Base64;
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.core.SFSEvent;
   import com.smartfoxserver.v2.kernel;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   
   public class CryptoInitializer
   {
      private const KEY_SESSION_TOKEN:String = "SessToken";
      
      private const TARGET_SERVLET:String = "/BlueBox/CryptoManager";
      
      private var sfs:SmartFox;
      
      private var httpReq:URLRequest;
      
      private var useHttps:Boolean = true;
      
      public function CryptoInitializer(sfs:SmartFox)
      {
         super();
         if(!sfs.isConnected)
         {
            throw new IllegalOperationError("Cryptography cannot be initialized before connecting to SmartFoxServer!");
         }
         if(sfs.kernel::socketEngine.cryptoKey != null)
         {
            throw new IllegalOperationError("Cryptography is already initialized!");
         }
         this.sfs = sfs;
         this.run();
      }
      
      private function run() : void
      {
         var targetUrl:String = "https://" + this.sfs.config.host + ":" + this.sfs.config.httpsPort + this.TARGET_SERVLET;
         this.httpReq = new URLRequest(targetUrl);
         this.httpReq.method = URLRequestMethod.POST;
         var loader:URLLoader = new URLLoader();
         loader.addEventListener(Event.COMPLETE,this.onHttpResponse);
         loader.addEventListener(IOErrorEvent.IO_ERROR,this.onHttpIOError);
         loader.addEventListener(IOErrorEvent.NETWORK_ERROR,this.onHttpIOError);
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         var vars:URLVariables = new URLVariables();
         vars[this.KEY_SESSION_TOKEN] = this.sfs.sessionToken;
         this.httpReq.data = vars;
         loader.load(this.httpReq);
      }
      
      private function onHttpResponse(evt:Event) : void
      {
         var loader:URLLoader = evt.target as URLLoader;
         var rawData:String = loader.data as String;
         var byteData:ByteArray = Base64.decodeToByteArray(rawData);
         var iv:ByteArray = new ByteArray();
         var key:ByteArray = new ByteArray();
         key.writeBytes(byteData,0,16);
         iv.writeBytes(byteData,16,16);
         this.sfs.kernel::socketEngine.cryptoKey = new CryptoKey(iv,key);
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.CRYPTO_INIT,{"success":true}));
      }
      
      private function onHttpIOError(evt:IOErrorEvent) : void
      {
         this.sfs.logger.warn("HTTP I/O ERROR: " + evt.text);
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.CRYPTO_INIT,{
            "success":false,
            "errorMsg":evt.text
         }));
      }
      
      private function onSecurityError(evt:SecurityErrorEvent) : void
      {
         this.sfs.logger.warn("SECURITY ERROR: " + evt.text);
         this.sfs.dispatchEvent(new SFSEvent(SFSEvent.CRYPTO_INIT,{
            "success":false,
            "errorMsg":evt.text
         }));
      }
   }
}

