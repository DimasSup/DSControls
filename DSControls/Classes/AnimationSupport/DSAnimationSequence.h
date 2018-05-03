//
//  DSAnimationSequence.h
//  DSControls
//
//  Created by Dimas on 03.05.2018.
//

#import "DSBaseAnimation.h"

@interface DSAnimationSequence : DSBaseAnimation
@property(nonatomic,strong)NSArray<__kindof DSBaseAnimation*>* animations;
@end
