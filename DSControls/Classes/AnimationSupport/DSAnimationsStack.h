//
//  DSAnimationsStack.h
//  DSControls
//
//  Created by Dimas on 04.05.2018.
//

#import <Foundation/Foundation.h>
#import "DSBaseAnimation.h"


@interface DSAnimationsStack : NSObject
@property(nonatomic,weak)CALayer* targetLayer;
@property(nonatomic,strong)NSString* animationKey;
@property(nonatomic,strong)DSCompleteAnimationBlock onFinishAll;
@property(nonatomic,strong)DSCompleteAnimationBlock onFinishOne;

-(void)pushAnimation:(__kindof DSBaseAnimation*)animation;

@end

@interface CALayer(DSAnimationStack)
-(DSAnimationsStack*)addAnimationToStack:(__kindof DSBaseAnimation*)animation;
-(DSAnimationsStack*)animationStack;
@end
