//
//  DSBaseAnimation.h
//  DSControls
//
//  Created by Dimas on 03.05.2018.
//

#import <Foundation/Foundation.h>
#import "DSAnimationCommon.h"

@interface DSBaseAnimation : NSObject

@property(nonatomic,copy)DSCompleteAnimationBlock onComplete;
@property(nonatomic,copy)DSStartAnimationBlock onStart;

@property(nonatomic,assign)CFTimeInterval delay;
@property(nonatomic,readonly,assign)CFTimeInterval fullDuration;

-(NSArray<__kindof CAAnimation*>*)flatAnimations:(CFTimeInterval)time;


+(__kindof CAAnimation*)runAnimation:(__kindof DSBaseAnimation *)animation onLayer:(CALayer *)layer withKey:(NSString *)animationKey;
@end
