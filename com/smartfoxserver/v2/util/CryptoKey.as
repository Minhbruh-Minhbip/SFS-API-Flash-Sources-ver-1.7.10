package com.smartfoxserver.v2.util
{
   import flash.utils.ByteArray;
   
   public class CryptoKey
   {
      private var _iv:ByteArray;
      
      private var _key:ByteArray;
      
      public function CryptoKey(iv:ByteArray, key:ByteArray)
      {
         super();
         this._iv = iv;
         this._key = key;
      }
      
      public function get iv() : ByteArray
      {
         return this._iv;
      }
      
      public function get key() : ByteArray
      {
         return this._key;
      }
   }
}

