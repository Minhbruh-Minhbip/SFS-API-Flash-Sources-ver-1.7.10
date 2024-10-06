package com.smartfoxserver.v2.entities.match
{
   public class UserProperties
   {
      public static const NAME:String = "${N}";
      
      public static const IS_PLAYER:String = "${ISP}";
      
      public static const IS_SPECTATOR:String = "${ISS}";
      
      public static const IS_NPC:String = "${ISN}";
      
      public static const PRIVILEGE_ID:String = "${PRID}";
      
      public static const IS_IN_ANY_ROOM:String = "${IAR}";
      
      public function UserProperties()
      {
         super();
         throw new ArgumentError("This class cannot be instantiated");
      }
   }
}

