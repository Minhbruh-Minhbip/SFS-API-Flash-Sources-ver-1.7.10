package com.hurlant.math
{
   internal class ClassicReduction implements IReduction
   {
      private var m:BigInteger;
      
      public function ClassicReduction(m:BigInteger)
      {
         super();
         this.m = m;
      }
      
      public function revert(x:BigInteger) : BigInteger
      {
         return x;
      }
      
      public function reduce(x:BigInteger) : void
      {
         x.bi_internal::divRemTo(m,null,x);
      }
      
      public function convert(x:BigInteger) : BigInteger
      {
         if(x.bi_internal::s < 0 || x.compareTo(m) >= 0)
         {
            return x.mod(m);
         }
         return x;
      }
      
      public function sqrTo(x:BigInteger, r:BigInteger) : void
      {
         x.bi_internal::squareTo(r);
         reduce(r);
      }
      
      public function mulTo(x:BigInteger, y:BigInteger, r:BigInteger) : void
      {
         x.bi_internal::multiplyTo(y,r);
         reduce(r);
      }
   }
}

