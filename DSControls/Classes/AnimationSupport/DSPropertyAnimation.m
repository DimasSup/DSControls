//
//  DSPropertyAnimation.m
//  DSControls
//
//  Created by Dimas on 03.05.2018.
//

#import "DSPropertyAnimation.h"

@interface DSPropertyAnimation()<CAAnimationDelegate>
@end

@implementation DSPropertyAnimation
- (instancetype)initWithObject:(__kindof CAPropertyAnimation *)animation{
	self = [self init];
	if(self){
		self.animation = animation;
	}
	return self;
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
	[super animationDidStop:anim finished:flag];
}
-(NSArray<CAAnimation *> *)flatAnimations:(CFTimeInterval)time{
	self.animation.beginTime += time + self.animation.delay;

	if([self.animation isKindOfClass:[CABasicAnimation class]] && [self.animation.keyPath isEqualToString:@"frame"]){
		CABasicAnimation* a = [self.animation copy];
		a.keyPath = @"bounds";
		
		CGRect startFrame = [a.fromValue CGRectValue];
		startFrame.origin = CGPointZero;
		CGRect endFrame = [a.toValue CGRectValue];
		endFrame.origin = CGPointZero;
		if(a.fromValue){
			a.fromValue = [NSValue valueWithCGRect:startFrame];
		}
		a.toValue =  [NSValue valueWithCGRect:endFrame];
		a.delegate = nil;
		
		CABasicAnimation* originAnim = [self.animation copy];
		if(originAnim.fromValue){
			originAnim.fromValue = [NSValue valueWithCGPoint:[originAnim.fromValue CGRectValue].origin];
		}
		originAnim.toValue = [NSValue valueWithCGPoint:[originAnim.toValue CGRectValue].origin];
		originAnim.keyPath = @"position";
		
		return @[a,originAnim];
	}
	else{
		return @[self.animation];
	}
}

+(instancetype)animationForKey:(NSString*)key fromValue:(id)from toValue:(id)to withDuration:(CFTimeInterval)duration{
	
	CABasicAnimation* animation = [[CABasicAnimation alloc] init];
	animation.keyPath = key;
	animation.fromValue = from;
	animation.toValue = to;
	animation.duration = duration;
	animation.removedOnCompletion = FALSE;
	animation.fillMode = kCAFillModeForwards;
	
	return [[self alloc] initWithObject:animation];
	
}
@end
