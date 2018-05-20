//
//  DSViewAnimationsStuck.m
//  DSControls
//
//  Created by Dimas on 20.05.2018.
//

#import "DSViewAnimationsStack.h"
#import "DSBaseAnimation+Private.h"
#import <objc/runtime.h>

@interface DSViewAnimationsStack()
@property(nonatomic,strong)NSMutableArray<DSViewBaseAnimation*>* animations;
@property(nonatomic,assign,readwrite)BOOL isRun;
@end

@implementation DSViewAnimationsStack

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.animations = [NSMutableArray new];
	}
	return self;
}
-(void)pushAnimation:(DSViewBaseAnimation *)animation{
	@synchronized(self.animations){
		[self.animations addObject:animation];
	}
	
	[self runNextAnimation];
}
-(void)runNextAnimation{
	if(![NSThread isMainThread]){
		[self performSelectorOnMainThread:@selector(runNextAnimation) withObject:nil waitUntilDone:NO];
		return;
	}
	@synchronized(self.animations){
		if(self.isRun) return;
		DSViewBaseAnimation* animation = [self.animations firstObject];
		if(animation){
			self.isRun = YES;
			
			__weak typeof(animation) weakAnim = animation;
			__weak typeof(self) weakSelf = self;
			
			animation.onPrivateComplete = ^(BOOL success) {
				weakAnim.onPrivateComplete = nil;
				if(!weakSelf)return;
				@synchronized(weakSelf.animations){
					NSInteger index = [weakSelf.animations indexOfObjectPassingTest:^BOOL(DSViewBaseAnimation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
						BOOL val = obj == weakAnim;
						if(val){
							*stop = val;
						}
						return val;
						
					}];
					if(index!=NSNotFound){
						[weakSelf.animations removeObjectAtIndex:index];
					}
				}
				weakSelf.isRun = NO;
				if(weakSelf.onFinishOne)weakSelf.onFinishOne(success);
				dispatch_async(dispatch_get_main_queue(), ^{
					[weakSelf runNextAnimation];
				});
				
				
			};
			[animation run];
		}
		else{
			if(self.onFinishAll)self.onFinishAll(YES);
		}
		
	}
}
@end

@implementation UIView(DSViewAnimations)
-(DSViewAnimationsStack*)defaultAnimationsStack{
	return [UIView animationsStackForView:self withName:@"default_animations_stack"];
}
-(void)pushAnimationToStack:(DSViewBaseAnimation*)animation{
	[[self defaultAnimationsStack] pushAnimation:animation];
}
+(DSViewAnimationsStack*)animationsStackForView:(UIView*)view withName:(NSString*)name{
	DSViewAnimationsStack* stack = objc_getAssociatedObject(view, [name UTF8String]);
	if(!stack){
		stack = [[DSViewAnimationsStack alloc] init];
		objc_setAssociatedObject(view, [name UTF8String], stack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return stack;
}
@end
