package com.smartfoxserver.v2.entities.variables
{
   import com.smartfoxserver.v2.entities.data.ISFSArray;
   
   public class SFSBuddyVariable extends BaseVariable implements BuddyVariable
   {
      public static const OFFLINE_PREFIX:String = "$";
      
      public function SFSBuddyVariable(name:String, value:*, type:int = -1)
      {
         super(name,value,type);
      }
      
      public static function fromSFSArray(sfsa:ISFSArray) : BuddyVariable
      {
         return new SFSBuddyVariable(sfsa.getUtfString(0),sfsa.getElementAt(2),sfsa.getByte(1));
      }
      
      public function get isOffline() : Boolean
      {
         return _name.charAt(0) == "$";
      }
      
      public function toString() : String
      {
         return "[BuddyVar: " + _name + ", type: " + _type + ", value: " + _value + "]";
      }
   }
}

