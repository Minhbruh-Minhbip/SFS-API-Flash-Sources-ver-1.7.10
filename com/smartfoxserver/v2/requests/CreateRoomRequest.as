package com.smartfoxserver.v2.requests
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.entities.Room;
   import com.smartfoxserver.v2.entities.data.ISFSArray;
   import com.smartfoxserver.v2.entities.data.SFSArray;
   import com.smartfoxserver.v2.entities.variables.RoomVariable;
   import com.smartfoxserver.v2.exceptions.SFSValidationError;
   import com.smartfoxserver.v2.requests.mmo.MMORoomSettings;
   
   public class CreateRoomRequest extends BaseRequest
   {
      public static const KEY_ROOM:String = "r";
      
      public static const KEY_NAME:String = "n";
      
      public static const KEY_PASSWORD:String = "p";
      
      public static const KEY_GROUP_ID:String = "g";
      
      public static const KEY_ISGAME:String = "ig";
      
      public static const KEY_MAXUSERS:String = "mu";
      
      public static const KEY_MAXSPECTATORS:String = "ms";
      
      public static const KEY_MAXVARS:String = "mv";
      
      public static const KEY_ROOMVARS:String = "rv";
      
      public static const KEY_PERMISSIONS:String = "pm";
      
      public static const KEY_EVENTS:String = "ev";
      
      public static const KEY_EXTID:String = "xn";
      
      public static const KEY_EXTCLASS:String = "xc";
      
      public static const KEY_EXTPROP:String = "xp";
      
      public static const KEY_AUTOJOIN:String = "aj";
      
      public static const KEY_ROOM_TO_LEAVE:String = "rl";
      
      public static const KEY_ALLOW_JOIN_INVITATION_BY_OWNER:String = "aji";
      
      public static const KEY_MMO_DEFAULT_AOI:String = "maoi";
      
      public static const KEY_MMO_MAP_LOW_LIMIT:String = "mllm";
      
      public static const KEY_MMO_MAP_HIGH_LIMIT:String = "mlhm";
      
      public static const KEY_MMO_USER_MAX_LIMBO_SECONDS:String = "muls";
      
      public static const KEY_MMO_PROXIMITY_UPDATE_MILLIS:String = "mpum";
      
      public static const KEY_MMO_SEND_ENTRY_POINT:String = "msep";
      
      protected var _settings:RoomSettings;
      
      protected var _autoJoin:Boolean;
      
      protected var _roomToLeave:Room;
      
      public function CreateRoomRequest(settings:RoomSettings, autoJoin:Boolean = false, roomToLeave:Room = null)
      {
         super(BaseRequest.CreateRoom);
         this._settings = settings;
         this._autoJoin = autoJoin;
         this._roomToLeave = roomToLeave;
      }
      
      override public function execute(sfs:SmartFox) : void
      {
         var roomVars:ISFSArray = null;
         var item:* = undefined;
         var rVar:RoomVariable = null;
         var sfsPermissions:Array = null;
         var sfsEvents:Array = null;
         var mmoSettings:MMORoomSettings = null;
         var useFloats:Boolean = false;
         _sfso.putUtfString(KEY_NAME,this._settings.name);
         _sfso.putUtfString(KEY_GROUP_ID,this._settings.groupId);
         _sfso.putUtfString(KEY_PASSWORD,this._settings.password);
         _sfso.putBool(KEY_ISGAME,this._settings.isGame);
         _sfso.putShort(KEY_MAXUSERS,this._settings.maxUsers);
         _sfso.putShort(KEY_MAXSPECTATORS,this._settings.maxSpectators);
         _sfso.putShort(KEY_MAXVARS,this._settings.maxVariables);
         _sfso.putBool(KEY_ALLOW_JOIN_INVITATION_BY_OWNER,this._settings.allowOwnerOnlyInvitation);
         if(this._settings.variables != null && this._settings.variables.length > 0)
         {
            roomVars = SFSArray.newInstance();
            for each(item in this._settings.variables)
            {
               if(item is RoomVariable)
               {
                  rVar = item as RoomVariable;
                  roomVars.addSFSArray(rVar.toSFSArray());
               }
            }
            _sfso.putSFSArray(KEY_ROOMVARS,roomVars);
         }
         if(this._settings.permissions != null)
         {
            sfsPermissions = [];
            sfsPermissions.push(this._settings.permissions.allowNameChange);
            sfsPermissions.push(this._settings.permissions.allowPasswordStateChange);
            sfsPermissions.push(this._settings.permissions.allowPublicMessages);
            sfsPermissions.push(this._settings.permissions.allowResizing);
            _sfso.putBoolArray(KEY_PERMISSIONS,sfsPermissions);
         }
         if(this._settings.events != null)
         {
            sfsEvents = [];
            sfsEvents.push(this._settings.events.allowUserEnter);
            sfsEvents.push(this._settings.events.allowUserExit);
            sfsEvents.push(this._settings.events.allowUserCountChange);
            sfsEvents.push(this._settings.events.allowUserVariablesUpdate);
            _sfso.putBoolArray(KEY_EVENTS,sfsEvents);
         }
         if(this._settings.extension != null)
         {
            _sfso.putUtfString(KEY_EXTID,this._settings.extension.id);
            _sfso.putUtfString(KEY_EXTCLASS,this._settings.extension.className);
            if(this._settings.extension.propertiesFile != null && this._settings.extension.propertiesFile.length > 0)
            {
               _sfso.putUtfString(KEY_EXTPROP,this._settings.extension.propertiesFile);
            }
         }
         if(this._settings is MMORoomSettings)
         {
            mmoSettings = this._settings as MMORoomSettings;
            useFloats = mmoSettings.defaultAOI.isFloat();
            if(useFloats)
            {
               _sfso.putFloatArray(KEY_MMO_DEFAULT_AOI,mmoSettings.defaultAOI.toArray());
               if(mmoSettings.mapLimits != null)
               {
                  _sfso.putFloatArray(KEY_MMO_MAP_LOW_LIMIT,mmoSettings.mapLimits.lowerLimit.toArray());
                  _sfso.putFloatArray(KEY_MMO_MAP_HIGH_LIMIT,mmoSettings.mapLimits.higherLimit.toArray());
               }
            }
            else
            {
               _sfso.putIntArray(KEY_MMO_DEFAULT_AOI,mmoSettings.defaultAOI.toArray());
               if(mmoSettings.mapLimits != null)
               {
                  _sfso.putIntArray(KEY_MMO_MAP_LOW_LIMIT,mmoSettings.mapLimits.lowerLimit.toArray());
                  _sfso.putIntArray(KEY_MMO_MAP_HIGH_LIMIT,mmoSettings.mapLimits.higherLimit.toArray());
               }
            }
            _sfso.putShort(KEY_MMO_USER_MAX_LIMBO_SECONDS,mmoSettings.userMaxLimboSeconds);
            _sfso.putShort(KEY_MMO_PROXIMITY_UPDATE_MILLIS,mmoSettings.proximityListUpdateMillis);
            _sfso.putBool(KEY_MMO_SEND_ENTRY_POINT,mmoSettings.sendAOIEntryPoint);
         }
         _sfso.putBool(KEY_AUTOJOIN,this._autoJoin);
         if(this._roomToLeave != null)
         {
            _sfso.putInt(KEY_ROOM_TO_LEAVE,this._roomToLeave.id);
         }
      }
      
      override public function validate(sfs:SmartFox) : void
      {
         var mmoSettings:MMORoomSettings = null;
         var errors:Array = [];
         if(this._settings.name == null || this._settings.name.length == 0)
         {
            errors.push("Missing room name");
         }
         if(this._settings.maxUsers <= 0)
         {
            errors.push("maxUsers must be > 0");
         }
         if(this._settings.extension != null)
         {
            if(this._settings.extension.className == null || this._settings.extension.className.length == 0)
            {
               errors.push("Missing Extension class name");
            }
            if(this._settings.extension.id == null || this._settings.extension.id.length == 0)
            {
               errors.push("Missing Extension id");
            }
         }
         if(this._settings is MMORoomSettings)
         {
            mmoSettings = this._settings as MMORoomSettings;
            if(mmoSettings.defaultAOI == null)
            {
               errors.push("Missing default AoI (Area of Interest)");
            }
            if(mmoSettings.mapLimits != null && (mmoSettings.mapLimits.lowerLimit == null || mmoSettings.mapLimits.higherLimit == null))
            {
               errors.push("Map limits must be both defined");
            }
         }
         if(errors.length > 0)
         {
            throw new SFSValidationError("CreateRoom request error",errors);
         }
      }
   }
}

