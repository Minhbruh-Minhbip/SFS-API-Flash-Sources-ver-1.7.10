package com.smartfoxserver.v2.requests.game
{
   import com.smartfoxserver.v2.entities.data.ISFSObject;
   import com.smartfoxserver.v2.entities.match.MatchExpression;
   import com.smartfoxserver.v2.requests.RoomSettings;
   
   public class SFSGameSettings extends RoomSettings
   {
      private var _isPublic:Boolean;
      
      private var _minPlayersToStartGame:int;
      
      private var _invitedPlayers:Array;
      
      private var _searchableRooms:Array;
      
      private var _playerMatchExpression:MatchExpression;
      
      private var _spectatorMatchExpression:MatchExpression;
      
      private var _invitationExpiryTime:int;
      
      private var _leaveLastJoinedRoom:Boolean;
      
      private var _notifyGameStarted:Boolean;
      
      private var _invitationParams:ISFSObject;
      
      public function SFSGameSettings(name:String)
      {
         super(name);
         this._isPublic = true;
         this._minPlayersToStartGame = 2;
         this._invitationExpiryTime = 15;
         this._leaveLastJoinedRoom = true;
      }
      
      public function get isPublic() : Boolean
      {
         return this._isPublic;
      }
      
      public function get minPlayersToStartGame() : int
      {
         return this._minPlayersToStartGame;
      }
      
      public function get invitedPlayers() : Array
      {
         return this._invitedPlayers;
      }
      
      public function get searchableRooms() : Array
      {
         return this._searchableRooms;
      }
      
      public function get invitationExpiryTime() : int
      {
         return this._invitationExpiryTime;
      }
      
      public function get leaveLastJoinedRoom() : Boolean
      {
         return this._leaveLastJoinedRoom;
      }
      
      public function get notifyGameStarted() : Boolean
      {
         return this._notifyGameStarted;
      }
      
      public function get playerMatchExpression() : MatchExpression
      {
         return this._playerMatchExpression;
      }
      
      public function get spectatorMatchExpression() : MatchExpression
      {
         return this._spectatorMatchExpression;
      }
      
      public function get invitationParams() : ISFSObject
      {
         return this._invitationParams;
      }
      
      public function set isPublic(value:Boolean) : void
      {
         this._isPublic = value;
      }
      
      public function set minPlayersToStartGame(value:int) : void
      {
         this._minPlayersToStartGame = value;
      }
      
      public function set invitedPlayers(value:Array) : void
      {
         this._invitedPlayers = value;
      }
      
      public function set searchableRooms(value:Array) : void
      {
         this._searchableRooms = value;
      }
      
      public function set invitationExpiryTime(value:int) : void
      {
         this._invitationExpiryTime = value;
      }
      
      public function set leaveLastJoinedRoom(value:Boolean) : void
      {
         this._leaveLastJoinedRoom = value;
      }
      
      public function set notifyGameStarted(value:Boolean) : void
      {
         this._notifyGameStarted = value;
      }
      
      public function set playerMatchExpression(value:MatchExpression) : void
      {
         this._playerMatchExpression = value;
      }
      
      public function set spectatorMatchExpression(value:MatchExpression) : void
      {
         this._spectatorMatchExpression = value;
      }
      
      public function set invitationParams(value:ISFSObject) : void
      {
         this._invitationParams = value;
      }
   }
}

