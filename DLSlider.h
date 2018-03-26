/*
 * cocos2d+ext for iPhone
 * Horizontal slider
 * This class used with equal fluency
 *
 */

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCNode+Ext.h"

@interface DLSlider : CCNode <CCTargetedTouchDelegate>{
    float _minValue;
    float _maxValue;
    float _value;
    
    SEL _selector;
    id _target;
    
    BOOL _trackingTouch;
    BOOL _trackTouchOutsideContent;
    BOOL _evaluateFirstTouch;
    BOOL _enabled;
    
    float _width;
    float _height;
    
    CCSprite *_track;
    CCSprite *_knob;
    CGPoint _thumbPosition;
}
@property(nonatomic) float minValue;
@property(nonatomic) float maxValue;
@property(nonatomic) float value;
@property(nonatomic) BOOL trackTouchOutsideContent;
@property(nonatomic) float horizontalPadding;
@property(nonatomic) float height;
@property(nonatomic) BOOL evaluateFirstTouch;
@property(nonatomic,assign) BOOL enabled;
@property (nonatomic, assign) CGPoint thumbPosition;
- (id) initWithTrackImage:(NSString *) track knobImage:(NSString *) knob target:(id) target selector:(SEL) selector;
+ (id) sliderWithTrackImage:(NSString *) track knobImage:(NSString *) knob target:(id) target selector:(SEL) selector;
- (void) resetMinValue:(float)min maxValue:(float)max;
@end
