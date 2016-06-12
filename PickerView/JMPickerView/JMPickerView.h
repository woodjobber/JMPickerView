//
//  JMPickerView.h
//  PickerView
//
//  Created by chengbin on 16/5/27.
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

//仅仅支持 3级 组件
#import <UIKit/UIKit.h>

@class JMPickerView;
@class JMPickerViewReusableCell;
NS_ASSUME_NONNULL_BEGIN

@protocol JMPickerViewDataSource <NSObject>
@required

// returns the number of 'columns' to display.

- (NSInteger)jm_numberOfComponentsInJMPickerView:(JMPickerView *)pickerView;

// returns the # of rows in each component..

- (NSInteger)jm_pickerView:(JMPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

@end

@protocol JMPickerViewDelegate <NSObject>

@optional
/**
 *  This method represents a column select a row.
 *
 *  @param pickerView pickerView --
 *  @param row        selected row
 *  @param component  selected column
 */
- (void)jm_pickerView:(JMPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
/**
 *  The method set width of component.
 *
 *  @param pickerView pickerView --
 *  @param component  column
 *
 *  @return width
 */
- (CGFloat)jm_pickerView:(JMPickerView *)pickerView widthForComponent:(NSInteger)component;
/**
 *  The method set height of component.
 *
 *  @param pickerView pickerView --
 *  @param component  column
 *
 *  @return height
 */
- (CGFloat)jm_pickerView:(JMPickerView *)pickerView rowHeightForComponent:(NSInteger)component;
/**
 *  You can get a view, you can also customize the view.
 *
 *  @param pickerView pickerView --
 *  @param row        row
 *  @param component  component
 *  @param view       view
 *
 *  @return view
 */
- (__kindof UIView *)jm_pickerView:(JMPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view;
/**
 *  Set title's attribute
 *
 *  @param pickerView pickerView --
 *  @param row        row
 *  @param component  component
 *
 *  @return attibueted
 */
- (nullable NSAttributedString *)jm_pickerView:(JMPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component;
/**
 *  Set title
 *
 *  @param pickerView pickerView --
 *  @param row        row
 *  @param component  component
 *
 *  @return title
 */
- (nullable NSString *)jm_pickerView:(JMPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
/**
 *  Click the button on the left has been completed
 *
 *  @param pickerView pickerView --
 *  @param button     button
 */
- (void)jm_pickerView:(JMPickerView *)pickerView didTapLeftItem:(UIButton *)button;
/**
 *  Click the button on the right has been completed
 *
 *  @param pickerView pickerView --
 *  @param button     button
 */
- (void)jm_pickerView:(JMPickerView *)pickerView didTapRightItem:(UIButton *)button;

@end

@interface JMPickerView : UIView<NSCopying,NSCoding,NSMutableCopying>

@property (copy, nonatomic) NSString *leftItemTitle;// title in tool bar

@property (copy, nonatomic) NSString *rightItemTitle; // title in tool bar

@property (weak, nonatomic,readonly)  UIButton *cancelButton;//left button

@property (weak, nonatomic,readonly)  UIButton *confirmButton;// right button

@property (weak, nonatomic) id <JMPickerViewDelegate> delegate;

@property (weak, nonatomic) id <JMPickerViewDataSource> dataSource;

@property (assign, nonatomic) CGFloat heightForToolBar;

@property (assign, nonatomic) BOOL showsToolBarTitle; //Default YES;

@property (weak, nonatomic ,readonly) UILabel *toolBarTitle;// tool bar center

@property (copy, nonatomic) NSString *title; // set tool bar 's title

@property (strong, nonatomic) UIColor *titleColor;// set title of tool bar of color

@property (copy, nonatomic) NSString *leftTitleInPickerView; // title in pickerView

@property (copy, nonatomic) NSString *rightTitleInPickerView;// title in pickerView

@property (strong, nonatomic, readonly) UILabel *leftLabel;// label in pickerView

@property (strong, nonatomic, readonly) UILabel *rightLabel;// label in pickerView

@property (assign, nonatomic) BOOL showSeparatorLine;// custom separator line .Default YES

@property (strong, nonatomic) UIColor *separatorLineColor;// custom separator line 's color.//Default [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.198f]

@property (assign, nonatomic) BOOL showSystemSeparatorLine; // system separator line.Default NO

@property (strong, nonatomic) UIColor *systemSeparatorLineColor; //Default [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.198f];


// info that was fetched and cached from the data source and delegate
@property(readonly,nonatomic,assign) NSInteger numberOfComponents;

@property(assign,nonatomic)BOOL showsSelectionIndicator;   // default is NO

/**
 *  Instance pickerView
 *
 *  @return pikcerView
 */
+ (instancetype)instantiateInitialJMPickerViewFromNib;

- (NSInteger)numberOfRowsInComponent:(NSInteger)component;

- (CGSize)rowSizeForComponent:(NSInteger)component;
// returns the view provided by the delegate via jm_pickerView:viewForRow:forComponent:reusingView:
// or nil if the row/component is not visible or the delegate does not implement
// JM_pickerView:viewForRow:forComponent:reusingView:
- (nullable UIView *)viewForRow:(NSInteger)row forComponent:(NSInteger)component;

// Reloading whole view or single component
- (void)reloadAllComponents;
- (void)reloadComponent:(NSInteger)component;

// selection. in this case, it means showing the appropriate row in the middle
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;  // scrolls the specified row to center.

- (NSInteger)selectedRowInComponent:(NSInteger)component;                                   // returns selected row. -1 if nothing selected

@end

NS_ASSUME_NONNULL_END
