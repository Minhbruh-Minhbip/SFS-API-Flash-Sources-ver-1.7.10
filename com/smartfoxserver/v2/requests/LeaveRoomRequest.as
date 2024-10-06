package com.smartfoxserver.v2.requests
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.entities.Room;
   import com.smartfoxserver.v2.exceptions.SFSValidationError;
   
   public class LeaveRoomRequest extends BaseRequest
   {
      public static const KEY_ROOM_ID:String = "r";
      
      private var _room:Room;
      
      public function LeaveRoomRequest(theRoom:Room = null)
      {
         super(BaseRequest.LeaveRoom);
         this._room = theRoom;
      }
      
      override public function validate(sfs:SmartFox) : void
      {
         var errors:Array = [];
         if(sfs.joinedRooms.length < 1)
         {
            errors.push("You are not joined in any rooms");
         }
         if(errors.length > 0)
         {
            throw new SFSValidationError("LeaveRoom request error",errors);
         }
      }
      
      override public function execute(sfs:SmartFox) : void
      {
         if(this._room != null)
         {
            _sfso.putInt(KEY_ROOM_ID,this._room.id);
         }
      }
   }
}

