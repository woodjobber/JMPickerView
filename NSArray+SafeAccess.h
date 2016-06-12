//
//  NSArray+SafeAccess.h
//  JuMei
//
//  Created by chengbin on 16/4/18.
//  Copyright © 2016年 Jumei Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (SafeAccess)


- (id)sa_objectWithIndex:(NSUInteger)index;

- (nullable NSString *)sa_stringWithIndex:(NSUInteger)index;

- (nullable NSNumber *)sa_numberWithIndex:(NSUInteger)index;

- (NSInteger)sa_integerWithIndex:(NSUInteger)index;

- (NSUInteger)sa_unsignedIntegerWithIndex:(NSUInteger)index;

- (BOOL)sa_boolWithIndex:(NSUInteger)index;

- (float)sa_floatWithIndex:(NSUInteger)index;

- (double)sa_doubleWithIndex:(NSUInteger)index;




@end

@interface NSMutableArray (SafeAccess)

- (void)sa_addObject:(nonnull id)obj;

- (void)sa_addString:(nonnull NSString *)string;

- (void)sa_addBool:(BOOL)b;

- (void)sa_addInt:(int)i;

- (void)sa_addInteger:(NSInteger)i;

- (void)sa_addFloat:(float)f;



@end

NS_ASSUME_NONNULL_END