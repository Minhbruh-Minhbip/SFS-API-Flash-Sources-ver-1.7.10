package com.smartfoxserver.v2.core
{
   import com.hurlant.crypto.Crypto;
   import com.hurlant.crypto.symmetric.ICipher;
   import com.hurlant.crypto.symmetric.IPad;
   import com.hurlant.crypto.symmetric.IVMode;
   import com.hurlant.crypto.symmetric.PKCS5;
   import com.smartfoxserver.v2.bitswarm.BitSwarmClient;
   import com.smartfoxserver.v2.util.CryptoKey;
   import flash.utils.ByteArray;
   
   public class DefaultPacketEncrypter implements IPacketEncrypter
   {
      private var bitSwarm:BitSwarmClient;
      
      private const ALGORITHM:String = "aes-cbc";
      
      public function DefaultPacketEncrypter(bitSwarm:BitSwarmClient)
      {
         super();
         this.bitSwarm = bitSwarm;
      }
      
      public function encrypt(data:ByteArray) : void
      {
         var ck:CryptoKey = this.bitSwarm.cryptoKey;
         var padding:IPad = new PKCS5();
         var cipher:ICipher = Crypto.getCipher(this.ALGORITHM,ck.key,padding);
         var ivmode:IVMode = cipher as IVMode;
         ivmode.IV = ck.iv;
         cipher.encrypt(data);
      }
      
      public function decrypt(data:ByteArray) : void
      {
         var ck:CryptoKey = this.bitSwarm.cryptoKey;
         var padding:IPad = new PKCS5();
         var cipher:ICipher = Crypto.getCipher(this.ALGORITHM,ck.key,padding);
         var ivmode:IVMode = cipher as IVMode;
         ivmode.IV = ck.iv;
         cipher.decrypt(data);
      }
   }
}

