package com.smartfoxserver.v2.entities.variables
{
   import com.smartfoxserver.v2.entities.data.ISFSArray;
   
   public class SFSRoomVariable extends BaseVariable implements RoomVariable
   {
      private var _isPrivate:Boolean;
      
      private var _isPersistent:Boolean;
      
      public function SFSRoomVariable(name:String, value:*, type:int = -1)
      {
         super(name,value,type);
      }
      
      public static function fromSFSArray(sfsa:ISFSArray) : RoomVariable
      {
         var variable:RoomVariable = new SFSRoomVariable(sfsa.getUtfString(0),sfsa.getElementAt(2),sfsa.getByte(1));
         variable.isPrivate = sfsa.getBool(3);
         variable.isPersistent = sfsa.getBool(4);
         return variable;
      }
      
      public function get isPrivate() : Boolean
      {
         return this._isPrivate;
      }
      
      public function set isPrivate(value:Boolean) : void
      {
         this._isPrivate = value;
      }
      
      public function get isPersistent() : Boolean
      {
         return this._isPersistent;
      }
      
      public function set isPersistent(value:Boolean) : void
      {
         this._isPersistent = value;
      }
      
      public function toString() : String
      {
         return "[RoomVar: " + _name + ", type: " + _type + ", value: " + _value + ", private: " + this.isPrivate + "]";
      }
      
      override public function toSFSArray() : ISFSArray
      {
         var arr:ISFSArray = super.toSFSArray();
         arr.addBool(this._isPrivate);
         arr.addBool(this._isPersistent);
         return arr;
      }
   }
}

