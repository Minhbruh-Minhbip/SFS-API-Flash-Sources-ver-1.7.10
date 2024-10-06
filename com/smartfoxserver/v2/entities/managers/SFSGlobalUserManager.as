package com.smartfoxserver.v2.entities.managers
{
   import com.smartfoxserver.v2.SmartFox;
   import com.smartfoxserver.v2.entities.User;
   
   public class SFSGlobalUserManager extends SFSUserManager
   {
      private var _roomRefCount:Array;
      
      public function SFSGlobalUserManager(sfs:SmartFox)
      {
         super(sfs);
         this._roomRefCount = [];
      }
      
      override public function addUser(user:User) : void
      {
         if(this._roomRefCount[user] == null)
         {
            super._addUser(user);
            this._roomRefCount[user] = 1;
         }
         else
         {
            super._addUser(user);
            ++this._roomRefCount[user];
         }
      }
      
      override public function removeUser(user:User) : void
      {
         this.removeUserReference(user,false);
      }
      
      public function removeUserReference(user:User, disconnected:Boolean = false) : void
      {
         if(this._roomRefCount != null)
         {
            if(this._roomRefCount[user] < 1)
            {
               _smartFox.logger.warn("GlobalUserManager RefCount is already at zero. User: " + user);
               return;
            }
            --this._roomRefCount[user];
            if(this._roomRefCount[user] == 0 || disconnected)
            {
               super.removeUser(user);
               delete this._roomRefCount[user];
            }
         }
         else
         {
            _smartFox.logger.warn("Can\'t remove User from GlobalUserManager. RefCount missing. User: " + user);
         }
      }
      
      private function dumpRefCount() : void
      {
      }
   }
}

