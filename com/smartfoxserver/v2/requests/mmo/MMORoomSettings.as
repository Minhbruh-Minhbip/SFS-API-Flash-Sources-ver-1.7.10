package com.smartfoxserver.v2.requests.mmo
{
   import com.smartfoxserver.v2.entities.data.Vec3D;
   import com.smartfoxserver.v2.requests.RoomSettings;
   
   public class MMORoomSettings extends RoomSettings
   {
      private var _defaultAOI:Vec3D;
      
      private var _mapLimits:MapLimits;
      
      private var _userMaxLimboSeconds:int = 50;
      
      private var _proximityListUpdateMillis:int = 250;
      
      private var _sendAOIEntryPoint:Boolean = true;
      
      public function MMORoomSettings(name:String)
      {
         super(name);
      }
      
      public function get defaultAOI() : Vec3D
      {
         return this._defaultAOI;
      }
      
      public function get mapLimits() : MapLimits
      {
         return this._mapLimits;
      }
      
      public function get userMaxLimboSeconds() : int
      {
         return this._userMaxLimboSeconds;
      }
      
      public function get proximityListUpdateMillis() : int
      {
         return this._proximityListUpdateMillis;
      }
      
      public function get sendAOIEntryPoint() : Boolean
      {
         return this._sendAOIEntryPoint;
      }
      
      public function set defaultAOI(value:Vec3D) : void
      {
         this._defaultAOI = value;
      }
      
      public function set mapLimits(value:MapLimits) : void
      {
         this._mapLimits = value;
      }
      
      public function set userMaxLimboSeconds(value:int) : void
      {
         this._userMaxLimboSeconds = value;
      }
      
      public function set proximityListUpdateMillis(value:int) : void
      {
         this._proximityListUpdateMillis = value;
      }
      
      public function set sendAOIEntryPoint(value:Boolean) : void
      {
         this._sendAOIEntryPoint = value;
      }
   }
}

