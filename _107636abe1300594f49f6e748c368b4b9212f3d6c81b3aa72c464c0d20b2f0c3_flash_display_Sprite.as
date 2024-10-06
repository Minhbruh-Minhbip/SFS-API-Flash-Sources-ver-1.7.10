package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   [ExcludeClass]
   public class _107636abe1300594f49f6e748c368b4b9212f3d6c81b3aa72c464c0d20b2f0c3_flash_display_Sprite extends Sprite
   {
      public function _107636abe1300594f49f6e748c368b4b9212f3d6c81b3aa72c464c0d20b2f0c3_flash_display_Sprite()
      {
         super();
      }
      
      public function allowDomainInRSL(... rest) : void
      {
         Security.allowDomain(rest);
      }
      
      public function allowInsecureDomainInRSL(... rest) : void
      {
         Security.allowInsecureDomain(rest);
      }
   }
}

