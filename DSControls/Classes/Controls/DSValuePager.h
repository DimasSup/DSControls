//
//  DSValuePager.h
//  DSControls
//
//  Created by Dimas on 13.05.2018.
//

#import <UIKit/UIKit.h>
@class DSValuePager;

@protocol DSValuePagerDelegate<NSObject>

@end

@protocol DSValuePagerDataSource<NSObject>
-(NSUInteger)DS_valuePagerNumberOfRows:(DSValuePager*)pager;
-(NSObject*)DS_valuePager:(DSValuePager*)pager valueForRow:(NSUInteger)row;

@end

IB_DESIGNABLE
@interface DSValuePager : UIView

@property(nonatomic,nonnull,readonly,strong)UIPickerView* picker;
@property(nonatomic,nullable,weak)IBOutlet id<DSValuePagerDelegate> delegate;
@property(nonatomic,nullable,weak)IBOutlet id<DSValuePagerDataSource> dataSource;

@property(nonatomic,null_resettable,strong)IBInspectable UIFont* valueFont;
@property(nonatomic,null_resettable,copy)IBInspectable UIColor* valueFontColor;

@property(nonatomic,assign,readonly)NSUInteger selectedValue;
-(void)setupSelectedValue:(NSUInteger)value animated:(BOOL)animated;
@end
