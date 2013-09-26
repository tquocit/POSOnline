//
//  EGCUser.h
//
//
//  Created by Torin on 24/4/13.
//  Copyright (c) 2013 2359 Media Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EGCUser : BaseModel

@property (nonatomic, copy) NSNumber * ID;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * email;

@property (nonatomic, copy) NSString * first_name;
@property (nonatomic, copy) NSString * last_name;
@property (nonatomic, copy) NSString * name_slug;
@property (nonatomic, copy) NSString * display_name;
@property (nonatomic, copy) NSString * profile_image_picture;
@property (nonatomic, copy) NSString * facebook_id;
@property (nonatomic, copy) NSString * user_type;

//Follow
@property (nonatomic, copy) NSNumber * followers_stat;
@property (nonatomic, copy) NSNumber * following_stat;
@property (nonatomic, copy) NSNumber * following;

@property (nonatomic, copy) NSDate * updated_at;
@property (nonatomic, copy) NSDate * created_at;

//Login tokens
@property (nonatomic, copy) NSString * access_token;
@property (nonatomic, copy) NSString * token_type;
@property (nonatomic, copy) NSNumber * expires_in;
@property (nonatomic, copy) NSString * scope;

//From Facebook Graph API
@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSString * birthday;
@property (nonatomic, copy) NSNumber * gender;
@property (nonatomic, copy) NSNumber * location;
@property (nonatomic, copy) NSNumber * phone;

- (NSURL *)facebookProfileImageURL;

@end
