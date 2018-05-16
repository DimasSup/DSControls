//
//  DSViewBaseAnimation.h
//  DSControls
//
//  Created by Dimas on 15.05.2018.
//

#import <Foundation/Foundation.h>
#import "DSAnimationCommon.h"
@interface DSViewBaseAnimation : NSObject
@property(nonatomic,assign,readonly)BOOL isRun;
@property(nonatomic,assign,readonly)NSTimeInterval fullDuration;
@property(nonatomic,copy)DSCompleteAnimationBlock onFinish;
-(void)run;
@end
