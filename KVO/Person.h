//
//  Person.h
//  KVO
//
//  Created by macvivi on 2020/7/15.
//  Copyright © 2020 macvivi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+kvo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property(copy,nonatomic)NSString *name;

@end

NS_ASSUME_NONNULL_END
