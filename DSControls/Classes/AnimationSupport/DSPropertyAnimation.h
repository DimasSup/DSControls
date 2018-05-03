//
//  DSPropertyAnimation.h
//  DSControls
//
//  Created by Dimas on 03.05.2018.
//

#import "DSCoreAnimation.h"

@interface DSPropertyAnimation : DSCoreAnimation
-(instancetype)initWithObject:(__kindof CAPropertyAnimation *)animation;
@property(nonatomic,strong)__kindof CAPropertyAnimation* animation;

+(instancetype)animationForKey:(NSString*)key fromValue:(id)from toValue:(id)to withDuration:(CFTimeInterval)duration;

@end
