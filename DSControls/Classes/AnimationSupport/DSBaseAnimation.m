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
+(void)runAnimation:(__kindof DSBaseAnimation *)animation onLayer:(CALayer *)layer withKey:(NSString *)animationKey{
	CFTimeInterval startTime =  [layer convertTime: CACurrentMediaTime() fromLayer: nil];
	
	NSArray<__kindof CAAnimation*>* animations = [animation flatAnimations:startTime];
	
	if(!animation.onPrivateComplete){
		objc_setAssociatedObject(layer, [animationKey UTF8String], animation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
		__weak typeof(layer) weakLayer = layer;
		
		animation.onPrivateComplete = ^(BOOL success) {
			if(weakLayer){
				objc_setAssociatedObject(weakLayer, [animationKey UTF8String], nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
			}
		};
	}
	for (int i = 0; i<animations.count; i++) {
		CAAnimation* animation = animations[i];
		[layer addAnimation:animation forKey:[NSString stringWithFormat:@"%@_%i",animationKey,i]];
	}
	
	
//
//	CFTimeInterval duration = (animations.lastObject.beginTime+animations.lastObject.duration)-startTime;
//	CAAnimationGroup* group = [CAAnimationGroup new];
//	group.fillMode = kCAFillModeForwards;
//	group.beginTime = startTime;
//	group.duration = duration;
//	group.animations = animations;
//	group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//	group.removedOnCompletion = NO;
//
//	[layer addAnimation:group forKey:animationKey];
	
}
@end
