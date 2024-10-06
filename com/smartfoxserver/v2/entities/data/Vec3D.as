package com.smartfoxserver.v2.entities.data
{
   public class Vec3D
   {
      public static var useFloatCoordinates:Boolean = false;
      
      private var _px:Number;
      
      private var _py:Number;
      
      private var _pz:Number;
      
      public function Vec3D(px:Number, py:Number, pz:Number = 0)
      {
         super();
         this._px = px;
         this._py = py;
         this._pz = pz;
      }
      
      public static function fromArray(arr:Array) : Vec3D
      {
         return new Vec3D(arr[0],arr[1],arr[2]);
      }
      
      public function toString() : String
      {
         return "(" + this._px + ", " + this._py + ", " + this._pz + ")";
      }
      
      public function get px() : Number
      {
         return this._px;
      }
      
      public function get py() : Number
      {
         return this._py;
      }
      
      public function get pz() : Number
      {
         return this._pz;
      }
      
      public function isFloat() : Boolean
      {
         return useFloatCoordinates;
      }
      
      public function toArray() : Array
      {
         return [this._px,this._py,this._pz];
      }
   }
}

