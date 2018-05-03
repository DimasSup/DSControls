//
//  DSPropertyAnimation.m
//  DSControls
//
//  Created by Dimas on 03.05.2018.
//

#import "DSPropertyAnimation.h"

@implementation DSPropertyAnimation

-(NSArray<CAAnimation *> *)flatAnimations:(CFTimeInterval)time{
	self.animation.beginTime += time + self.animation.delay;
	return @[self.animation];
}


+(instancetype)animationForKey:(NSString*)key fromValue:(id)from toValue:(id)to withDuration:(CFTimeInterval)duration{
	
	CABasicAnimation* animation = [[CABasicAnimation alloc] init];
	animation.keyPath = key;
	animation.fromValue = from;
	animation.toValue = to;
	animation.duration = duration;
	
	return [[self alloc] initWithObject:animation];
	
}
@end
