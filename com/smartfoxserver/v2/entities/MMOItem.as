package com.smartfoxserver.v2.entities
{
   import com.smartfoxserver.v2.entities.data.ISFSArray;
   import com.smartfoxserver.v2.entities.data.Vec3D;
   import com.smartfoxserver.v2.entities.variables.IMMOItemVariable;
   import com.smartfoxserver.v2.entities.variables.MMOItemVariable;
   
   public class MMOItem implements IMMOItem
   {
      private var _id:int;
      
      private var _variables:Object;
      
      private var _aoiEntryPoint:Vec3D;
      
      public function MMOItem(id:int)
      {
         super();
         this._id = id;
         this._variables = {};
      }
      
      public static function fromSFSArray(encodedItem:ISFSArray) : IMMOItem
      {
         var item:IMMOItem = new MMOItem(encodedItem.getElementAt(0));
         var encodedVars:ISFSArray = encodedItem.getSFSArray(1);
         for(var i:int = 0; i < encodedVars.size(); i++)
         {
            item.setVariable(MMOItemVariable.fromSFSArray(encodedVars.getSFSArray(i)));
         }
         return item;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function getVariables() : Array
      {
         var uv:IMMOItemVariable = null;
         var variables:Array = [];
         for each(uv in this._variables)
         {
         }
         variables.push(uv);
         return variables;
      }
      
      public function getVariable(name:String) : IMMOItemVariable
      {
         return this._variables[name];
      }
      
      public function setVariable(itemVariable:IMMOItemVariable) : void
      {
         if(itemVariable != null)
         {
            if(itemVariable.isNull())
            {
               delete this._variables[itemVariable.name];
            }
            else
            {
               this._variables[itemVariable.name] = itemVariable;
            }
         }
      }
      
      public function setVariables(itemVariables:Array) : void
      {
         var itemVar:IMMOItemVariable = null;
         for each(itemVar in itemVariables)
         {
            this.setVariable(itemVar);
         }
      }
      
      public function containsVariable(name:String) : Boolean
      {
         return this._variables[name] != null;
      }
      
      public function get aoiEntryPoint() : Vec3D
      {
         return this._aoiEntryPoint;
      }
      
      public function set aoiEntryPoint(loc:Vec3D) : void
      {
         this._aoiEntryPoint = loc;
      }
      
      public function toString() : String
      {
         return "[Item: " + this._id + "]";
      }
   }
}

