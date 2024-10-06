package com.smartfoxserver.v2.entities.variables
{
   import com.smartfoxserver.v2.entities.data.ISFSArray;
   
   public class MMOItemVariable extends BaseVariable implements IMMOItemVariable
   {
      public function MMOItemVariable(name:String, value:*, type:int = -1)
      {
         super(name,value,type);
      }
      
      public static function fromSFSArray(sfsa:ISFSArray) : IMMOItemVariable
      {
         return new MMOItemVariable(sfsa.getUtfString(0),sfsa.getElementAt(2),sfsa.getByte(1));
      }
      
      public function toString() : String
      {
         return "[MMOItemVar: " + _name + ", type: " + _type + ", value: " + _value + "]";
      }
   }
}

