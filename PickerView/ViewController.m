//
//  ViewController.m
//  PickerView
//
//  Created by chengbin on 16/5/27.
//  Copyright © 2016年 chengbin. All rights reserved.
//

#import "ViewController.h"
#import "JMPickerView.h"
#import "JMPickerView+JMPickerViewLayout.h"
#import "YMUtils.h"
#import "NSArray+SafeAccess.h"
@interface ViewController ()<JMPickerViewDataSource,JMPickerViewDelegate>

@property (strong, nonatomic)  JMPickerView *jmPickerView;

@property (weak, nonatomic) IBOutlet UIView *mPickerView;

@property (weak, nonatomic) IBOutlet UISwitch *showSwitch;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@end

@implementation ViewController

{
    NSInteger row1;
    NSInteger row2;
    NSInteger row3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    row1 = 0;
    row2 = 0;
    row3 = 0;
    
    self.jmPickerView  = [JMPickerView instantiateInitialJMPickerViewFromNib];
    self.jmPickerView.delegate = self;
    self.jmPickerView.dataSource = self;
    [self.mPickerView addSubview: self.jmPickerView];
    [self.jmPickerView jm_pickerViewAutoLayout];// 必须调用 为了布局而已
    
    self.jmPickerView.systemSeparatorLineColor = [UIColor orangeColor];
    self.jmPickerView.rightTitleInPickerView = @"右";
    self.jmPickerView.leftTitleInPickerView = @"左";
    self.jmPickerView.showSystemSeparatorLine = YES;
    self.jmPickerView.title = @"文本标题";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (IBAction)showSepratorLine:(UISwitch *)sender {
   
    self.jmPickerView.showSystemSeparatorLine = !sender.isOn;
  
}

#pragma mark -
#pragma mark JMPickerViewDataSource & JMPickerViewDelegate

- (NSInteger)jm_numberOfComponentsInJMPickerView:(JMPickerView *)pickerView {
    return 3;
}

- (NSInteger)jm_pickerView:(JMPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [YMUtils getCityData].count;
    }
    else if (component == 1) {
        NSArray *array = [YMUtils getCityData][row1][@"children"];//需要 安全后去 数组，否则会数据越界了，这里就这样了吧，不改了
        if ((NSNull*)array != [NSNull null]) {
            return array.count;
        }
        return 0;
    }
    else {
        NSArray *array = [YMUtils getCityData][row1][@"children"];//需要 安全后去 数组，否则会数据越界了，这里就这样了吧，不改了
        if ((NSNull*)array != [NSNull null]) {
            NSArray *array1 = [YMUtils getCityData][row1][@"children"][row2][@"children"];//需要 安全后去 数组，否则会数据越界了，这里就这样了吧，不改了
            if ((NSNull*)array1 != [NSNull null]) {
                return array1.count;
            }
            return 0;
        }
        return 0;
    }
}

- (CGFloat)jm_pickerView:(JMPickerView *)pickerView widthForComponent:(NSInteger)component {

    return CGRectGetWidth(self.view.frame)/3;
}
- (CGFloat)jm_pickerView:(JMPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 40.0f;
}

- (nullable NSAttributedString *)jm_pickerView:(JMPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSDictionary *attibutes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFang-SC-Light" size:8],NSForegroundColorAttributeName:[UIColor redColor]};
    NSAttributedString *attibutedString = [[NSAttributedString alloc]initWithString:[self jm_pickerView:pickerView titleForRow:row forComponent:component] attributes:attibutes];
    
    return attibutedString;
}

- (nullable NSString *)jm_pickerView:(JMPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component == 0) {
        return [YMUtils getCityData][row][@"name"];
    }
    else if (component == 1) {
        return [YMUtils getCityData][row1][@"children"][row][@"name"];//需要 安全后去 数组，否则会数据越界了，这里就这样了吧，不改了
    }
    else if (component == 2) {
        return [YMUtils getCityData][row1][@"children"][row2][@"children"][row][@"name"];//需要 安全后去 数组，否则会数据越界了，这里就这样了吧，不改了
    }
    return nil;
}

- (void)jm_pickerView:(JMPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if (component == 0) {
        row1 = row;
        row2 = 0;
        row3 = 0;
        [self.jmPickerView reloadComponent:1];
        [self.jmPickerView reloadComponent:2];
        
    }
    else if (component == 1){
        row2 = row;
        row3 = 0;
        [self.jmPickerView reloadComponent:2];
        
    }
    else {
        row3 = row;
    }
    NSInteger cityRow1 = [self.jmPickerView selectedRowInComponent:0];
    NSInteger cityRow2 = [self.jmPickerView selectedRowInComponent:1];
    NSInteger cityRow3 = [self.jmPickerView selectedRowInComponent:2];
    NSMutableString *str = [[NSMutableString alloc]init];
    [str appendString:[YMUtils getCityData][cityRow1][@"name"]];//需要 安全后去 数组，否则会数据越界了，这里就这样了吧，不改了
    NSArray *array = [YMUtils getCityData][cityRow1][@"children"];//需要 安全后去 数组，否则会数据越界了，这里就这样了吧，不改了
    if ((NSNull*)array != [NSNull null]) {
        [str appendString:[YMUtils getCityData][cityRow1][@"children"][cityRow2][@"name"]];//需要 安全后去 数组，否则会数据越界了，这里就这样了吧，不改了
        NSArray *array1 = [YMUtils getCityData][cityRow1][@"children"][cityRow2][@"children"];//需要 安全后去 数组，否则会数据越界了，这里就这样了吧，不改了
        if ((NSNull*)array1 != [NSNull null]) {
            [str appendString:[YMUtils getCityData][cityRow1][@"children"][cityRow2][@"children"][cityRow3][@"name"]];//需要 安全后去 数组，否则会数据越界了，这里就这样了吧，不改了
        }
    }
    self.cityLabel.text = str;
   
}

- (void)jm_pickerView:(JMPickerView *)pickerView didTapLeftItem:(UIButton *)button {
    NSLog(@"++1");
}

- (void)jm_pickerView:(JMPickerView *)pickerView didTapRightItem:(UIButton *)button {
    NSLog(@"++2");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
