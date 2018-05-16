//
//  DSCoreAnimation.h
//  DSControls
//
//  Created by Dimas on 03.05.2018.
//

#import "DSBaseAnimation.h"

@interface DSCoreAnimation : DSBaseAnimation<CAAnimationDelegate>
-(instancetype)init;
-(instancetype)initWithObject:(__kindof CAAnimation*)animation;
@property(nonatomic,strong)__kindof CAAnimation* animation;
@end
