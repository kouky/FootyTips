//
//  Swizzle.h
//  FootyTips
//
//  Created by Michael Koukoullis on 25/05/2014.
//  Copyright (c) 2014 Michael Koukoullis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Swizzle : NSObject

+ (void)swapInstanceMethodsForClass:(Class)cls selector:(SEL)sel1 andSelector:(SEL)sel2;

@end
