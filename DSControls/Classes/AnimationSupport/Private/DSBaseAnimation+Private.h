//
//  DSPropertyAnimation+Private.h
//  DSControls
//
//  Created by Dimas on 03.05.2018.
//

#import "DSBaseAnimation.h"
#import "DSViewBaseAnimation.h"
@interface DSBaseAnimation ()
@property(nonatomic,copy)DSCompleteAnimationBlock onPrivateComplete;
@end
@interface DSViewBaseAnimation ()
@property(nonatomic,copy)DSCompleteAnimationBlock onPrivateComplete;
@property(nonatomic,assign,readwrite)BOOL isRun;
@property(nonatomic,assign,readwrite)BOOL isCanceled;
@end
