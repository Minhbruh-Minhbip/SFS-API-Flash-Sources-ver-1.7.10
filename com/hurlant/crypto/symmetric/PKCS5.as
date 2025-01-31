package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class PKCS5 implements IPad
   {
      private var blockSize:uint;
      
      public function PKCS5(blockSize:uint = 0)
      {
         super();
         this.blockSize = blockSize;
      }
      
      public function unpad(a:ByteArray) : void
      {
         var c:uint = 0;
         var i:uint = 0;
         var v:uint = 0;
         c = a.length % blockSize;
         if(c != 0)
         {
            throw new Error("PKCS#5::unpad: ByteArray.length isn\'t a multiple of the blockSize");
         }
         c = uint(a[a.length - 1]);
         for(i = c; i > 0; i--)
         {
            v = uint(a[a.length - 1]);
            --a.length;
            if(c != v)
            {
               throw new Error("PKCS#5:unpad: Invalid padding value. expected [" + c + "], found [" + v + "]");
            }
         }
      }
      
      public function pad(a:ByteArray) : void
      {
         var c:uint = 0;
         var i:uint = 0;
         c = blockSize - a.length % blockSize;
         for(i = 0; i < c; i++)
         {
            a[a.length] = c;
         }
      }
      
      public function setBlockSize(bs:uint) : void
      {
         blockSize = bs;
      }
   }
}

