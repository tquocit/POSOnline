//
//  EGCUserManager.h
//
//
//  Created by Hu Junfeng on 17/5/13.
//  Copyright (c) 2013 2359 Media Pte Ltd. All rights reserved.
//

#import "BaseManager.h"

@interface EGCUserManager : BaseManager

@property (nonatomic, readonly) EGCUser *currentUser;

- (void)getUserFromID:(NSNumber *)userID
              success:(void (^)(EGCUser *user))success
              failure:(void (^)(NSError *error))failure;

- (void)loginWithFacebookToken:(NSString *)facebookToken
                       success:(void (^)(void))success
                       failure:(void (^)(NSError *error))failure;

- (void)logout;

- (BOOL)isLoggedIn;

- (NSString*)getAccessToken;

@end
