/*
 * cocos2d+ext for iPhone
 * Daorong Hu
  */

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface CCNode(Ext) 
- (BOOL) containsPoint:(CGPoint) loc includeChilds:(BOOL) no;
- (BOOL) containsPoint:(CGPoint) loc;
- (BOOL) containsTouch:(UITouch *) touch;
@end