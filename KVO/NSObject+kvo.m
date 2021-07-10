//
//  NSObject+kvo.m
//  KVO
//
//  Created by macvivi on 2020/7/17.
//  Copyright © 2020 macvivi. All rights reserved.
//

#import "NSObject+kvo.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (kvo)

- (void)xy_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context{
    //动态添加一个类
    NSString *originClassName = NSStringFromClass([self class]);
    NSString *newClassName = [@"XYKVO_" stringByAppendingString:originClassName];
    const char *newName = [newClassName UTF8String];
    //动态添加的类为当前类的子类
    Class kvoClass = objc_allocateClassPair([self class], newName, 0);
    //添加setter方法
    class_addMethod(kvoClass, @selector(setName:), (IMP)setName, "v@:@");
    //注册新添加的这个类
    objc_registerClassPair(kvoClass);
    //修改isa指针，由xx指向XYKVO_xx
    object_setClass(self,kvoClass);
    //保存观察者到当前实例对象中
    objc_setAssociatedObject(self, (__bridge const void *)@"observer", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




#pragma mark - 重写父类方法

//给动态的类添加的setter方法
void setName(id self, SEL _cmd, NSString *name) {

    //保存动态生成的KVO类
    Class kvoClass = [self class];
    //将isa指针指回父类xx
    object_setClass(self, class_getSuperclass([self class]));
    //调用父类的setter方法
    objc_msgSend(self, @selector(setName:), name);
    //取出实例对象的观察者
    id objc = objc_getAssociatedObject(self, (__bridge const void *)@"observer");
    //通知观察者，执行通知方法
    objc_msgSend(objc, @selector(observeValueForKeyPath:ofObject:change:context:),name,self,nil,name);
    //重新修改为XYKVO_xx类
    object_setClass(self, kvoClass);
}

@end
