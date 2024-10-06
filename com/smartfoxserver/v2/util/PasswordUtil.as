package com.smartfoxserver.v2.util
{
   import com.hurlant.crypto.hash.IHash;
   import com.hurlant.crypto.hash.MD5;
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   
   public class PasswordUtil
   {
      public function PasswordUtil()
      {
         super();
      }
      
      public static function md5Password(pass:String) : String
      {
         var hash:IHash = new MD5();
         var data:ByteArray = Hex.toArray(Hex.fromString(pass));
         return Hex.fromArray(hash.hash(data));
      }
   }
}

