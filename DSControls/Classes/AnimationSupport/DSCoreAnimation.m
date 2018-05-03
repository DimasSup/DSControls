//
//  DSCoreAnimation.m
//  DSControls
//
//  Created by Dimas on 03.05.2018.
//

#import "DSCoreAnimation.h"
#import "DSBaseAnimation+Private.h"

@interface DSCoreAnimation()<CAAnimationDelegate>

@end

@implementation DSCoreAnimation
- (instancetype)init
{
	self = [super init];
	if (self) {
		
	}
	return self;
}
- (instancetype)initWithObject:(__kindof CAAnimation *)animation
{
	self = [super init];
	if (self) {
		self.animation = animation;
	}
	return self;
}

-(void)setAnimation:(__kindof CAAnimation *)animation{
	_animation = animation;
	_animation.delegate = self;
}
-(CFTimeInterval)fullDuration{
	return self.animation.fullDuration;
}
#pragma mark -
-(void)animationDidStart:(CAAnimation *)anim{
	if(self.onStart)self.onStart();
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
	if(self.onComplete)self.onComplete(flag);
	if(self.onPrivateComplete)self.onPrivateComplete(flag);
}
@end
