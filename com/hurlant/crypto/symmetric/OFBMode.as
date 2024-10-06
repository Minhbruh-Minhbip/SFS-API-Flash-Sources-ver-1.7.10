package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class OFBMode extends IVMode implements IMode
   {
      public function OFBMode(key:ISymmetricKey, padding:IPad = null)
      {
         super(key,null);
      }
      
      public function toString() : String
      {
         return key.toString() + "-ofb";
      }
      
      private function core(src:ByteArray, iv:ByteArray) : void
      {
         var l:uint = 0;
         var tmp:ByteArray = null;
         var i:uint = 0;
         var chunk:uint = 0;
         var j:uint = 0;
         l = src.length;
         tmp = new ByteArray();
         for(i = 0; i < src.length; i += blockSize)
         {
            key.encrypt(iv);
            tmp.position = 0;
            tmp.writeBytes(iv);
            chunk = i + blockSize < l ? blockSize : uint(l - i);
            for(j = 0; j < chunk; j++)
            {
               src[i + j] ^= iv[j];
            }
            iv.position = 0;
            iv.writeBytes(tmp);
         }
      }
      
      public function decrypt(src:ByteArray) : void
      {
         var vector:ByteArray = null;
         vector = getIV4d();
         core(src,vector);
      }
      
      public function encrypt(src:ByteArray) : void
      {
         var vector:ByteArray = null;
         vector = getIV4e();
         core(src,vector);
      }
   }
}

