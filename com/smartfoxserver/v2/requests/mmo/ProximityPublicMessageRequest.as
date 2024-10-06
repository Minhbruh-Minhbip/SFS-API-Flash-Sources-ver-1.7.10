package com.smartfoxserver.v2.requests.mmo
{
   internal class ProximityPublicMessageRequest extends PublicMessageRequest
   {
      public function ProximityPublicMessageRequest(message:String, targetRoom:Room, aoi:Vec3D, params:ISFSObject = null)
      {
         super(message,params,targetRoom);
         _aoi = aoi;
      }
      
      override public function validate(sfs:SmartFox) : void
      {
         var errors:Array = [];
         if(_message == null || _message.length == 0)
         {
            errors.push("Public message is empty!");
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

