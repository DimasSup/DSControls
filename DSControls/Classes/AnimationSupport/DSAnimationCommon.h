
//
//  DSAnimationCommon.h
//  Pods
//
//  Created by Dimas on 03.05.2018.
//

#ifndef DSAnimationCommon_h
#define DSAnimationCommon_h
#import <objc/runtime.h>

static char kCAAnimationAssociatedDelayKey;

typedef void(^DSCompleteAnimationBlock)(BOOL success);
typedef void(^DSStartAnimationBlock)(void);

@interface CAAnimation(DSAnimationExtension)
@property(readonly,nonatomic,assign)CFTimeInterval fullDuration;
@property(nonatomic,assign)CFTimeInterval delay;
@end
@implementation CAAnimation(DSAnimationExtension)
-(CFTimeInterval)fullDuration{
	return self.duration+self.delay;
}
-(void)setDelay:(CFTimeInterval)delay{
	objc_setAssociatedObject(self, &kCAAnimationAssociatedDelayKey, @(delay), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(CFTimeInterval)delay{
	return [objc_getAssociatedObject(self, &kCAAnimationAssociatedDelayKey) doubleValue];
}

@end

#endif /* DSAnimationCommon_h */
