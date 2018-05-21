//
//  DSViewAnimationsStuck.h
//  DSControls
//
//  Created by Dimas on 20.05.2018.
//

#import <Foundation/Foundation.h>
#import "DSViewBaseAnimation.h"

@interface DSViewAnimationsStack : NSObject

@property(nonatomic,assign,readonly)BOOL isRun;
-(void)stop;
-(void)run;
@property(nonatomic,strong)DSCompleteAnimationBlock onFinishAll;
@property(nonatomic,strong)DSCompleteAnimationBlock onFinishOne;

-(void)pushAnimation:(__kindof DSViewBaseAnimation*)animation;
@end

@interface UIView(DSViewAnimations)
-(DSViewAnimationsStack*)defaultAnimationsStack;
-(void)pushAnimationToStack:(__kindof DSViewBaseAnimation*)animation;
+(DSViewAnimationsStack*)animationsStackForView:(UIView*)view withName:(NSString*)name;
@end
