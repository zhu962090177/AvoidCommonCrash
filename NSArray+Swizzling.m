//
//  NSArray+Swizzling.m
//  Swizzing
//
//  Created by csai-dev on 2019/4/22.
//  Copyright © 2019年 health. All rights reserved.
//

#import "NSArray+Swizzling.h"
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"

@implementation NSArray (Swizzling)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSArrayI")
         swizzleSelector:@selector(objectAtIndexedSubscript:) withSwizzledSelector:@selector(safeObjectAtIndexedSubscript:)];
        [objc_getClass("__NSArrayI")
         swizzleSelector:@selector(objectAtIndex:) withSwizzledSelector:@selector(safeArrIObjectAtIndex:)];
        
        [objc_getClass("__NSArray0")
         swizzleSelector:@selector(objectAtIndex:) withSwizzledSelector:@selector(safeArr0ObjectAtIndex:)];
        [objc_getClass("__NSSingleObjectArrayI")
         swizzleSelector:@selector(objectAtIndex:) withSwizzledSelector:@selector(safeSingleObjArrIObjectAtIndex:)];
        
    });
}

- (id)safeObjectAtIndexedSubscript:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self safeObjectAtIndexedSubscript:index];
}

- (id)safeArr0ObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self safeArr0ObjectAtIndex:index];
}

- (id)safeArrIObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self safeArrIObjectAtIndex:index];
}

- (id)safeSingleObjArrIObjectAtIndex:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self safeSingleObjArrIObjectAtIndex:index];
}

@end
