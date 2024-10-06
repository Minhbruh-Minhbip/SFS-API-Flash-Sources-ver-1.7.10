package com.smartfoxserver.v2.requests.mmo
{
   import com.smartfoxserver.v2.entities.data.Vec3D;
   
   public class MapLimits
   {
      private var _lowerLimit:Vec3D;
      
      private var _higherLimit:Vec3D;
      
      public function MapLimits(lowerLimit:Vec3D, higherLimit:Vec3D)
      {
         super();
         if(lowerLimit == null || higherLimit == null)
         {
            throw new ArgumentError("Map limits arguments must be both non null!");
         }
         this._lowerLimit = lowerLimit;
         this._higherLimit = higherLimit;
      }
      
      public function get lowerLimit() : Vec3D
      {
         return this._lowerLimit;
      }
      
      public function get higherLimit() : Vec3D
      {
         return this._higherLimit;
      }
   }
}

