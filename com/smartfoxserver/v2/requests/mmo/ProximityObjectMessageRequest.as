package com.smartfoxserver.v2.requests.mmo
{
   internal class ProximityObjectMessageRequest extends ObjectMessageRequest
   {
      public function ProximityObjectMessageRequest(obj:ISFSObject, targetRoom:Room, aoi:Vec3D)
      {
         super(obj,targetRoom,null);
         _aoi = aoi;
      }
      
      override public function validate(sfs:SmartFox) : void
      {
         var errors:Array = [];
         if(_params == null)
         {
            errors.push("Object message is null!");
         }
         if(!(_room is MMORoom))
         {
            errors.push("Target Room is not an MMORoom");
         }
         if(_aoi == null)
         {
            errors.push("AOI cannot be null");
         }
         if(errors.length > 0)
         {
            throw new SFSValidationError("Request error - ",errors);
         }
      }
      
      override public function execute(sfs:SmartFox) : void
      {
         super.execute(sfs);
         if(_aoi.isFloat())
         {
            _sfso.putFloatArray(KEY_AOI,_aoi.toArray());
         }
         else
         {
            _sfso.putIntArray(KEY_AOI,_aoi.toArray());
         }
      }
   }
}

