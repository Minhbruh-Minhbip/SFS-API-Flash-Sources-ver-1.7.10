package com.smartfoxserver.v2.requests
{
   import com.smartfoxserver.v2.entities.Room;
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   
   public class PublicMessageRequest extends GenericMessageRequest
   {
      public function PublicMessageRequest(message:String, params:ISFSObject = null, targetRoom:Room = null)
      {
         super();
         _type = GenericMessageType.PUBLIC_MSG;
         _message = message;
         _room = targetRoom;
         _params = params;
      }
   }
}

