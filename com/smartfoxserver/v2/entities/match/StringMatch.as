package com.smartfoxserver.v2.entities.match
{
   public class StringMatch implements IMatcher
   {
      private static const TYPE_ID:int = 2;
      
      private static var lock:Boolean = false;
      
      public static const EQUALS:StringMatch = new StringMatch("==");
      
      public static const NOT_EQUALS:StringMatch = new StringMatch("!=");
      
      public static const CONTAINS:StringMatch = new StringMatch("contains");
      
      public static const STARTS_WITH:StringMatch = new StringMatch("startsWith");
      
      public static const ENDS_WITH:StringMatch = new StringMatch("endsWith");
      
      lock = true;
      
      private var _symbol:String;
      
      public function StringMatch(symbol:String)
      {
         super();
         if(lock)
         {
            throw new Error("Cannot instantiate Enum!");
         }
         this._symbol = symbol;
      }
      
      public function get type() : int
      {
         return TYPE_ID;
      }
      
      public function get symbol() : String
      {
         return this._symbol;
      }
   }
}

