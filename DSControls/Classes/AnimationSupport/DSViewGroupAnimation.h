//
//  DSViewGroupAnimation.h
//  DSControls
//
//  Created by Dimas on 16.05.2018.
//

#import "DSViewBaseAnimation.h"


#define DSVAGroup(animation,...) [DSViewGroupAnimation groupWithAnimations: animation,## __VA_ARGS__]

@interface DSViewGroupAnimation : DSViewBaseAnimation
@property(nonatomic,strong,readonly)NSArray<DSViewBaseAnimation*>* animations;
-(void)addAnimation:(__kindof DSViewBaseAnimation*)anim;

+(DSViewGroupAnimation *)groupWithAnimations:(__kindof DSViewBaseAnimation *)animations, ... NS_REQUIRES_NIL_TERMINATION;
@end
