package com.smartfoxserver.v2.requests.game
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.entities.Room;
   import com.smartfoxserver.v2.entities.match.MatchExpression;
   import com.smartfoxserver.v2.exceptions.SFSValidationError;
   import com.smartfoxserver.v2.requests.BaseRequest;
   
   public class QuickJoinGameRequest extends BaseRequest
   {
      private static const MAX_ROOMS:int = 32;
      
      public static const KEY_ROOM_LIST:String = "rl";
      
      public static const KEY_GROUP_LIST:String = "gl";
      
      public static const KEY_ROOM_TO_LEAVE:String = "tl";
      
      public static const KEY_MATCH_EXPRESSION:String = "me";
      
      private var _whereToSearch:Array;
      
      private var _matchExpression:MatchExpression;
      
      private var _roomToLeave:Room;
      
      public function QuickJoinGameRequest(matchExpression:MatchExpression, whereToSearch:Array, roomToLeave:Room = null)
      {
         super(BaseRequest.QuickJoinGame);
         this._matchExpression = matchExpression;
         this._whereToSearch = whereToSearch;
         this._roomToLeave = roomToLeave;
      }
      
      override public function validate(sfs:SmartFox) : void
      {
         var errors:Array = [];
         if(this._whereToSearch == null || this._whereToSearch.length < 1)
         {
            errors.push("Missing whereToSearch parameter");
         }
         else if(this._whereToSearch.length > MAX_ROOMS)
         {
            errors.push("Too many Rooms specified in the whereToSearch parameter. Client limit is: " + MAX_ROOMS);
         }
         if(errors.length > 0)
         {
            throw new SFSValidationError("QuickJoinGame request error",errors);
         }
      }
      
      override public function execute(sfs:SmartFox) : void
      {
         var roomIds:Array = null;
         var i:int = 0;
         var item:* = undefined;
         if(this._whereToSearch[0] is String)
         {
            _sfso.putUtfStringArray(KEY_GROUP_LIST,this._whereToSearch);
         }
         else
         {
            if(!(this._whereToSearch[0] is Room))
            {
               throw new ArgumentError("Invalid type in whereToSearch parameter: " + this._whereToSearch[0]);
            }
            roomIds = [];
            for(i = 0; i < this._whereToSearch.length; i++)
            {
               item = this._whereToSearch[i];
               if(item is Room)
               {
                  roomIds.push((item as Room).id);
               }
            }
            _sfso.putIntArray(KEY_ROOM_LIST,roomIds);
         }
         if(this._roomToLeave != null)
         {
            _sfso.putInt(KEY_ROOM_TO_LEAVE,this._roomToLeave.id);
         }
         if(this._matchExpression != null)
         {
            _sfso.putSFSArray(KEY_MATCH_EXPRESSION,this._matchExpression.toSFSArray());
         }
      }
   }
}

