package com.smartfoxserver.v2.entities.match
{
   public class BoolMatch implements IMatcher
   {
      private static const TYPE_ID:int = 0;
      
      private static var lock:Boolean = false;
      
      public static const EQUALS:BoolMatch = new BoolMatch("==");
      
      public static const NOT_EQUALS:BoolMatch = new BoolMatch("!=");
      
      lock = true;
      
      private var _symbol:String;
      
      public function BoolMatch(symbol:String)
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

