-(id) init
{
    if( (self = [super init]) ) {

NSDictionary *sliderMenuDic = [MenuDic objectForKey:@"SLIDER"];
NSArray *sliderMenuPos = [sliderMenuDic objectForKey:@"position"];

for (int i = 0; i < [sliderMenuPos count]; ++i) {
    LDSlider *_slider = [LDSlider sliderWithTrackImage:@"TZ.png" knobImage:@"TZ1.png" target:self selector:@selector(scaleChanged:)];
    
    CGPoint st = CGPointFromString([[sliderMenuPos objectAtIndex:i] objectAtIndex:0]);
    CGPoint en = CGPointFromString([[sliderMenuPos objectAtIndex:i] objectAtIndex:1]);
    float x =(st.x+en.x)/2;
    float y =(st.y+en.y)/2;
    
    _slider.position=ccp(x,y);
    _slider.rotation = 0;
    _slider.width = 50;
    _slider.horizontalPadding = 50;
    _slider.trackTouchOutsideContent = YES;
    _slider.evaluateFirstTouch = NO;
    _slider.minValue = -40;
    _slider.maxValue = 12;
    
    [self addChild:_slider z:1 tag:K_Slider_Menu +i];
    }
   }
    return self;
}
- (void) scaleChanged:(LDSlider *) slider
{
    
}