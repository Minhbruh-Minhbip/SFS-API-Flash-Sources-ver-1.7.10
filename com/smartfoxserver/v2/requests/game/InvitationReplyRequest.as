package com.smartfoxserver.v2.requests.game
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   import com.smartfoxserver.v2.entities.invitation.Invitation;
   import com.smartfoxserver.v2.exceptions.SFSValidationError;
   import com.smartfoxserver.v2.requests.BaseRequest;
   
   public class InvitationReplyRequest extends BaseRequest
   {
      public static const KEY_INVITATION_ID:String = "i";
      
      public static const KEY_INVITATION_REPLY:String = "r";
      
      public static const KEY_INVITATION_PARAMS:String = "p";
      
      private var _invitation:Invitation;
      
      private var _reply:int;
      
      private var _params:ISFSObject;
      
      public function InvitationReplyRequest(invitation:Invitation, invitationReply:int, params:ISFSObject = null)
      {
         super(BaseRequest.InvitationReply);
         this._invitation = invitation;
         this._reply = invitationReply;
         this._params = params;
      }
      
      override public function validate(sfs:SmartFox) : void
      {
         var errors:Array = [];
         if(this._invitation == null)
         {
            errors.push("Missing invitation object");
         }
         if(errors.length > 0)
         {
            throw new SFSValidationError("InvitationReply request error",errors);
         }
      }
      
      override public function execute(sfs:SmartFox) : void
      {
         _sfso.putInt(KEY_INVITATION_ID,this._invitation.id);
         _sfso.putByte(KEY_INVITATION_REPLY,this._reply);
         if(this._params != null)
         {
            _sfso.putSFSObject(KEY_INVITATION_PARAMS,this._params);
         }
      }
   }
}

