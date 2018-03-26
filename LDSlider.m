/*
 * cocos2d+ext for iPhone
 * vertical slider
 */

#import "LDSlider.h"

@interface LDSlider(Private)
- (BOOL) knobTouched:(CGPoint) loc;
- (void) setValueByY:(float) ypos;
@end

@implementation LDSlider(Private)
- (BOOL) knobTouched:(CGPoint) loc{
    if ([self containsPoint:loc]) {
        loc = [self convertToNodeSpace:loc];
        return  fabs(_knob.position.y - loc.y) < _knob.contentSize.height/2;
    }
    CCLOG(@"knob:%f ,loc:%f,con:%f",_knob.position.y , loc.y,_knob.contentSize.height/2);
    return NO;
}


- (void) setValueByY:(float) ypos{
    ypos = ypos < -_track.contentSize.height/2 ? -_track.contentSize.height/2 : ypos;
    ypos = ypos > _track.contentSize.height/2 ? _track.contentSize.height/2 : ypos;
    _knob.position = ccp(_knob.position.x,ypos);
    _value = (ypos + _track.contentSize.height/2) / _track.contentSize.height * (_maxValue - _minValue) + _minValue;
    if (_target) {
        [_target performSelector:_selector withObject:self];
    }
}
@end


@implementation LDSlider
@synthesize minValue = _minValue;
@synthesize maxValue = _maxValue;
@synthesize trackTouchOutsideContent = _trackTouchOutsideContent;
@synthesize width = _width;
@synthesize evaluateFirstTouch = _evaluateFirstTouch;
@synthesize enabled = _enabled;

+ (id) sliderWithTrackImage:(NSString *) track knobImage:(NSString *) knob target:(id) target selector:(SEL) selector{
    return [[[self alloc] initWithTrackImage:track knobImage:knob target:target selector:selector] autorelease] ;
}

- (id) initWithTrackImage:(NSString *) track knobImage:(NSString *) knob target:(id) target selector:(SEL) selector{
    self = [super init];
    _track = [CCSprite spriteWithFile:track];
    _knob = [CCSprite spriteWithFile:knob];
    
    _target = target;
    _selector = selector;
    _minValue = 0;
    _maxValue = 100;
    
    [self addChild:_track];
    [self addChild:_knob];
    
    _height = _track.contentSize.height;
    _width= 50;
    
    _enabled = YES;
    
    return self;
}

- (float) horizontalPadding{
    return (_height - _track.contentSize.height) / 2;
}

- (void) setHorizontalPadding:(float) p{
    _height = _track.contentSize.height + 2 * p;
}

- (void) onEnter{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super onEnter];
}

- (void) onExit{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}

- (BOOL) containsPoint:(CGPoint)loc {
    loc = [self convertToNodeSpace:loc];
    CGRect rect = CGRectMake(-_width/2, -_height/2, _width, _height);
    return CGRectContainsPoint(rect, loc);
}


- (void) setValue:(float) v{
    if (!_enabled) {
        return;
    }
    v = v < _minValue ? _minValue : v;
    v = v > _maxValue ? _maxValue : v;
    
    _value = v;
    float y= (_value - _minValue) / (_maxValue - _minValue) * _track.contentSize.height;
    _knob.position = ccp(_knob.position.x,y- _track.contentSize.height/2);
    if (_target) {
        [_target performSelector:_selector withObject:self];
    }
}

- (float) value{
    return _value;
}

#pragma mark TOUCH
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    if (!visible_ || !_enabled) {
        return NO;
    }
    CGPoint loc = [touch locationInView:touch.view];
    loc = [[CCDirector sharedDirector] convertToGL:loc];
    
    if ([self containsPoint:loc]) {
        if (_evaluateFirstTouch) {
            [self setValueByY:[self convertToNodeSpace:loc].y];
            _trackingTouch = YES;
            return YES;
        }else {
            _trackingTouch = [self knobTouched:loc];
            return _trackingTouch;
        }
        
    }
    
    return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    if (!visible_ || !_enabled) {
        return;
    }
    
    if (_trackingTouch) {
        CGPoint loc = [touch locationInView:touch.view];
        loc = [[CCDirector sharedDirector] convertToGL:loc];
        
        if (_trackTouchOutsideContent) {
            [self setValueByY:[self convertToNodeSpace:loc].y];
        }else {
            if([self containsPoint:loc]){
                [self setValueByY:[self convertToNodeSpace:loc].y];
            }else {
                _trackingTouch = NO;
            }
        }
    }
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    _trackingTouch = NO;
}
@end
