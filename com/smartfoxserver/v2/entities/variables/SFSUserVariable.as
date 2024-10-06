package com.smartfoxserver.v2.entities.variables
{
   import com.smartfoxserver.v2.entities.data.ISFSArray;
   
   public class SFSUserVariable extends BaseVariable implements UserVariable
   {
      protected var _isPrivate:Boolean;
      
      public function SFSUserVariable(name:String, value:*, type:int = -1)
      {
         super(name,value,type);
      }
      
      public static function fromSFSArray(sfsa:ISFSArray) : UserVariable
      {
         var variable:UserVariable = new SFSUserVariable(sfsa.getUtfString(0),sfsa.getElementAt(2),sfsa.getByte(1));
         if(sfsa.size() > 3)
         {
            variable.isPrivate = sfsa.getBool(3);
         }
         return variable;
      }
      
      public static function newPrivateVariable(name:String, value:*) : SFSUserVariable
      {
         var uv:SFSUserVariable = new SFSUserVariable(name,value);
         uv.isPrivate = true;
         return uv;
      }
      
      public function get isPrivate() : Boolean
      {
         return this._isPrivate;
      }
      
      public function set isPrivate(value:Boolean) : void
      {
         this._isPrivate = value;
      }
      
      override public function toSFSArray() : ISFSArray
      {
         var sfsa:ISFSArray = super.toSFSArray();
         sfsa.addBool(this._isPrivate);
         return sfsa;
      }
      
      public function toString() : String
      {
         return "[UserVar: " + _name + ", type: " + _type + ", value: " + _value + ", private: " + this._isPrivate + "]";
      }
   }
}

