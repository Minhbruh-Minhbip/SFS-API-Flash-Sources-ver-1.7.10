package com.smartfoxserver.v2.logging
{
   public class LogLevel
   {
      public static const DEBUG:int = 100;
      
      public static const INFO:int = 200;
      
      public static const WARN:int = 300;
      
      public static const ERROR:int = 400;
      
      public function LogLevel()
      {
         super();
      }
      
      public static function toString(level:int) : String
      {
         var levelStr:String = "Unknown";
         if(level == DEBUG)
         {
            levelStr = "DEBUG";
         }
         else if(level == INFO)
         {
            levelStr = "INFO";
         }
         else if(level == WARN)
         {
            levelStr = "WARN";
         }
         else if(level == ERROR)
         {
            levelStr = "ERROR";
         }
         return levelStr;
      }
      
      public static function fromString(level:String) : int
      {
         level = level.toUpperCase();
         if(level == toString(DEBUG))
         {
            return DEBUG;
         }
         if(level == toString(INFO))
         {
            return INFO;
         }
         if(level == toString(WARN))
         {
            return WARN;
         }
         if(level == toString(ERROR))
         {
            return ERROR;
         }
         return -1;
      }
   }
}

