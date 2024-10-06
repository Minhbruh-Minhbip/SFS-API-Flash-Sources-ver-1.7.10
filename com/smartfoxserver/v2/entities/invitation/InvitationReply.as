package com.smartfoxserver.v2.entities.invitation
{
   public class InvitationReply
   {
      public static const ACCEPT:int = 0;
      
      public static const REFUSE:int = 1;
      
      public static const EXPIRED:int = 255;
      
      public function InvitationReply()
      {
         super();
         throw new ArgumentError("This class cannot be instantiated");
      }
      
      public static function fromCode(code:int) : String
      {
         var result:String = null;
         switch(code)
         {
            case 0:
               result = "ACCEPTED";
               break;
            case 1:
               result = "REFUSED";
               break;
            case 255:
               result = "EXPIRED";
               break;
            default:
               result = "UNKNOWN";
         }
         return result;
      }
   }
}

