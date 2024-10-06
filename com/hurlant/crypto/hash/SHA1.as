package com.hurlant.crypto.hash
{
   public class SHA1 extends SHABase implements IHash
   {
      public static const HASH_SIZE:int = 20;
      
      public function SHA1()
      {
         super();
      }
      
      private function ft(t:uint, b:uint, c:uint, d:uint) : uint
      {
         if(t < 20)
         {
            return b & c | ~b & d;
         }
         if(t < 40)
         {
            return b ^ c ^ d;
         }
         if(t < 60)
         {
            return b & c | b & d | c & d;
         }
         return b ^ c ^ d;
      }
      
      private function kt(t:uint) : uint
      {
         return t < 20 ? 1518500249 : (t < 40 ? 1859775393 : (t < 60 ? uint(2400959708) : uint(3395469782)));
      }
      
      override public function toString() : String
      {
         return "sha1";
      }
      
      override public function getHashSize() : uint
      {
         return HASH_SIZE;
      }
      
      private function rol(num:uint, cnt:uint) : uint
      {
         return num << cnt | num >>> 32 - cnt;
      }
      
      override protected function core(x:Array, len:uint) : Array
      {
         var w:Array = null;
         var a:uint = 0;
         var b:uint = 0;
         var c:uint = 0;
         var d:uint = 0;
         var e:uint = 0;
         var i:uint = 0;
         var olda:uint = 0;
         var oldb:uint = 0;
         var oldc:uint = 0;
         var oldd:uint = 0;
         var olde:uint = 0;
         var j:uint = 0;
         var t:uint = 0;
         x[len >> 5] |= 128 << 24 - len % 32;
         x[(len + 64 >> 9 << 4) + 15] = len;
         w = [];
         a = 1732584193;
         b = 4023233417;
         c = 2562383102;
         d = 271733878;
         e = 3285377520;
         for(i = 0; i < x.length; i += 16)
         {
            olda = a;
            oldb = b;
            oldc = c;
            oldd = d;
            olde = e;
            for(j = 0; j < 80; j++)
            {
               if(j < 16)
               {
                  w[j] = x[i + j] || 0;
               }
               else
               {
                  w[j] = rol(w[j - 3] ^ w[j - 8] ^ w[j - 14] ^ w[j - 16],1);
               }
               t = rol(a,5) + ft(j,b,c,d) + e + w[j] + kt(j);
               e = d;
               d = c;
               c = rol(b,30);
               b = a;
               a = t;
            }
            a += olda;
            b += oldb;
            c += oldc;
            d += oldd;
            e += olde;
         }
         return [a,b,c,d,e];
      }
   }
}

