package com.smartfoxserver.v2.entities.match
{
   public class NumberMatch implements IMatcher
   {
      private static const TYPE_ID:int = 1;
      
      private static var lock:Boolean = false;
      
      public static const EQUALS:NumberMatch = new NumberMatch("==");
      
      public static const NOT_EQUALS:NumberMatch = new NumberMatch("!=");
      
      public static const GREATER_THAN:NumberMatch = new NumberMatch(">");
      
      public static const GREATER_THAN_OR_EQUAL_TO:NumberMatch = new NumberMatch(">=");
      
      public static const LESS_THAN:NumberMatch = new NumberMatch("<");
      
      public static const LESS_THAN_OR_EQUAL_TO:NumberMatch = new NumberMatch("<=");
      
      lock = true;
      
      private var _symbol:String;
      
      public function NumberMatch(symbol:String)
      {
         super();
         if(lock)
         {
            throw new Error("Cannot instantiate Enum!");
         }
         this._symbol = symbol;
      }
      
      public function get symbol() : String
      {
         return this._symbol;
      }
      
      public function get type() : int
      {
         return TYPE_ID;
      }
   }
}

