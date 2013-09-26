//
//  EGCLoadingManager.m
//
//  Created by Torin on 15/2/13.
//  Copyright (c) 2013 MyCompany. All rights reserved.
//

#import "EGCLoadingManager.h"

@interface EGCLoadingManager()
@end

@implementation EGCLoadingManager

SINGLETON_MACRO

- (id)init
{
  self = [super init];
  if (self == nil)
    return self;
    
  return self;
}



#pragma mark - Public

- (void)downloadEverything
{
  [self thread1];
  [self thread2];
  [self thread3];
}


#pragma mark - Thread 1

- (void)thread1
{
  [self downloadSettings];
}

- (void)downloadSettings
{
    [[BaseNetworkManager sharedInstance] getServerListForModelClass:[EGCSetting class] success:^(NSMutableArray *objectsArray) {
        DLog(@"%d Settings updated", [objectsArray count]);
    } failure:^(NSError *error) {
        DLog(@"Failed to update Settings");
        DLog(@"%@", error);
    }];
}



#pragma mark - Thread 2

- (void)thread2
{
    
}



#pragma mark - Thread 3

- (void)thread3
{

}

@end
