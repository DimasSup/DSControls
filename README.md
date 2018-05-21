# DSControls

[![CI Status](https://img.shields.io/travis/DimasSup/DSControls.svg?style=flat)](https://travis-ci.org/DimasSup/DSControls)
[![Version](https://img.shields.io/cocoapods/v/DSControls.svg?style=flat)](https://cocoapods.org/pods/DSControls)
[![License](https://img.shields.io/cocoapods/l/DSControls.svg?style=flat)](https://cocoapods.org/pods/DSControls)
[![Platform](https://img.shields.io/cocoapods/p/DSControls.svg?style=flat)](https://cocoapods.org/pods/DSControls)

## Documentation

### UIView animations
**DSViewOneAnimation** - one animation block item
```objective-c
DSVAnimation(0.4,^{
view.alpha = 0;
},^(BOOL finished){}).run;
```


**DSViewAnimationSequence**  - animations sequence, do all animations one by one. Callback will be called when all animations will be finished.
**DSViewGroupAnimation** - animations group. Run all animations in same time. Callback will be called when a longest animation will be finished ( * NOTE: longest animation calculated by __animation.fullDuration__ * )

**DSViewAnimationStack** - run animations one by one, First IN First OUT.


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
