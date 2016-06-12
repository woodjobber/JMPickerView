//
//  JMPickerView.m
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

#import "JMPickerView.h"
#import "JMPickerViewReusableCell.h"
static NSString * const JMPickerViewNibNamed = @"JMPickerView";
static NSString * const JMPickerViewReusableCellNibNamed = @"JMPickerViewReusableCell";
@interface JMPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIView *toolBarView;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarHeight;

@property (weak, nonatomic) IBOutlet UILabel *toolBarTitle;



@property (assign,nonatomic) NSInteger numberOfComponents;

@property (strong, nonatomic) UILabel *leftLabel;

@property (strong, nonatomic) UILabel *rightLabel;

@end

@implementation JMPickerView

#pragma mark -
#pragma mark Init

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (instancetype)init {
    self = [super init];
    JMPickerView *view = [[self class] instantiateInitialJMPickerViewFromNib];
    view.frame = self.frame;
    if (view) {
        
        [self setup];
    }
    
    return view;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
     JMPickerView *view = [[self class] instantiateInitialJMPickerViewFromNib];
     view.frame = self.frame;
    if (view) {
       [self setup];
    }
    return view;
}
+ (instancetype)instantiateInitialJMPickerViewFromNib {
   return [[NSBundle mainBundle]loadNibNamed:JMPickerViewNibNamed owner:nil options:nil].lastObject;
}


#pragma mark -
#pragma mark Public Methods

- (NSInteger)numberOfComponents {
    return [self numberOfComponentsInPickerView:self.pickerView];
}
- (NSInteger)numberOfRowsInComponent:(NSInteger)component {
    
    return [self.pickerView numberOfRowsInComponent:component];
}

- (CGSize)rowSizeForComponent:(NSInteger)component {
    return [self.pickerView rowSizeForComponent:component];
}

- (nullable UIView *)viewForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.pickerView viewForRow:row forComponent:component];
}

- (void)reloadAllComponents {
    [self.pickerView reloadAllComponents];
}

- (void)reloadComponent:(NSInteger)component {
    [self.pickerView reloadComponent:component];
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated {
    [self.pickerView selectRow:row inComponent:component animated:animated];
}

- (NSInteger)selectedRowInComponent:(NSInteger)component {
    return [self.pickerView selectedRowInComponent:component];
}

- (BOOL)showsSelectionIndicator {
    return self.pickerView.showsSelectionIndicator;
}

#pragma mark -
#pragma mark Setter Methods

-(void)setHeightForToolBar:(CGFloat)heightForToolBar {
    self.toolBarHeight.constant = heightForToolBar;
    [self needsUpdateConstraints];
}

- (void)setRightItemTitle:(NSString *)rightItemTitle {
    [self.confirmButton setTitle:rightItemTitle forState:UIControlStateNormal];
    [self setNeedsDisplay];
}

- (void)setLeftItemTitle:(NSString *)leftItemTitle {
    [self.cancelButton setTitle:leftItemTitle forState:UIControlStateNormal];
    [self setNeedsDisplay];
}
- (void)setShowsToolBarTitle:(BOOL)showsToolBarTitle {
    _showsToolBarTitle = showsToolBarTitle;
    self.toolBarTitle.hidden = !showsToolBarTitle;
    [self setNeedsDisplay];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.toolBarTitle.text = title;
    [self setNeedsDisplay];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.toolBarTitle.textColor = titleColor;
    [self setNeedsDisplay];
}
- (void)setRightTitleInPickerView:(NSString *)rightTitleInPickerView {
    _rightTitleInPickerView = rightTitleInPickerView;
    self.rightLabel.text = rightTitleInPickerView;
    [self setNeedsDisplay];
}

- (void)setLeftTitleInPickerView:(NSString *)leftTitleInPickerView {
    _leftTitleInPickerView = leftTitleInPickerView;
    self.leftLabel.text = leftTitleInPickerView;
    [self setNeedsDisplay];
}

- (void)setShowSeparatorLine:(BOOL)showSeparatorLine {
    _showSeparatorLine = showSeparatorLine;
    for (NSInteger tag = 12; tag <= 17; tag ++) {
        UIView *view = [self.pickerView viewWithTag:tag];
        if (view) {
            view.hidden = !showSeparatorLine;
        }
    }
    [self setNeedsDisplay];
}
- (void)setSeparatorLineColor:(UIColor *)separatorLineColor {
    _separatorLineColor = separatorLineColor;
    for (NSInteger tag = 12; tag <= 17; tag ++) {
        UIView *view = [self.pickerView viewWithTag:tag];
        if (view) {
            view.backgroundColor = separatorLineColor;
        }
    }
    [self setNeedsDisplay];
}
- (void)setShowSystemSeparatorLine:(BOOL)showSystemSeparatorLine {
    _showSystemSeparatorLine = showSystemSeparatorLine;
    self.showSeparatorLine = !showSystemSeparatorLine;
    for (NSInteger tag = 1; tag <= 2; tag ++) {
       UIView *view = [self.pickerView viewWithTag:tag];
        if (view) {
            UIColor *color = showSystemSeparatorLine?self.systemSeparatorLineColor:[UIColor clearColor];
            view.backgroundColor = color;
        }
    }
   
    [self setNeedsDisplay];
}


- (void)setSystemSeparatorLineColor:(UIColor *)systemSeparatorLineColor {
    _systemSeparatorLineColor = systemSeparatorLineColor;
    for (NSInteger tag = 1; tag <= 2; tag ++) {
        UIView *view = [self.pickerView viewWithTag:tag];
        if (view) {
            view.backgroundColor = self.showSystemSeparatorLine?systemSeparatorLineColor:[UIColor clearColor];
        }
    }

    [self setNeedsDisplay];
}

#pragma mark -
#pragma mark Private Methods

- (void)setup{

    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.backgroundColor =[UIColor clearColor];
    self.toolBarTitle.text = @"";
    self.toolBarTitle.hidden = NO;
    _showSeparatorLine = YES;
    _showSystemSeparatorLine = NO;
    _systemSeparatorLineColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.198f];
    _rightTitleInPickerView = @"";
    _leftTitleInPickerView = @"";
    _separatorLineColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.198f];
}


- (JMPickerViewReusableCell *)loadReusableCellFromNib{
    
    return [[NSBundle mainBundle]loadNibNamed:JMPickerViewReusableCellNibNamed owner:nil options:nil].lastObject;
}

#pragma mark - 
#pragma mark UIPickerDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_numberOfComponentsInJMPickerView:)]) {
       return [self.dataSource jm_numberOfComponentsInJMPickerView:self];
    }
    return 0;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_pickerView:numberOfRowsInComponent:)]) {
        
        return [self.dataSource jm_pickerView:self numberOfRowsInComponent:component];
    }
    return 0;
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_pickerView:didSelectRow:inComponent:)]) {
        [self.delegate jm_pickerView:self didSelectRow:row inComponent:component];
    }
    
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return nil;
}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return nil;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_pickerView:widthForComponent:)]) {
        return [self.delegate jm_pickerView:self widthForComponent:component];
    }
    
    return CGRectGetWidth(self.bounds);
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_pickerView:rowHeightForComponent:)]) {
        return [self.delegate jm_pickerView:self rowHeightForComponent:component];
    }
    return 42.0f;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_pickerView:viewForRow:forComponent:reusingView:)]) {
        
       return [self.delegate jm_pickerView:self viewForRow:row forComponent:component reusingView:view];
    }
    
    JMPickerViewReusableCell *reusableCell = (JMPickerViewReusableCell *)view;
    if (!reusableCell) {
         CGSize size =  [pickerView rowSizeForComponent:component];
         reusableCell = [self loadReusableCellFromNib];
         reusableCell.frame = CGRectMake(0, 0, size.width, size.height);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_pickerView:titleForRow:forComponent:)]) {
        reusableCell.title = [self.delegate jm_pickerView:self titleForRow:row forComponent:component];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_pickerView:attributedTitleForRow:forComponent:)]) {
        reusableCell.attributedTitle = [self.delegate jm_pickerView:self attributedTitleForRow:row forComponent:component];
    }
   
    return reusableCell;
}

#pragma mark -
#pragma mark IBAction

- (IBAction)performCancelAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_pickerView:didTapLeftItem:)]) {
        [self.delegate jm_pickerView:self didTapLeftItem:self.cancelButton];
    }
}

- (IBAction)performConfirmAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jm_pickerView:didTapRightItem:)]) {
        [self.delegate jm_pickerView:self didTapRightItem:self.confirmButton];
    }
}

#pragma mark -
#pragma mark -NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    JMPickerView *pickerView = [[[self class] allocWithZone:zone]init];
    pickerView.leftItemTitle = [self.leftItemTitle copy];
    pickerView.rightItemTitle = [self.rightItemTitle copy];
    pickerView.delegate = self.delegate;
    pickerView.dataSource = self.dataSource;
    pickerView.heightForToolBar = self.heightForToolBar;

    pickerView.showsSelectionIndicator = self.showsSelectionIndicator;
    pickerView.numberOfComponents = self.numberOfComponents;
    
    return pickerView;
}
- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    JMPickerView *pickerView = [[[self class] allocWithZone:zone]init];
  
    pickerView.leftItemTitle = [self.leftItemTitle mutableCopyWithZone:zone];
    pickerView.rightItemTitle = [self.rightItemTitle mutableCopyWithZone:zone];
    
    pickerView.delegate = self.delegate;
    pickerView.dataSource = self.dataSource;
    pickerView.heightForToolBar = self.heightForToolBar;

    pickerView.showsSelectionIndicator = self.showsSelectionIndicator;
    pickerView.numberOfComponents = self.numberOfComponents;
    
    return pickerView;
}


#pragma mark -
#pragma mark -NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.leftItemTitle forKey:@"leftItemTitle"];
    [aCoder encodeObject:self.rightItemTitle forKey:@"rightItemTitle"];
    [aCoder encodeObject:self.delegate forKey:@"delegate"];
    [aCoder encodeObject:self.dataSource forKey:@"dataSource"];
    [aCoder encodeFloat:self.heightForToolBar forKey:@"heightForToolBar"];
  
    [aCoder encodeBool:self.showsSelectionIndicator forKey:@"showsSelectionIndicator"];
    [aCoder encodeInteger:self.numberOfComponents forKey:@"numberOfComponents"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.leftItemTitle = [aDecoder decodeObjectForKey:@"leftItemTitle"];
        self.rightItemTitle = [aDecoder decodeObjectForKey:@"rightItemTitle"];
        self.delegate = [aDecoder decodeObjectForKey:@"delegate"];
        self.dataSource = [aDecoder decodeObjectForKey:@"dataSource"];
        self.heightForToolBar = [aDecoder decodeFloatForKey:@"heightForToolBar"];
        self.numberOfComponents = [aDecoder decodeIntegerForKey:@"numberOfComponents"];

    }
    
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self jm_layoutSubviews];
   
    
}
#pragma mark -
#pragma mark Private Methods

- (void)jm_layoutSubviews{
    __block CGFloat lineSpace = 0.0f;
    __block CGFloat y = 0.0f;
    NSInteger numberOfComponent = [self.pickerView numberOfComponents];
    if (numberOfComponent != 3 ) {
        return;
    }
    CGSize size = [self.pickerView rowSizeForComponent:0];
    CGSize size2 = [self.pickerView rowSizeForComponent:1];
    CGSize size3 = [self.pickerView rowSizeForComponent:2];
    
    [self.pickerView.subviews enumerateObjectsUsingBlock:^( UIView *  obj, NSUInteger idx, BOOL *  stop) {
        if (CGRectGetHeight(obj.bounds) <= 0.5f) {
            obj.backgroundColor = self.showSystemSeparatorLine?self.systemSeparatorLineColor:[UIColor clearColor];
            obj.tag = idx;
            if (![self.pickerView viewWithTag:12] || ![self.pickerView viewWithTag:13]) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(size.width/2 - (size.width - 45.0f)/2 - 5.0f , CGRectGetMaxY(obj.frame), size.width - 45.0f, 1.5f)];
                line.backgroundColor = self.separatorLineColor;
                line.translatesAutoresizingMaskIntoConstraints  = YES;
              
                line.tag = idx + 11;
                line.hidden = !self.showSeparatorLine;
                line.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
                [self.pickerView addSubview:line];
                
                if (lineSpace == 0.0f) {
                    lineSpace = CGRectGetMaxY(obj.frame);
                }else {
                    lineSpace = CGRectGetMaxY(obj.frame) - lineSpace;
                }
                
                if (y == 0.0f) {
                    y = CGRectGetMaxY(obj.frame);
                }
            }
            
        }
    }];
    
    if (![self.pickerView viewWithTag:10]) {
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(size.width - 10.0f, y + (lineSpace/2 - 30/2), 40.0f, 30.0f)];
        self.leftLabel.text = self.leftTitleInPickerView?:@"";
        self.leftLabel.tag = 10;
        self.leftLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleWidth;
        [self.pickerView addSubview:self.leftLabel];
    }
    
    
    if (![self.pickerView viewWithTag:11]) {
        self.rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(size.width + size2.width - 5.0f, y + (lineSpace/2 - 30/2), 40.0f, 30.0f)];
        self.rightLabel.text = self.rightTitleInPickerView?:@"";
        self.rightLabel.tag = 11;
        self.rightLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        [self.pickerView addSubview: self.rightLabel];
    }
    
    
    if (![self.pickerView viewWithTag:14]) {
        UIView *aboveLine1 = [[UIView alloc] initWithFrame:CGRectMake(size.width + (size2.width/2 -(size2.width - 45.0f)/2) + 5.0f , y, size2.width - 45.0f, 1.5f)];
        aboveLine1.backgroundColor = self.separatorLineColor;
        aboveLine1.tag = 14;
        aboveLine1.hidden =!self.showSeparatorLine;
        aboveLine1.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        [self.pickerView addSubview:aboveLine1];
    }
    
    
    if (![self.pickerView viewWithTag:15]) {
        UIView *belowline2 = [[UIView alloc] initWithFrame:CGRectMake(size.width + (size2.width/2 -(size2.width - 45.0f)/2) + 5.0f , y + lineSpace, size2.width - 45.0f, 1.5)];
        belowline2.backgroundColor = self.separatorLineColor;
        belowline2.tag = 15;
        belowline2.hidden = !self.showSeparatorLine;
        belowline2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        [self.pickerView addSubview:belowline2];
    }
    
    if (![self.pickerView viewWithTag:16]) {
        UIView *aboveLine3 = [[UIView alloc] initWithFrame:CGRectMake(size.width + size2.width + (size3.width/2 - ( size3.width - 45.0f)/2) + 5.0f , y, size3.width - 45.0f , 1.5f)];
        aboveLine3.backgroundColor = self.separatorLineColor;
        aboveLine3.tag = 16;
        aboveLine3.hidden = !self.showSeparatorLine;
        aboveLine3.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        [self.pickerView addSubview:aboveLine3];
    }
    
    
    if (![self.pickerView viewWithTag:17]) {
        UIView *belowLine4 = [[UIView alloc] initWithFrame:CGRectMake(size.width + size2.width + (size3.width/2 - ( size3.width - 45.0f)/2)  + 5.0f, y + lineSpace, size3.width - 45.0f , 1.5f)];
        belowLine4.backgroundColor = self.separatorLineColor;
        belowLine4.tag = 17;
        belowLine4.hidden =!self.showSeparatorLine;
        belowLine4.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        [self.pickerView addSubview:belowLine4];
    }
}

@end
