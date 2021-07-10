//
//  NSObject+kvo.h
//  KVO
//
//  Created by macvivi on 2020/7/17.
//  Copyright © 2020 macvivi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (kvo)

- (void)xy_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end

NS_ASSUME_NONNULL_END
