package com.hurlant.crypto.rsa
{
   import com.hurlant.crypto.prng.Random;
   import com.hurlant.math.BigInteger;
   import com.hurlant.util.Memory;
   import flash.utils.ByteArray;
   
   public class RSAKey
   {
      public var dmp1:BigInteger;
      
      protected var canDecrypt:Boolean;
      
      public var d:BigInteger;
      
      public var e:int;
      
      public var dmq1:BigInteger;
      
      public var n:BigInteger;
      
      public var p:BigInteger;
      
      public var q:BigInteger;
      
      protected var canEncrypt:Boolean;
      
      public var coeff:BigInteger;
      
      public function RSAKey(N:BigInteger, E:int, D:BigInteger = null, P:BigInteger = null, Q:BigInteger = null, DP:BigInteger = null, DQ:BigInteger = null, C:BigInteger = null)
      {
         super();
         this.n = N;
         this.e = E;
         this.d = D;
         this.p = P;
         this.q = Q;
         this.dmp1 = DP;
         this.dmq1 = DQ;
         this.coeff = C;
         canEncrypt = n != null && e != 0;
         canDecrypt = canEncrypt && d != null;
      }
      
      protected static function bigRandom(bits:int, rnd:Random) : BigInteger
      {
         var x:ByteArray = null;
         var b:BigInteger = null;
         if(bits < 2)
         {
            return BigInteger.nbv(1);
         }
         x = new ByteArray();
         rnd.nextBytes(x,bits >> 3);
         x.position = 0;
         b = new BigInteger(x);
         b.primify(bits,1);
         return b;
      }
      
      public static function parsePublicKey(N:String, E:String) : RSAKey
      {
         return new RSAKey(new BigInteger(N,16),parseInt(E,16));
      }
      
      public static function generate(B:uint, E:String) : RSAKey
      {
         var rng:Random = null;
         var qs:uint = 0;
         var key:RSAKey = null;
         var ee:BigInteger = null;
         var p1:BigInteger = null;
         var q1:BigInteger = null;
         var phi:BigInteger = null;
         var t:BigInteger = null;
         rng = new Random();
         qs = uint(B >> 1);
         key = new RSAKey(null,0,null);
         key.e = parseInt(E,16);
         for(ee = new BigInteger(E,16); true; )
         {
            while(true)
            {
               key.p = bigRandom(B - qs,rng);
               if(key.p.subtract(BigInteger.ONE).gcd(ee).compareTo(BigInteger.ONE) == 0 && key.p.isProbablePrime(10))
               {
                  break;
               }
            }
            while(true)
            {
               key.q = bigRandom(qs,rng);
               if(key.q.subtract(BigInteger.ONE).gcd(ee).compareTo(BigInteger.ONE) == 0 && key.q.isProbablePrime(10))
               {
                  break;
               }
            }
            if(key.p.compareTo(key.q) <= 0)
            {
               t = key.p;
               key.p = key.q;
               key.q = t;
            }
            p1 = key.p.subtract(BigInteger.ONE);
            q1 = key.q.subtract(BigInteger.ONE);
            phi = p1.multiply(q1);
            if(phi.gcd(ee).compareTo(BigInteger.ONE) == 0)
            {
               key.n = key.p.multiply(key.q);
               key.d = ee.modInverse(phi);
               key.dmp1 = key.d.mod(p1);
               key.dmq1 = key.d.mod(q1);
               key.coeff = key.q.modInverse(key.p);
               break;
            }
         }
         return key;
      }
      
      public static function parsePrivateKey(N:String, E:String, D:String, P:String = null, Q:String = null, DMP1:String = null, DMQ1:String = null, IQMP:String = null) : RSAKey
      {
         if(P == null)
         {
            return new RSAKey(new BigInteger(N,16),parseInt(E,16),new BigInteger(D,16));
         }
         return new RSAKey(new BigInteger(N,16),parseInt(E,16),new BigInteger(D,16),new BigInteger(P,16),new BigInteger(Q,16),new BigInteger(DMP1,16),new BigInteger(DMQ1),new BigInteger(IQMP));
      }
      
      public function verify(src:ByteArray, dst:ByteArray, length:uint, pad:Function = null) : void
      {
         _decrypt(doPublic,src,dst,length,pad,1);
      }
      
      public function dump() : String
      {
         var s:String = null;
         s = "N=" + n.toString(16) + "\n" + "E=" + e.toString(16) + "\n";
         if(canDecrypt)
         {
            s += "D=" + d.toString(16) + "\n";
            if(p != null && q != null)
            {
               s += "P=" + p.toString(16) + "\n";
               s += "Q=" + q.toString(16) + "\n";
               s += "DMP1=" + dmp1.toString(16) + "\n";
               s += "DMQ1=" + dmq1.toString(16) + "\n";
               s += "IQMP=" + coeff.toString(16) + "\n";
            }
         }
         return s;
      }
      
      protected function doPrivate2(x:BigInteger) : BigInteger
      {
         var xp:BigInteger = null;
         var xq:BigInteger = null;
         var r:BigInteger = null;
         if(p == null && q == null)
         {
            return x.modPow(d,n);
         }
         xp = x.mod(p).modPow(dmp1,p);
         xq = x.mod(q).modPow(dmq1,q);
         while(xp.compareTo(xq) < 0)
         {
            xp = xp.add(p);
         }
         return xp.subtract(xq).multiply(coeff).mod(p).multiply(q).add(xq);
      }
      
      public function decrypt(src:ByteArray, dst:ByteArray, length:uint, pad:Function = null) : void
      {
         _decrypt(doPrivate2,src,dst,length,pad,2);
      }
      
      private function _decrypt(op:Function, src:ByteArray, dst:ByteArray, length:uint, pad:Function, padType:int) : void
      {
         var bl:uint = 0;
         var end:int = 0;
         var block:BigInteger = null;
         var chunk:BigInteger = null;
         var b:ByteArray = null;
         if(pad == null)
         {
            pad = pkcs1unpad;
         }
         if(src.position >= src.length)
         {
            src.position = 0;
         }
         bl = getBlockSize();
         end = int(src.position + length);
         while(src.position < end)
         {
            block = new BigInteger(src,length);
            chunk = op(block);
            b = pad(chunk,bl);
            dst.writeBytes(b);
         }
      }
      
      protected function doPublic(x:BigInteger) : BigInteger
      {
         return x.modPowInt(e,n);
      }
      
      public function dispose() : void
      {
         e = 0;
         n.dispose();
         n = null;
         Memory.gc();
      }
      
      private function _encrypt(op:Function, src:ByteArray, dst:ByteArray, length:uint, pad:Function, padType:int) : void
      {
         var bl:uint = 0;
         var end:int = 0;
         var block:BigInteger = null;
         var chunk:BigInteger = null;
         if(pad == null)
         {
            pad = pkcs1pad;
         }
         if(src.position >= src.length)
         {
            src.position = 0;
         }
         bl = getBlockSize();
         end = int(src.position + length);
         while(src.position < end)
         {
            block = new BigInteger(pad(src,end,bl,padType),bl);
            chunk = op(block);
            chunk.toArray(dst);
         }
      }
      
      private function rawpad(src:ByteArray, end:int, n:uint) : ByteArray
      {
         return src;
      }
      
      public function encrypt(src:ByteArray, dst:ByteArray, length:uint, pad:Function = null) : void
      {
         _encrypt(doPublic,src,dst,length,pad,2);
      }
      
      private function pkcs1pad(src:ByteArray, end:int, n:uint, type:uint = 2) : ByteArray
      {
         var out:ByteArray = null;
         var p:uint = 0;
         var i:int = 0;
         var rng:Random = null;
         var x:int = 0;
         out = new ByteArray();
         p = src.position;
         end = Math.min(end,src.length,p + n - 11);
         src.position = end;
         i = end - 1;
         while(i >= p && n > 11)
         {
            var _loc10_:* = --n;
            out[_loc10_] = src[i--];
         }
         _loc10_ = --n;
         out[_loc10_] = 0;
         rng = new Random();
         while(n > 2)
         {
            for(x = 0; x == 0; )
            {
               x = type == 2 ? rng.nextByte() : 255;
            }
            var _loc11_:* = --n;
            out[_loc11_] = x;
         }
         _loc11_ = --n;
         out[_loc11_] = type;
         var _loc12_:* = --n;
         out[_loc12_] = 0;
         return out;
      }
      
      private function pkcs1unpad(src:BigInteger, n:uint, type:uint = 2) : ByteArray
      {
         var b:ByteArray = null;
         var out:ByteArray = null;
         var i:int = 0;
         b = src.toByteArray();
         out = new ByteArray();
         i = 0;
         while(i < b.length && b[i] == 0)
         {
            i++;
         }
         if(b.length - i != n - 1 || b[i] > 2)
         {
            trace("PKCS#1 unpad: i=" + i + ", expected b[i]==[0,1,2], got b[i]=" + b[i].toString(16));
            return null;
         }
         i++;
         while(b[i] != 0)
         {
            if(++i >= b.length)
            {
               trace("PKCS#1 unpad: i=" + i + ", b[i-1]!=0 (=" + b[i - 1].toString(16) + ")");
               return null;
            }
         }
         while(++i < b.length)
         {
            out.writeByte(b[i]);
         }
         out.position = 0;
         return out;
      }
      
      public function getBlockSize() : uint
      {
         return (n.bitLength() + 7) / 8;
      }
      
      public function toString() : String
      {
         return "rsa";
      }
      
      public function sign(src:ByteArray, dst:ByteArray, length:uint, pad:Function = null) : void
      {
         _encrypt(doPrivate2,src,dst,length,pad,1);
      }
      
      protected function doPrivate(x:BigInteger) : BigInteger
      {
         var xp:BigInteger = null;
         var xq:BigInteger = null;
         if(p == null || q == null)
         {
            return x.modPow(d,n);
         }
         xp = x.mod(p).modPow(dmp1,p);
         xq = x.mod(q).modPow(dmq1,q);
         while(xp.compareTo(xq) < 0)
         {
            xp = xp.add(p);
         }
         return xp.subtract(xq).multiply(coeff).mod(p).multiply(q).add(xq);
      }
   }
}

