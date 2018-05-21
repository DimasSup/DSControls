//
//  DSViewGroupAnimation.m
//  DSControls
//
//  Created by Dimas on 16.05.2018.
//

#import "DSViewGroupAnimation.h"
#import "DSBaseAnimation+Private.h"

@interface DSViewGroupAnimation()
{
	NSMutableArray<DSViewBaseAnimation*>* _animations;
}

@end;

@implementation DSViewGroupAnimation
@synthesize animations = _animations;
- (instancetype)init
{
	self = [super init];
	if (self) {
		_animations = [NSMutableArray new];
	}
	return self;
}

-(CFTimeInterval)fullDuration{
	return [[self.animations valueForKeyPath:@"@max.fullDuration"] doubleValue];
}
-(void)addAnimation:(DSViewBaseAnimation *)anim{
	if(self.isRun){
		NSLog(@"!!! Can't add animation while sequence running !!!");
		return;
	}
	@synchronized(_animations){
		[_animations addObject:anim];
	}
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
		if(self.onFinish)self.onFinish(NO);
		return;
	}
	self.isRun = YES;
	DSViewBaseAnimation* maxanim = nil;
	NSTimeInterval maxtime = 0;
	for (DSViewBaseAnimation* anim in self.animations) {
		if(anim.fullDuration>maxtime){
			maxanim = anim;
		}
	}
	__weak typeof (maxanim) weakAnim = maxanim;
	
	maxanim.onPrivateComplete = ^(BOOL success) {
		self.isRun = NO;
		if(self.onPrivateComplete)self.onPrivateComplete(success);
		if(self.onFinish)self.onFinish(success);
		weakAnim.onPrivateComplete = nil;
	};
	[self.animations makeObjectsPerformSelector:@selector(run)];
}
#pragma mark - static
+(DSViewGroupAnimation *)groupWithAnimations:(__kindof DSViewBaseAnimation *)animations, ... NS_REQUIRES_NIL_TERMINATION{
	DSViewGroupAnimation* animation = [[DSViewGroupAnimation alloc] init];
	__kindof DSViewBaseAnimation* eachObject;
	va_list argumentList;
	
	if (animations) // The first argument isn't part of the varargs list,
	{                                   // so we'll handle it separately.
		[animation addAnimation:animations];
		
		va_start(argumentList, animations); // Start scanning for arguments after firstObject.
		while ((eachObject = va_arg(argumentList, __kindof DSViewBaseAnimation*))){
			[animation addAnimation:eachObject];
			
		}
		va_end(argumentList);
	}
	
	return animation;
}

@end
