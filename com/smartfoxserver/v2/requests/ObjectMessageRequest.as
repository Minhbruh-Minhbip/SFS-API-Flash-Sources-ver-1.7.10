package com.smartfoxserver.v2.requests
{
   import com.smartfoxserver.v2.entities.Room;
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   
   public class ObjectMessageRequest extends GenericMessageRequest
   {
      public function ObjectMessageRequest(obj:ISFSObject, targetRoom:Room = null, recipients:Array = null)
      {
         super();
         _type = GenericMessageType.OBJECT_MSG;
         _params = obj;
         _room = targetRoom;
         _recipient = recipients;
      }
   }
}

