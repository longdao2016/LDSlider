/*
 * cocos2d+ext for iPhone
 */

#import "CCNode+Ext.h"
@implementation CCNode(Ext)
- (BOOL) containsPoint:(CGPoint) loc includeChilds:(BOOL) no{
	CGPoint pos = [self convertToNodeSpace:loc];
	
	CGRect rect = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
	if (CGRectContainsPoint(rect, pos)) {
		return YES;
	}
	if (no) {
		CCNode *node;
		CCARRAY_FOREACH(children_,node){
			if ([node containsPoint:loc]) {
				return YES;
			}
		}
	}
	return FALSE;
}

- (BOOL) containsPoint:(CGPoint) loc{
	return [self containsPoint:loc includeChilds:NO];
}

- (BOOL) containsTouch:(UITouch *) touch{
	return [self containsPoint:
			[[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]]
			];
}
@end