//
//  DSViewAnimationSequence.m
//  DSControls
//
//  Created by Dimas on 16.05.2018.
//

#import "DSViewAnimationSequence.h"
@interface DSViewAnimationSequence()
{
	NSMutableArray<__kindof DSViewBaseAnimation*>* _animations;
}
@property(nonatomic,assign)BOOL isRun;
@end

@implementation DSViewAnimationSequence
@synthesize isRun = _isRun;
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
	return [[self.animations valueForKeyPath:@"@sum.fullDuration"] doubleValue];
}
-(void)addAnimation:(__kindof DSViewBaseAnimation *)anim{
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
	self.isRun = YES;
	
	[self runAnimationByIndex:0];
	
}
-(void)runAnimationByIndex:(NSInteger)index{
	if(index>=self.animations.count){
		self.isRun = NO;
		if(self.onFinish){
			self.onFinish(YES);
		}
		return;
	}
	DSViewBaseAnimation* animation = self.animations[index];
	__weak typeof(animation) weakAnim = animation;
	animation.onFinish = ^(BOOL success) {
		[self runAnimationByIndex:index+1];
		weakAnim.onFinish = nil;
	};
	[animation run];
}

#pragma mark -  static
+(DSViewAnimationSequence *)sequenceWithAnimations:(__kindof DSViewBaseAnimation *)animations, ... NS_REQUIRES_NIL_TERMINATION{
	DSViewAnimationSequence* animation = [[DSViewAnimationSequence alloc] init];
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
