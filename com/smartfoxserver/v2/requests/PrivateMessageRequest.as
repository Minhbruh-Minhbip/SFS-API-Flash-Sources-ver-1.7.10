package com.smartfoxserver.v2.requests
{
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   
   public class PrivateMessageRequest extends GenericMessageRequest
   {
      public function PrivateMessageRequest(message:String, recipientId:int, params:ISFSObject = null)
      {
         super();
         _type = GenericMessageType.PRIVATE_MSG;
         _message = message;
         _recipient = recipientId;
         _params = params;
      }
   }
}

