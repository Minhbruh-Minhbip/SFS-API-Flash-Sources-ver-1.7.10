package com.smartfoxserver.v2.logging
{
   import flash.events.EventDispatcher;
   
   [Event(name="error",type="com.smartfoxserver.v2.logging.LoggerEvent")]
   [Event(name="warn",type="com.smartfoxserver.v2.logging.LoggerEvent")]
   [Event(name="info",type="com.smartfoxserver.v2.logging.LoggerEvent")]
   [Event(name="debug",type="com.smartfoxserver.v2.logging.LoggerEvent")]
   public class Logger extends EventDispatcher
   {
      private var _enableConsoleTrace:Boolean = true;
      
      private var _enableEventDispatching:Boolean = false;
      
      private var _loggingLevel:int = 200;
      
      private var _loggingPrefix:String;
      
      public function Logger(prefix:String = "SFS2X")
      {
         super();
         this._loggingPrefix = prefix;
      }
      
      public function get enableConsoleTrace() : Boolean
      {
         return this._enableConsoleTrace;
      }
      
      public function set enableConsoleTrace(value:Boolean) : void
      {
         this._enableConsoleTrace = value;
      }
      
      public function get enableEventDispatching() : Boolean
      {
         return this._enableEventDispatching;
      }
      
      public function set enableEventDispatching(value:Boolean) : void
      {
         this._enableEventDispatching = value;
      }
      
      public function get loggingLevel() : int
      {
         return this._loggingLevel;
      }
      
      public function set loggingLevel(level:int) : void
      {
         this._loggingLevel = level;
      }
      
      public function debug(... arguments) : void
      {
         this.log(LogLevel.DEBUG,arguments.join(" "));
      }
      
      public function info(... arguments) : void
      {
         this.log(LogLevel.INFO,arguments.join(" "));
      }
      
      public function warn(... arguments) : void
      {
         this.log(LogLevel.WARN,arguments.join(" "));
      }
      
      public function error(... arguments) : void
      {
         this.log(LogLevel.ERROR,arguments.join(" "));
      }
      
      private function log(level:int, message:String) : void
      {
         var params:Object = null;
         var evt:LoggerEvent = null;
         if(level < this._loggingLevel)
         {
            return;
         }
         var levelStr:String = LogLevel.toString(level);
         if(this._enableConsoleTrace)
         {
            trace("[" + this._loggingPrefix + "|" + levelStr + "]",message);
         }
         if(this._enableEventDispatching)
         {
            params = {};
            params.message = message;
            evt = new LoggerEvent(levelStr.toLowerCase(),params);
            dispatchEvent(evt);
         }
      }
   }
}

