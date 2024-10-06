package com.smartfoxserver.v2.requests
{
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   
   public class AdminMessageRequest extends GenericMessageRequest
   {
      public function AdminMessageRequest(message:String, recipientMode:MessageRecipientMode, params:ISFSObject = null)
      {
         super();
         if(recipientMode == null)
         {
            throw new ArgumentError("RecipientMode cannot be null!");
         }
         _type = GenericMessageType.ADMING_MSG;
         _message = message;
         _params = params;
         _recipient = recipientMode.target;
         _sendMode = recipientMode.mode;
      }
   }
}

