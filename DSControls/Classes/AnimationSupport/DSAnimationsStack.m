//
//  DSAnimationsStack.m
//  DSControls
//
//  Created by Dimas on 04.05.2018.
//

#import "DSAnimationsStack.h"
#import "DSBaseAnimation+Private.h"

@implementation DSAnimationsStack
{
	NSMutableArray<DSBaseAnimation*>* _animationsQueue;
	__block int _runIndex;
	__block BOOL _haveActiveAnimation;
	
}
- (instancetype)init
{
	self = [super init];
	if (self) {
		_animationsQueue = [NSMutableArray new];
	}
	return self;
}

-(void)pushAnimation:(__kindof DSBaseAnimation *)animation{
	@synchronized(self){
		[_animationsQueue addObject:animation];
	}
	[self startNextAnimation];
}
-(void)startNextAnimation{
	@synchronized(self){
		if(!_haveActiveAnimation){
			
			__weak DSBaseAnimation* animation = _animationsQueue.firstObject;
			if(animation){
				_haveActiveAnimation = YES;
				__weak typeof (self) weakSelf = self;
				animation.onPrivateComplete = ^(BOOL success) {
					if(animation){
						@synchronized(weakSelf){
							
							if(weakSelf){
								DSAnimationsStack* anim = weakSelf;
								[anim->_animationsQueue removeObject:animation];
								anim->_haveActiveAnimation = NO;
								if(anim->_animationsQueue.count>0){
									if(anim.onFinishOne)anim.onFinishOne(success);
								}
								else{
									if(anim.onFinishAll)anim.onFinishAll(success);
								}
							}
						}
						dispatch_async(dispatch_get_main_queue(), ^{
							[weakSelf startNextAnimation];
						});
					}
				};
				_runIndex  = 1 - _runIndex;
				[DSBaseAnimation runAnimation:animation onLayer:self.targetLayer withKey:[NSString stringWithFormat:@"%@_%i",self.animationKey?:@"animation_stack",_runIndex]];
			}
		}
	}
}
@end

@implementation CALayer(DSAnimationStack)
static char CALayerDSAnimationStackKey;
-(DSAnimationsStack *)animationStack{
	DSAnimationsStack* stack = objc_getAssociatedObject(self, &CALayerDSAnimationStackKey);
	if(!stack){
		stack = [DSAnimationsStack new];
		stack.targetLayer = self;
		objc_setAssociatedObject(self, &CALayerDSAnimationStackKey, stack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return stack;
}
-(DSAnimationsStack *)addAnimationToStack:(__kindof DSBaseAnimation *)animation{
	DSAnimationsStack* stack = [self animationStack];
	[stack pushAnimation:animation];
	return stack;
}
@end
