package com.smartfoxserver.v2.entities.match
{
   public class RoomProperties
   {
      public static const NAME:String = "${N}";
      
      public static const GROUP_ID:String = "${G}";
      
      public static const MAX_USERS:String = "${MXU}";
      
      public static const MAX_SPECTATORS:String = "${MXS}";
      
      public static const USER_COUNT:String = "${UC}";
      
      public static const SPECTATOR_COUNT:String = "${SC}";
      
      public static const IS_GAME:String = "${ISG}";
      
      public static const IS_PRIVATE:String = "${ISP}";
      
      public static const HAS_FREE_PLAYER_SLOTS:String = "${HFP}";
      
      public static const IS_TYPE_SFSGAME:String = "${IST}";
      
      public function RoomProperties()
      {
         super();
         throw new ArgumentError("This class cannot be instantiated");
      }
   }
}

