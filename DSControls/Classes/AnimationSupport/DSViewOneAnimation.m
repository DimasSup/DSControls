//
//  DSViewOneAnimation.m
//  DSControls
//
//  Created by Dimas on 15.05.2018.
//

#import "DSViewOneAnimation.h"
#import "DSBaseAnimation+Private.h"

@interface DSViewOneAnimation()

@end

@implementation DSViewOneAnimation


-(NSTimeInterval)fullDuration{
	return self.duration+self.delay;
}
- (instancetype)initWithDuration:(NSTimeInterval)duration actionBlock:(DSStartAnimationBlock)action finishBlock:(DSCompleteAnimationBlock)finishBlock
{
	self = [super init];
	if (self) {
		self.duration = duration;
		self.animation = action;
		self.orignalFinishBlock = finishBlock;
		self.springVelocity = 0.5;
		self.springDamping = 0.5;
	}
	return self;
}
-(void)run{
	if(![NSThread mainThread]){
		[self performSelectorOnMainThread:@selector(run) withObject:nil waitUntilDone:NO];
		return;
	}
	if(self.isRun)
		return;
	if(self.isCanceled){
		if(self.onPrivateComplete)self.onPrivateComplete(NO);
		if(self.orignalFinishBlock) self.orignalFinishBlock(NO);
		if(self.onFinish)self.onFinish(NO);
		return;
	}
	
	self.isRun = YES;
	
	
	if(self.useSpring){
		[UIView animateWithDuration:self.duration delay:self.delay usingSpringWithDamping:self.springDamping initialSpringVelocity:self.springVelocity options:self.options animations:self.animation completion:^(BOOL finished) {
			self.isRun = NO;
			if(self.onPrivateComplete)self.onPrivateComplete(finished);
			if(self.orignalFinishBlock) self.orignalFinishBlock(finished);
			
			if(self.onFinish)self.onFinish(finished);
		}];
	}
	else{
		[UIView animateWithDuration:self.duration delay:self.delay options:self.options animations:self.animation completion:^(BOOL finished) {
			self.isRun = NO;
			if(self.onPrivateComplete)self.onPrivateComplete(finished);
			if(self.orignalFinishBlock) self.orignalFinishBlock(finished);
			if(self.onFinish)self.onFinish(finished);
		}];
	}
}
#pragma mark - static
+(DSViewOneAnimation *)animationWithDuration:(NSTimeInterval)duration actionBlock:(DSStartAnimationBlock)action finishBlock:(DSCompleteAnimationBlock)finishBlock{
	
	return [self animationWithDuration:duration delay:0 animationOptions:0 actionBlock:action finishBlock:finishBlock];
}
+(DSViewOneAnimation *)animationWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animationOptions:(UIViewAnimationOptions)options actionBlock:(DSStartAnimationBlock)action finishBlock:(DSCompleteAnimationBlock)finishBlock{
	
	DSViewOneAnimation* animation = [[DSViewOneAnimation alloc] initWithDuration:duration actionBlock:action finishBlock:finishBlock];
	animation.delay = delay;
	animation.options = options;
	
	return animation;
	
}
+(DSViewOneAnimation *)animationWithDuration:(NSTimeInterval)duration delay:(float)delay animationOptions:(UIViewAnimationOptions)options springDamping:(float)damping springVelocity:(float)springVelocity actionBlock:(DSStartAnimationBlock)action finishBlock:(DSCompleteAnimationBlock)finishBlock{
	
	
	
	DSViewOneAnimation* animation = [[DSViewOneAnimation alloc] initWithDuration:duration actionBlock:action finishBlock:finishBlock];
	animation.delay = delay;
	animation.options = options;
	animation.useSpring = YES;
	animation.springDamping = damping;
	animation.springVelocity = springVelocity;
	return animation;
}
@end
