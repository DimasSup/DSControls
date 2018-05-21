# DSControls

[![CI Status](https://img.shields.io/travis/DimasSup/DSControls.svg?style=flat)](https://travis-ci.org/DimasSup/DSControls)
[![Version](https://img.shields.io/cocoapods/v/DSControls.svg?style=flat)](https://cocoapods.org/pods/DSControls)
[![License](https://img.shields.io/cocoapods/l/DSControls.svg?style=flat)](https://cocoapods.org/pods/DSControls)
[![Platform](https://img.shields.io/cocoapods/p/DSControls.svg?style=flat)](https://cocoapods.org/pods/DSControls)

## Documentation

### UIView animations
**DSViewOneAnimation** - one animation block item
```objective-c DSVAnimation_Delay(duration,action,finish_block)
DSVAnimation(0.4,^{
view.alpha = 0;
},^(BOOL finished){}).run;
```
```objective-c DSVAnimation_Delay(duration,delay,options,action,finish_block)
DSVAnimation_Delay(0.5, 1, UIViewAnimationOptionCurveEaseIn, ^{
view1.alpa = 1;
view2.frame = CGRectMake(0, 0, 320, 50);
}, ^(BOOL result){});
```
```objective-c DSVAnimation_Full(duration, delay, options, damping, velocity, action, finish_block)
DSVAnimation_Full(0.5, 1, UIViewAnimationOptionCurveEaseIn, 0.5, 0.5, ^{
view1.alpa = 1;
view2.frame = CGRectMake(0, 0, 320, 50);
}, ^(BOOL result){}).run;
```
Also you can use class methods -
```objective-c
+(DSViewOneAnimation*)animationWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animationOptions:(UIViewAnimationOptions)options actionBlock:(DSStartAnimationBlock)action finishBlock:(DSCompleteAnimationBlock)finishBlock;

+(DSViewOneAnimation*)animationWithDuration:(NSTimeInterval)duration actionBlock:(DSStartAnimationBlock)action finishBlock:(DSCompleteAnimationBlock)finishBlock;

+(DSViewOneAnimation*)animationWithDuration:(NSTimeInterval)duration delay:(float)delay animationOptions:(UIViewAnimationOptions)options springDamping:(float)damping springVelocity:(float)springVelocity actionBlock:(DSStartAnimationBlock)action finishBlock:(DSCompleteAnimationBlock)finishBlock;
```
After create animation you can run it with instance method _[animation run]_




**DSViewAnimationSequence**  - animations sequence, do all animations one by one. Callback will be called when all animations will be finished.
Add animations to sequence with instance method:
```objective-c
-(void)addAnimation:(__kindof DSViewBaseAnimation*)anim;
```
Create sequence:
```objective-c
DSVASequence(animation,...)
```
or with class method :
```objective-c
+(DSViewAnimationSequence*)sequenceWithAnimations:(__kindof DSViewBaseAnimation*)animations,... NS_REQUIRES_NIL_TERMINATION;
```
After create animation you can run it with instance method _[animation run]_
*NOTE: you can add __DSViewOneAnimation__ , __DSViewAnimationSequence__ and __DSViewGroupAnimation__ as animation in sequence*


**DSViewGroupAnimation** - animations group. Run all animations in same time. Callback will be called when a longest animation will be finished ( * NOTE: longest animation calculated by __animation.fullDuration__ * )

Add animations to sequence with instance method:
```objective-c
-(void)addAnimation:(__kindof DSViewBaseAnimation*)anim;
```
Create sequence:
```objective-c
DSVAGroup(animation,...)
```
or with class method :
```objective-c
+(DSViewGroupAnimation *)groupWithAnimations:(__kindof DSViewBaseAnimation *)animations, ... NS_REQUIRES_NIL_TERMINATION;
```
After create animation you can run it with instance method _[animation run]_
*NOTE: you can add __DSViewOneAnimation__ , __DSViewAnimationSequence__ and __DSViewGroupAnimation__ as animation in group*

**DSViewAnimationStack** - run animations one by one, First IN First OUT.
You can create it manualy or get instance for each UIView with instance method:
```objective-c
[UIView -(DSViewAnimationsStack*)defaultAnimationsStack];
```
or just push animation to instance stack with instance method:
```objective-c
[UIView -(void)pushAnimationToStack:(__kindof DSViewBaseAnimation*)animation];
```
You can add more than one instance of _Animations Stack_ for each UIView with using class method:
```objective-c
[UIView +(DSViewAnimationsStack*)animationsStackForView:(UIView*)view withName:(NSString*)name];
```

Add animation to stack:
```objective-c
[DSViewAnimationsStack -(void)pushAnimation:(__kindof DSViewBaseAnimation*)animation];
```
*NOTE: Animations in stacks start immediately after add to stack if there are no active animation*
*NOTE: you can add __DSViewOneAnimation__ , __DSViewAnimationSequence__ and __DSViewGroupAnimation__ as animation in group*

### CALayerAnimations

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Requirements

## Installation

DSControls is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DSControls'
```

## Author

DimasSup, dima.teleban@gmail.com

## License

DSControls is available under the MIT license. See the LICENSE file for more info.
