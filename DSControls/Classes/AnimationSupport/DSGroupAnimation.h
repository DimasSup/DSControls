//
//  DSGroupAnimation.h
//  DSControls
//
//  Created by Dimas on 03.05.2018.
//

#import "DSPropertyAnimation.h"

#define DSAGroup(anim,...) [DSGroupAnimation groupWithAnimations: anim,## __VA_ARGS__]


@interface DSGroupAnimation : DSCoreAnimation
@property(nonatomic,readonly,strong)CAAnimationGroup* animation;
@property(nonatomic,copy)NSArray<DSBaseAnimation*>* animations;

+(instancetype)groupWithAnimations:(DSBaseAnimation*)animations,... NS_REQUIRES_NIL_TERMINATION;
@end
