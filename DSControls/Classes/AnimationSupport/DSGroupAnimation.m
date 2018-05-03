//
//  DSGroupAnimation.m
//  DSControls
//
//  Created by Dimas on 03.05.2018.
//

#import "DSGroupAnimation.h"

@implementation DSGroupAnimation
-(void)setAnimations:(NSArray<DSBaseAnimation *> *)animations{
	_animations = [animations copy];
	
	CFTimeInterval maxDuration = [[_animations valueForKeyPath:@"@max.fullDuration"] doubleValue];
	self.animation.duration = maxDuration;
	
}
-(CAAnimationGroup *)animation{
	CAAnimationGroup* group = [super animation];
	if(!group){
		group = self.animation = [[CAAnimationGroup alloc] init];
	}
	return group;
}

-(NSArray<CAAnimation *> *)flatAnimations:(CFTimeInterval)time{
	NSAssert(self.animation, @"Animation should be specified");
	
	self.animation.beginTime = time + self.delay;
	
	NSMutableArray<CAAnimation*>* animations = [NSMutableArray new];
	
	for (DSBaseAnimation* animation in self.animations) {
		[animations addObjectsFromArray: [animation flatAnimations:self.animation.beginTime]];
	}
	self.animation.animations = animations;
	
	return @[self.animation];
}

#pragma mark -
+(instancetype)groupWithAnimations:(__kindof DSBaseAnimation *)animations, ...{
	DSGroupAnimation* animation = [[DSGroupAnimation alloc] init];
	NSMutableArray<__kindof DSBaseAnimation*>* animationsList = [NSMutableArray new];
	
	__kindof DSBaseAnimation* eachObject;
	va_list argumentList;
	
	if (animations) // The first argument isn't part of the varargs list,
	{                                   // so we'll handle it separately.
		[animationsList addObject:animations];
		
		va_start(argumentList, animations); // Start scanning for arguments after firstObject.
		while ((eachObject = va_arg(argumentList, __kindof DSBaseAnimation*))) // As many times as we can get an argument of type "id"
			[animationsList addObject: eachObject]; // that isn't nil, add it to self's contents.
		va_end(argumentList);
	}
	animation.animations = animationsList;
	return animation;
}

@end
