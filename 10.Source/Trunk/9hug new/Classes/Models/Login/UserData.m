//
//  AccountObject.m
//  Copyright (c) 2014 BHTech. All rights reserved.
//

#import "UserData.h"

@implementation UserData

#define USERCODE @"USERCODE"
#define USEREMAIL @"USEREMAIL"
#define USERFACEBOOKID @"USERFACEBOOKID"
#define USERFACEBOOKTOKEN @"USERFACEBOOKTOKEN"
#define USERFULLNAME @"USERFULLNAME"
#define USERMOBILE @"USERMOBILE"
#define USERNICKNAME @"USERNICKNAME"
#define USERPASSWORD @"USERPASSWORD"
#define USERMEMBER @"USERMEMBER"
#define USERID @"USERID"
#define USERCREATEDATE @"USERCREATED"


+(UserData*)currentAccount{
    static UserData *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[UserData alloc] init];
    });
    return _sharedInstance;
}

- (void)setStrCode:(NSString *)strCode{
    [[NSUserDefaults standardUserDefaults] setValue:strCode forKey:USERCODE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)strCode{
    return [[NSUserDefaults standardUserDefaults] valueForKey:USERCODE];
}

- (void)setStrEmail:(NSString *)strEmail{
    [[NSUserDefaults standardUserDefaults] setValue:strEmail forKey:USEREMAIL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)strEmail{
    return [[NSUserDefaults standardUserDefaults] valueForKey:USEREMAIL];
}

- (void)setStrFacebookId:(NSString *)strFacebookId{
    [[NSUserDefaults standardUserDefaults] setValue:strFacebookId forKey:USERFACEBOOKID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)strFacebookId{
    return [[NSUserDefaults standardUserDefaults] valueForKey:USERFACEBOOKID];
}

- (void)setStrFacebookToken:(NSString *)strFacebookToken{
    [[NSUserDefaults standardUserDefaults] setValue:strFacebookToken forKey:USERFACEBOOKTOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)strFacebookToken{
    return [[NSUserDefaults standardUserDefaults] valueForKey:USERFACEBOOKTOKEN];
}

- (void)setStrFullName:(NSString *)strFullName{
    [[NSUserDefaults standardUserDefaults] setValue:strFullName forKey:USERFULLNAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)strFullName{
    return [[NSUserDefaults standardUserDefaults] valueForKey:USERFULLNAME];
}

- (void)setStrMobile:(NSString *)strMobile{
    [[NSUserDefaults standardUserDefaults] setValue:strMobile forKey:USERMOBILE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)strMobile{
    return [[NSUserDefaults standardUserDefaults] valueForKey:USERMOBILE];
}

- (void)setStrNickname:(NSString *)strNickname{
    [[NSUserDefaults standardUserDefaults] setValue:strNickname forKey:USERNICKNAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)strNickname{
    return [[NSUserDefaults standardUserDefaults] valueForKey:USERNICKNAME];
}

- (void)setStrPassword:(NSString *)strPassword{
    [[NSUserDefaults standardUserDefaults] setValue:strPassword forKey:USERPASSWORD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)strPassword{
    return [[NSUserDefaults standardUserDefaults] valueForKey:USERPASSWORD];
}

- (void)setStrId:(NSString *)strId{
    [[NSUserDefaults standardUserDefaults] setValue:strId forKey:USERID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)strId{
    return [[NSUserDefaults standardUserDefaults] valueForKey:USERID];
}

- (void)setStrCreateDate:(NSString *)strCreateDate{
    [[NSUserDefaults standardUserDefaults] setValue:strCreateDate forKey:USERCREATEDATE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)strCreateDate{
    return [[NSUserDefaults standardUserDefaults] valueForKey:USERCREATEDATE];
}



-(void)setShouldRememberMe:(BOOL)yesOrNo{
    [[NSUserDefaults standardUserDefaults] setBool:yesOrNo forKey:USERMEMBER];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)isRemembered{
    return [[NSUserDefaults standardUserDefaults] boolForKey :USERMEMBER];
}

-(void)clearCached{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USERMEMBER];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERPASSWORD];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERNICKNAME];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERMOBILE];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERFULLNAME];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERFACEBOOKTOKEN];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERFACEBOOKID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USEREMAIL];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERCODE];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERCREATEDATE];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
