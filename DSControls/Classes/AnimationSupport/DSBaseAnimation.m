//
//  DSBaseAnimation.m
//  DSControls
//
//  Created by Dimas on 03.05.2018.
//

#import "DSBaseAnimation.h"
#import "DSBaseAnimation+Private.h"

@implementation DSBaseAnimation
-(NSArray<CAAnimation *> *)flatAnimations:(CFTimeInterval)time{
	NSAssert(NO, @"flat animations method should be implemented");
	return @[];
}
+(__kindof CAAnimation*)runAnimation:(__kindof DSBaseAnimation *)animation onLayer:(CALayer *)layer withKey:(NSString *)animationKey{
	CFTimeInterval startTime = CACurrentMediaTime();
	NSArray<__kindof CAAnimation*>* animations = [animation flatAnimations:startTime];
	CFTimeInterval duration = (animations.lastObject.beginTime+animations.lastObject.duration)-startTime;
	CAAnimationGroup* group = [CAAnimationGroup new];
	group.beginTime = startTime;
	group.duration = duration;
	group.animations = animations;
	[layer addAnimation:group forKey:animationKey];
	return group;
}
@end
