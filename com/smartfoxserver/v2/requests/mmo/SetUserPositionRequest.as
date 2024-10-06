package com.smartfoxserver.v2.requests.mmo
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.entities.MMORoom;
   import com.smartfoxserver.v2.entities.Room;
   import com.smartfoxserver.v2.entities.data.Vec3D;
   import com.smartfoxserver.v2.exceptions.SFSValidationError;
   import com.smartfoxserver.v2.requests.BaseRequest;
   
   public class SetUserPositionRequest extends BaseRequest
   {
      public static const KEY_ROOM:String = "r";
      
      public static const KEY_VEC3D:String = "v";
      
      public static const KEY_PLUS_USER_LIST:String = "p";
      
      public static const KEY_MINUS_USER_LIST:String = "m";
      
      public static const KEY_PLUS_ITEM_LIST:String = "q";
      
      public static const KEY_MINUS_ITEM_LIST:String = "n";
      
      private var _pos:Vec3D;
      
      private var _room:Room;
      
      public function SetUserPositionRequest(pos:Vec3D, theRoom:Room = null)
      {
         super(BaseRequest.SetUserPosition);
         this._pos = pos;
         this._room = theRoom;
      }
      
      override public function validate(sfs:SmartFox) : void
      {
         var errors:Array = [];
         if(this._pos == null)
         {
            errors.push("Position must be a Vec3D instance");
         }
         if(this._room == null)
         {
            this._room = sfs.lastJoinedRoom;
         }
         if(this._room == null)
         {
            errors.push("You are not joined in any room");
         }
         if(!(this._room is MMORoom))
         {
            errors.push("Selected Room is not an MMORoom");
         }
         if(errors.length > 0)
         {
            throw new SFSValidationError("SetUserPosition request error",errors);
         }
      }
      
      override public function execute(sfs:SmartFox) : void
      {
         _sfso.putInt(KEY_ROOM,this._room.id);
         if(this._pos.isFloat())
         {
            _sfso.putFloatArray(KEY_VEC3D,this._pos.toArray());
         }
         else
         {
            _sfso.putIntArray(KEY_VEC3D,this._pos.toArray());
         }
      }
   }
}

