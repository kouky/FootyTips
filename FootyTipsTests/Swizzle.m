//
//  Swizzle.m
//  FootyTips
//
//  Created by Michael Koukoullis on 25/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import "Swizzle.h"

@implementation Swizzle

+ (void)swapInstanceMethodsForClass:(Class)cls selector:(SEL)sel1 andSelector:(SEL)sel2
{
  Method method1 = class_getInstanceMethod(cls, sel1);
  Method method2 = class_getInstanceMethod(cls, sel2);
  method_exchangeImplementations(method1, method2);
}

@end
