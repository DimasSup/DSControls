//
//  DSViewGroupAnimation.h
//  DSControls
//
//  Created by Dimas on 16.05.2018.
//

#import "DSViewBaseAnimation.h"


#define DSVAGroup(anim,...) [DSViewGroupAnimation groupWithAnimations: anim,## __VA_ARGS__]

@interface DSViewGroupAnimation : DSViewBaseAnimation
@property(nonatomic,strong,readonly)NSArray<DSViewBaseAnimation*>* animations;
-(void)addAnimation:(DSViewBaseAnimation*)anim;

+(DSViewGroupAnimation *)groupWithAnimations:(__kindof DSViewBaseAnimation *)animations, ... NS_REQUIRES_NIL_TERMINATION;
@end
