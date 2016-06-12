//
//  NSArray+SafeAccess.m
//  JuMei
//
//  Created by chengbin on 16/4/18.
//  Copyright © 2016年 Jumei Inc. All rights reserved.
//

#import "NSArray+SafeAccess.h"

@implementation NSArray (SafeAccess)

- (id)sa_objectWithIndex:(NSUInteger)index {
    if (self.count > index  && self != nil) {
         return [self objectAtIndex:index];
    }
   
    return nil;
}

- (nullable NSString *)sa_stringWithIndex:(NSUInteger)index {
    id value = [self sa_objectWithIndex:index];
    if (value == nil || value == [NSNull null] || [[value description] isEqualToString:@"<null>"]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    return nil;
}

- (nullable NSNumber *)sa_numberWithIndex:(NSUInteger)index {
    id value = [self sa_objectWithIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}
- (NSInteger)sa_integerWithIndex:(NSUInteger)index
{
    id value = [self sa_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    return 0;
}
- (NSUInteger)sa_unsignedIntegerWithIndex:(NSUInteger)index
{
    id value = [self sa_objectWithIndex:index];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value unsignedIntegerValue];
    }
    return 0;
}
- (BOOL)sa_boolWithIndex:(NSUInteger)index
{
    id value = [self sa_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value boolValue];
    }
    return NO;
}
- (float)sa_floatWithIndex:(NSUInteger)index
{
    id value = [self sa_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    return 0;
}
- (double)sa_doubleWithIndex:(NSUInteger)index
{
    id value = [self sa_objectWithIndex:index];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    return 0;
}

@end

@implementation NSMutableArray (SafeAccess)

- (void)sa_addObject:(id)obj {
    if (obj!= nil && self) {
        [self addObject:obj];
    }
}

- (void)sa_addString:(NSString *)string {
    if (string != nil && self) {
        [self addObject:string];
    }
}
- (void)sa_addBool:(BOOL)b {
    if (self) {
         [self addObject:@(b)];
    }
   
}
- (void)sa_addInt:(int)i {
    if (self) {
         [self addObject:@(i)];
    }
   
}
- (void)sa_addInteger:(NSInteger)i {
    if (self) {
        [self addObject:@(i)];
    }
    
}
- (void)sa_addFloat:(float)f {
    if (self) {
        [self addObject:@(f)];
    }
    
}

@end