//
//  EGCUserManager.m
//
//
//  Created by Hu Junfeng on 17/5/13.
//  Copyright (c) 2013 2359 Media Pte Ltd. All rights reserved.
//

#import "EGCUserManager.h"

static NSString * const EGCCurrentUserKey = @"EGCCurrentUserKey";

@interface EGCUserManager ()

@property (nonatomic, strong) EGCUser *currentUser;

@end

@implementation EGCUserManager

SINGLETON_MACRO

- (id)init
{
    self = [super init];
    if (self) {
        self.currentUser = [[BaseStorageManager sharedInstance] objectForKey:EGCCurrentUserKey];
    }
    return self;
}

- (void)getUserFromID:(NSNumber *)userID
              success:(void (^)(EGCUser *user))success
              failure:(void (^)(NSError *error))failure
{
    [[BaseNetworkManager sharedInstance] getServerModelForModelClass:[EGCUser class] keyId:userID success:^(id dataModelObject) {
        success(dataModelObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loginWithFacebookToken:(NSString *)facebookToken
                       success:(void (^)(void))success
                       failure:(void (^)(NSError *error))failure
{
    [self registerUserWithFacebookToken:facebookToken success:^(EGCUser *user) {
        self.currentUser = user;
    
        if (success) success();
        
    } failure:failure];
}

- (void)registerWithEmail:(NSString *)email
                 password:(NSString *)password
                firstName:(NSString *)firstName
                 lastName:(NSString *)lastName
{
    // TODO: implement in interation 2
}

- (void)loginWithEmail:(NSString *)email password:(NSString *)password
{
    // TODO: implement in interation 2    
}

- (void)logout
{
    self.currentUser = nil;
    
    // Remove the persistent store
    [[BaseStorageManager sharedInstance] setObject:nil forKey:EGCCurrentUserKey];
    
    // Also logout facebook
    [[FacebookManager sharedInstance] logout];
}

- (BOOL)isLoggedIn
{
    return [[self.currentUser access_token] length] > 0;
}

- (NSString*)getAccessToken
{
    return [self.currentUser access_token];
}



#pragma mark - User APIs

- (void)registerUserWithFacebookToken:(NSString *)facebook_access_token
                              success:(void (^)(EGCUser *user))success
                              failure:(void (^)(NSError *error))failure
{
    if ([facebook_access_token length] <= 3) {
        DLog(@"WARNING: Empty Facebook access token");
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"password" forKey:@"grant_type"];
    [params setObject:facebook_access_token forKey:@"facebook_access_token"];
    
    [[BaseNetworkManager sharedInstance] sendRequestForPath:API_OAUTH_TOKEN
                                                 parameters:params
                                                     method:POST_METHOD
                                                    success:^(NSDictionary *json)
     {   
        EGCUser *user = [[EGCUser alloc] initWithDictionary:json];
        if (success)
            success(user);
        
    } failure:failure];    
}

@end
