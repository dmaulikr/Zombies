//
//  MovingNode.h
//  Zombies
//
//  Created by ctsuser on 1/9/14.
//  Copyright (c) 2014 com.isirigames. All rights reserved.
//

#import "System.h"
#import "CustomBatchNode.h"

@interface MovingNode : CCNode
{
    // The batch node holding the texture and sprites
    CustomBatchNode* _batchnode;
    
    // The animation actions
    NSMutableArray* _walkAnimFrames;
    
    CCSprite* _sprite;
    
    int _direction;
    
}
+ (MovingNode*) nodeWithSpriteFile:(NSString*)string size:(CGSize)size;
- (MovingNode*) initWithSpriteFile:(NSString*)string size:(CGSize)size;
- (void) walkingChangeDirection;
- (void) walking:(int)direction;
-(void)stopWalking;

@end
