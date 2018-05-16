//
//  DSViewOneAnimation.h
//  DSControls
//
//  Created by Dimas on 15.05.2018.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DSAnimationCommon.h"
#import "DSViewBaseAnimation.h"

@class DSViewOneAnimation;

#define DSVAnimation_Simple(duration,action,finish) [DSViewOneAnimation animationWithDuration:duration actionBlock:action finishBlock:finish]
#define DSVAnimation_Delay(duration,delay,options,action,finish) [DSViewOneAnimation animationWithDuration:duration delay:delay animationOptions:options actionBlock:action finishBlock:finish]
#define DSVAnimation_Full(duration,delay,options,damping,velocity,action,finish) [DSViewOneAnimation animationWithDuration:duration delay:delay animationOptions:options springDamping:damping springVelocity:velocity actionBlock:action finishBlock:finish]

#define DSVAnimation( ... ) VA_SELECT( DSVAnimation, __VA_ARGS__ )
#define DSVAnimation_3( duration, action,finish ) DSVAnimation_Simple(duration,action,finish)
#define DSVAnimation_5( duration,delay,options,action,finish ) DSVAnimation_Delay(duration,delay,options,action,finish)
#define DSVAnimation_7( duration,delay,options,damping,velocity,action,finish) DSVAnimation_Full(duration,delay,options,damping,velocity,action,finish)



@interface DSViewOneAnimation : DSViewBaseAnimation

@property(nonatomic,assign)NSTimeInterval duration;
@property(nonatomic,assign)NSTimeInterval delay;
@property(nonatomic,copy)DSStartAnimationBlock animation;
@property(nonatomic,copy)DSCompleteAnimationBlock orignalFinishBlock;

@property(nonatomic,assign)UIViewAnimationOptions options;

@property(nonatomic,assign)BOOL useSpring;

@property(nonatomic,assign)CGFloat springDamping;
@property(nonatomic,assign)CGFloat springVelocity;

-(instancetype)initWithDuration:(NSTimeInterval)duration actionBlock:(DSStartAnimationBlock)action finishBlock:(DSCompleteAnimationBlock)finishBlock;

+(DSViewOneAnimation*)animationWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animationOptions:(UIViewAnimationOptions)options actionBlock:(DSStartAnimationBlock)action finishBlock:(DSCompleteAnimationBlock)finishBlock;
+(DSViewOneAnimation*)animationWithDuration:(NSTimeInterval)duration actionBlock:(DSStartAnimationBlock)action finishBlock:(DSCompleteAnimationBlock)finishBlock;

+(DSViewOneAnimation*)animationWithDuration:(NSTimeInterval)duration delay:(float)delay animationOptions:(UIViewAnimationOptions)options springDamping:(float)damping springVelocity:(float)springVelocity actionBlock:(DSStartAnimationBlock)action finishBlock:(DSCompleteAnimationBlock)finishBlock;




@end
