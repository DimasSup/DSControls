//
//  DSViewAnimationSequence.h
//  DSControls
//
//  Created by Dimas on 16.05.2018.
//

#import "DSViewBaseAnimation.h"

#define DSVASequence(animation,...) [DSViewAnimationSequence sequenceWithAnimations: animation,## __VA_ARGS__]


@interface DSViewAnimationSequence : DSViewBaseAnimation
@property(nonatomic,strong,readonly)NSArray<__kindof DSViewBaseAnimation*>* animations;
-(void)addAnimation:(__kindof DSViewBaseAnimation*)anim;
+(DSViewAnimationSequence*)sequenceWithAnimations:(__kindof DSViewBaseAnimation*)animations,... NS_REQUIRES_NIL_TERMINATION;

@end
