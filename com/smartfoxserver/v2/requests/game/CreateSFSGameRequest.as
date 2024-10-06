package com.smartfoxserver.v2.requests.game
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.entities.Buddy;
   import com.smartfoxserver.v2.entities.User;
   import com.smartfoxserver.v2.exceptions.SFSValidationError;
   import com.smartfoxserver.v2.requests.BaseRequest;
   import com.smartfoxserver.v2.requests.CreateRoomRequest;
   
   public class CreateSFSGameRequest extends BaseRequest
   {
      public static const KEY_IS_PUBLIC:String = "gip";
      
      public static const KEY_MIN_PLAYERS:String = "gmp";
      
      public static const KEY_INVITED_PLAYERS:String = "ginp";
      
      public static const KEY_SEARCHABLE_ROOMS:String = "gsr";
      
      public static const KEY_PLAYER_MATCH_EXP:String = "gpme";
      
      public static const KEY_SPECTATOR_MATCH_EXP:String = "gsme";
      
      public static const KEY_INVITATION_EXPIRY:String = "gie";
      
      public static const KEY_LEAVE_ROOM:String = "glr";
      
      public static const KEY_NOTIFY_GAME_STARTED:String = "gns";
      
      public static const KEY_INVITATION_PARAMS:String = "ip";
      
      private var _createRoomRequest:CreateRoomRequest;
      
      private var _settings:SFSGameSettings;
      
      public function CreateSFSGameRequest(settings:SFSGameSettings)
      {
         super(BaseRequest.CreateSFSGame);
         this._settings = settings;
         this._createRoomRequest = new CreateRoomRequest(settings,false,null);
      }
      
      override public function validate(sfs:SmartFox) : void
      {
         var errors:Array = [];
         try
         {
            this._createRoomRequest.validate(sfs);
         }
         catch(err:SFSValidationError)
         {
            errors = err.errors;
         }
         if(this._settings.minPlayersToStartGame > this._settings.maxUsers)
         {
            errors.push("minPlayersToStartGame cannot be greater than maxUsers");
         }
         if(this._settings.invitationExpiryTime < InviteUsersRequest.MIN_EXPIRY_TIME || this._settings.invitationExpiryTime > InviteUsersRequest.MAX_EXPIRY_TIME)
         {
            errors.push("Expiry time value is out of range (" + InviteUsersRequest.MIN_EXPIRY_TIME + "-" + InviteUsersRequest.MAX_EXPIRY_TIME + ")");
         }
         if(this._settings.invitedPlayers != null && this._settings.invitedPlayers.length > InviteUsersRequest.MAX_INVITATIONS_FROM_CLIENT_SIDE)
         {
            errors.push("Cannot invite more than " + InviteUsersRequest.MAX_INVITATIONS_FROM_CLIENT_SIDE + " players from client side");
         }
         if(errors.length > 0)
         {
            throw new SFSValidationError("CreateSFSGameRoom request error",errors);
         }
      }
      
      override public function execute(sfs:SmartFox) : void
      {
         var playerIds:Array = null;
         var player:* = undefined;
         this._createRoomRequest.execute(sfs);
         _sfso = this._createRoomRequest.getMessage().content;
         _sfso.putBool(KEY_IS_PUBLIC,this._settings.isPublic);
         _sfso.putShort(KEY_MIN_PLAYERS,this._settings.minPlayersToStartGame);
         _sfso.putShort(KEY_INVITATION_EXPIRY,this._settings.invitationExpiryTime);
         _sfso.putBool(KEY_LEAVE_ROOM,this._settings.leaveLastJoinedRoom);
         _sfso.putBool(KEY_NOTIFY_GAME_STARTED,this._settings.notifyGameStarted);
         if(this._settings.playerMatchExpression != null)
         {
            _sfso.putSFSArray(KEY_PLAYER_MATCH_EXP,this._settings.playerMatchExpression.toSFSArray());
         }
         if(this._settings.spectatorMatchExpression != null)
         {
            _sfso.putSFSArray(KEY_SPECTATOR_MATCH_EXP,this._settings.spectatorMatchExpression.toSFSArray());
         }
         if(this._settings.invitedPlayers != null)
         {
            playerIds = [];
            for each(player in this._settings.invitedPlayers)
            {
               if(player is User || player is Buddy)
               {
                  playerIds.push(player.id);
               }
            }
            _sfso.putIntArray(KEY_INVITED_PLAYERS,playerIds);
         }
         if(this._settings.searchableRooms != null)
         {
            _sfso.putUtfStringArray(KEY_SEARCHABLE_ROOMS,this._settings.searchableRooms);
         }
         if(this._settings.invitationParams != null)
         {
            _sfso.putSFSObject(KEY_INVITATION_PARAMS,this._settings.invitationParams);
         }
      }
   }
}

