//
//  DSAnimationSequence.m
//  DSControls
//
//  Created by Dimas on 03.05.2018.
//

#import "DSAnimationSequence.h"
#import "DSBaseAnimation+Private.h"

@implementation DSAnimationSequence
-(CFTimeInterval)fullDuration{
	return [[self.animations valueForKeyPath:@"@sum.fullDuration"] doubleValue];
}
-(NSArray<CAAnimation *> *)flatAnimations:(CFTimeInterval)time{
	NSMutableArray<CAAnimation*>* finishAnimations = [NSMutableArray new];
	
	CFTimeInterval begintime = time+self.delay;
	for (DSBaseAnimation* animation in self.animations) {
		NSArray<CAAnimation*>* flatanimations = [animation flatAnimations:begintime];
		begintime = flatanimations.lastObject.beginTime + flatanimations.lastObject.duration;
		[finishAnimations addObjectsFromArray:flatanimations];
	}
	__weak typeof(self) weakSelf = self;
	self.animations.lastObject.onPrivateComplete = ^(BOOL success) {
		[weakSelf notifyFinish:success];
	};
	return finishAnimations;
}
#pragma mark -
-(void)notifyFinish:(BOOL)success{
	if(self.onComplete)self.onComplete(success);
	if(self.onPrivateComplete)self.onPrivateComplete(success);
}
#pragma mark -
+(instancetype)sequenceWithAnimations:(DSBaseAnimation *)animations, ...{
	DSAnimationSequence* animation = [[DSAnimationSequence alloc] init];
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
