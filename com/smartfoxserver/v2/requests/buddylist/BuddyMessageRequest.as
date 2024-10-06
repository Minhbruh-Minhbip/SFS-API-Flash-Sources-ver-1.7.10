package com.smartfoxserver.v2.requests.buddylist
{
   import com.smartfoxserver.v2.entities.Buddy;
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   import com.smartfoxserver.v2.requests.GenericMessageRequest;
   import com.smartfoxserver.v2.requests.GenericMessageType;
   
   public class BuddyMessageRequest extends GenericMessageRequest
   {
      public function BuddyMessageRequest(message:String, targetBuddy:Buddy, params:ISFSObject = null)
      {
         super();
         _type = GenericMessageType.BUDDY_MSG;
         _message = message;
         _recipient = targetBuddy != null ? targetBuddy.id : -1;
         _params = params;
      }
   }
}

