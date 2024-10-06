package com.smartfoxserver.v2.entities
{
   import com.smartfoxserver.v2.entities.data.Vec3D;
   import com.smartfoxserver.v2.kernel;
   import com.smartfoxserver.v2.util.ArrayUtil;
   
   use namespace kernel;
   
   public class MMORoom extends SFSRoom
   {
      private var _defaultAOI:Vec3D;
      
      private var _lowerMapLimit:Vec3D;
      
      private var _higherMapLimit:Vec3D;
      
      private var _itemsById:Object;
      
      public function MMORoom(id:int, name:String, groupId:String = "default")
      {
         this._itemsById = {};
         super(id,name,groupId);
      }
      
      public function get defaultAOI() : Vec3D
      {
         return this._defaultAOI;
      }
      
      public function get lowerMapLimit() : Vec3D
      {
         return this._lowerMapLimit;
      }
      
      public function get higherMapLimit() : Vec3D
      {
         return this._higherMapLimit;
      }
      
      public function set defaultAOI(value:Vec3D) : void
      {
         if(this._defaultAOI != null)
         {
            throw new ArgumentError("This value is read-only");
         }
         this._defaultAOI = value;
      }
      
      public function set lowerMapLimit(value:Vec3D) : void
      {
         if(this._lowerMapLimit != null)
         {
            throw new ArgumentError("This value is read-only");
         }
         this._lowerMapLimit = value;
      }
      
      public function set higherMapLimit(value:Vec3D) : void
      {
         if(this._higherMapLimit != null)
         {
            throw new ArgumentError("This value is read-only");
         }
         this._higherMapLimit = value;
      }
      
      public function getMMOItem(id:int) : IMMOItem
      {
         return this._itemsById[id];
      }
      
      public function getMMOItems() : Array
      {
         return ArrayUtil.objToArray(this._itemsById);
      }
      
      kernel function addMMOItem(item:IMMOItem) : void
      {
         this._itemsById[item.id] = item;
      }
      
      kernel function removeItem(id:int) : void
      {
         delete this._itemsById[id];
      }
   }
}

