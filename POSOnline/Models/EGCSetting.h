//
//  EGCSetting.h
//
//
//  Created by Torin on 24/4/13.
//  Copyright (c) 2013 2359 Media Pte Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EGCSetting : BaseModel

@property (nonatomic, copy) NSNumber * ID;
@property (nonatomic, copy) NSString * key;
@property (nonatomic, strong) id value;

@end
