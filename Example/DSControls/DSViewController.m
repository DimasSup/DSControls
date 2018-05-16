//
//  DSViewController.m
//  DSControls
//
//  Created by DimasSup on 05/03/2018.
//  Copyright (c) 2018 DimasSup. All rights reserved.
//

#import "DSViewController.h"
@import DSControls;

@interface DSViewController ()<DSValuePagerDelegate,DSValuePagerDataSource>
@property (weak, nonatomic) IBOutlet DSValuePager *valuePager;

@property (weak, nonatomic) IBOutlet UIView *targetView;

@end

@implementation DSViewController


- (void)viewDidLoad
{
	
	
	self.targetView.layer.backgroundColor = [UIColor redColor].CGColor;
	self.targetView.layer.frame = CGRectMake(0, 0, 100, 100);
	
	self.valuePager.clipsToBounds = YES;
	self.valuePager.layer.cornerRadius = 10;
	self.valuePager.layer.borderColor = UIColor.blackColor.CGColor;
	self.valuePager.layer.borderWidth = 1;
	
	DSVASequence(DSVAnimation(5,^(){
		self.targetView.frame = CGRectMake(200, 200, 50, 50);
	},^(BOOL finished){
		NSLog(@"Finished 1");
	}),DSVAnimation(5,^{self.targetView.alpha = 0;},^(BOOL finished){
		NSLog(@"finished 2");
	}),nil).run;
	
	
	
	
//	DSAnimationSequence* animation = DSASequence(group,group2,[DSPropertyAnimation animationForKey:@"opacity" fromValue:@(1) toValue:@(0) withDuration:3],nil);
//	animation.onComplete = ^(BOOL success) {
//		NSLog(@"Finish all");
//	};
	
	
//	[DSBaseAnimation runAnimation:animation onLayer:self.targetView.layer withKey:@"random"];
	
//	__weak typeof (animation) weakAnim = animation;
//	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//		NSLog(@"Weak animation %@",weakAnim);
//	});
	
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
-(NSObject *)DS_valuePager:(DSValuePager *)pager valueForRow:(NSUInteger)row{
	return [NSString stringWithFormat:@"%li",30- row];
}
-(NSUInteger)DS_valuePagerNumberOfRows:(DSValuePager *)pager{
	return 30;
}

- (IBAction)sliderValueChanged:(UISlider*)sender {
	[self.valuePager setupSelectedValue:(NSUInteger)sender.value animated:YES];
}

@end
