package com.smartfoxserver.v2.requests
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.exceptions.SFSValidationError;
   
   public class KickUserRequest extends BaseRequest
   {
      public static const KEY_USER_ID:String = "u";
      
      public static const KEY_MESSAGE:String = "m";
      
      public static const KEY_DELAY:String = "d";
      
      private var _userId:int;
      
      private var _message:String;
      
      private var _delay:int;
      
      public function KickUserRequest(userId:int, message:String = null, delaySeconds:int = 5)
      {
         super(BaseRequest.KickUser);
         this._userId = userId;
         this._message = message;
         this._delay = delaySeconds;
         if(this._delay < 0)
         {
            this._delay = 0;
         }
      }
      
      override public function validate(sfs:SmartFox) : void
      {
         var errors:Array = [];
         if(errors.length > 0)
         {
            throw new SFSValidationError("KickUser request error",errors);
         }
      }
      
      override public function execute(sfs:SmartFox) : void
      {
         _sfso.putInt(KEY_USER_ID,this._userId);
         _sfso.putInt(KEY_DELAY,this._delay);
         if(this._message != null && this._message.length > 0)
         {
            _sfso.putUtfString(KEY_MESSAGE,this._message);
         }
      }
   }
}

