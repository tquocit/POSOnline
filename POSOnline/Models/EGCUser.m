//
//  EGCUser.m
//
//
//  Created by Torin on 24/4/13.
//  Copyright (c) 2013 2359 Media Pte Ltd. All rights reserved.
//

#import "EGCUser.h"

@implementation EGCUser

- (NSString *)name
{
    if ([_name length] == 0 && [self.display_name length] > 0) {
        _name = self.display_name;
    }
    return _name;
}

- (NSURL *)facebookProfileImageURL
{
    NSString *link = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=100&height=100", self.facebook_id];
    return [NSURL URLWithString:link];
}

@end
