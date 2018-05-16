//
//  DSValuePager.m
//  DSControls
//
//  Created by Dimas on 13.05.2018.
//

#import "DSValuePager.h"

@interface DSValuePager()<UIPickerViewDataSource,UIPickerViewDelegate>

@end

@implementation DSValuePager
-(UIFont*)defaultFont{
	return [UIFont fontWithName:@"HelveticaNeue" size:15];
}
-(UIColor*)defaultColor{
	return [UIColor blackColor];
}
-(void)setup{
	if(!_picker){
		_picker = [UIPickerView new];
		_picker.delegate = self;
		_picker.dataSource = self;
		_picker.userInteractionEnabled = NO;
		
		[self addSubview:_picker];
	}
}
-(UIFont *)valueFont{
	if(!_valueFont){
		_valueFont = [self defaultFont];
	}
	return _valueFont;
}
-(UIColor *)valueFontColor{
	if(!_valueFontColor){
		_valueFontColor = [self defaultColor];
	}
	return _valueFontColor;
}
-(void)awakeFromNib{
	[super awakeFromNib];
	[self setup];
}

-(void)layoutSubviews{
	[super layoutSubviews];
	self.picker.frame = self.bounds;
}
-(void)setupSelectedValue:(NSUInteger)value animated:(BOOL)animated{
	if(_selectedValue!=value){
		_selectedValue = value;
		[self.picker selectRow:value inComponent:0 animated:animated];
	}
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return [self.dataSource DS_valuePagerNumberOfRows:self];
}
#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
	return self.bounds.size.height;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
	NSMutableParagraphStyle* pStyle = [NSMutableParagraphStyle new];
	pStyle.alignment = NSTextAlignmentCenter;
	return [[NSAttributedString alloc] initWithString:[[self.dataSource DS_valuePager:self valueForRow:row] description]
									attributes:@{
												 NSFontAttributeName:self.valueFont,
												 NSForegroundColorAttributeName:self.valueFontColor,
												 NSParagraphStyleAttributeName:pStyle
												 }];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
}

@end
