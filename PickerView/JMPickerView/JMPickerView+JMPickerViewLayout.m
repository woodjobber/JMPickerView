//
//  JMPickerView+JMPickerViewAutoLayout.m
//  PickerView
//
//  Created by chengbin on 16/6/1.
//  Copyright © 2016年 chengbin. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "JMPickerView+JMPickerViewLayout.h"

@implementation JMPickerView (JMPickerViewLayout)

- (void)jm_pickerViewAutoLayout {
    UIView *superView = self.superview;
    if (!superView)return;
     NSLayoutConstraint *viewLeft = [self jm_constraintToItem:superView attribute:NSLayoutAttributeLeading];
     NSLayoutConstraint *viewBottom = [self jm_constraintToItem:superView attribute:NSLayoutAttributeBottom];
     NSLayoutConstraint *viewRight = [self jm_constraintToItem:superView attribute:NSLayoutAttributeTrailing];
     NSLayoutConstraint *viewTop = [self jm_constraintToItem:superView attribute:NSLayoutAttributeTop];
    [superView addConstraints:@[viewLeft,viewBottom ,viewRight, viewTop]];
 
}

- (NSLayoutConstraint *)jm_constraintToItem:(id)item attribute:(NSLayoutAttribute)attr2 {
    return  [NSLayoutConstraint constraintWithItem:self
                                 attribute:attr2
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:item
                                 attribute:attr2
                                multiplier:1
                                  constant:0];
}

@end
