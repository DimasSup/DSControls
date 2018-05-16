
//
//  DSAnimationCommon.h
//  Pods
//
//  Created by Dimas on 03.05.2018.
//

#ifndef DSAnimationCommon_h
#define DSAnimationCommon_h
#import <objc/runtime.h>

#define CAT( A, B ) A ## B
#define SELECT( NAME, NUM ) CAT( NAME ## _, NUM )
#define COMPOSE( NAME, ARGS ) NAME ARGS

#define GET_COUNT( _0, _1, _2, _3, _4, _5, _6,_7 /* ad nauseam */, COUNT, ... ) COUNT
#define EXPAND() ,,,,,,, // 6 commas (or 7 empty tokens)
#define VA_SIZE( ... ) COMPOSE( GET_COUNT, (EXPAND __VA_ARGS__ (), 0,7, 6, 5, 4, 3, 2, 1) )

#define VA_SELECT( NAME, ... ) SELECT( NAME, VA_SIZE(__VA_ARGS__) )(__VA_ARGS__)


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
