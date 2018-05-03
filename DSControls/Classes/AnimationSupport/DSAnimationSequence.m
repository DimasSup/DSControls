//
//  DSAnimationSequence.m
//  DSControls
//
//  Created by Dimas on 03.05.2018.
//

#import "DSAnimationSequence.h"

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
	
	return finishAnimations;
}
@end
