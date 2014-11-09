//
//  MovingNode.m
//  Zombies
//
//  Created by ctsuser on 1/9/14.
//  Copyright (c) 2014 com.isirigames. All rights reserved.
//

#import "MovingNode.h"


@implementation MovingNode

+ (MovingNode*) nodeWithSpriteFile:(NSString*)string size:(CGSize)size{
    return [[[self alloc]initWithSpriteFile:string size:size]autorelease];
}

- (MovingNode*) initWithSpriteFile:(NSString*)string size:(CGSize)size{
    if ( self = [super init] ){
        [self setContentSize:size];
        _walkAnimFrames = [[NSMutableArray arrayWithCapacity:4] retain];
        _batchnode = [CustomBatchNode batchNodeWithFile:string capacity:12 size:size columns:3 rows:4];
        [self addChild:_batchnode];
        _sprite = [_batchnode addSpriteByIndex:0];
        _direction = 0;
        [_batchnode addChild:_sprite];
        
        for ( int i = 0; i < 4; i ++ ){
            [_walkAnimFrames addObject:[self animationWithStartFrame:i*3 endFrame:i*3 + 2 delay:0.1]];
        }
    }
    return self;

}

// Get the animation action using frames
- (CCAction*) animationWithStartFrame:(int)startFrame endFrame:(int)endFrame delay:(float)delay{
    
    
    NSMutableArray* animationFrames = [NSMutableArray arrayWithCapacity:endFrame-startFrame+1];
    for (int i = startFrame; i <= endFrame; i++) {
        CCSpriteFrame* spriteframe = [_batchnode addSpriteFrameByIndex:i];
        [animationFrames addObject:spriteframe];
    }
    CCAnimation *walkAnimation = [CCAnimation animationWithSpriteFrames:animationFrames delay:delay];
    
    CCAnimate* walkAnimate = [CCAnimate actionWithAnimation:walkAnimation];
    
    CCRepeatForever* walkDownAction = [CCRepeatForever actionWithAction:walkAnimate];
    return walkDownAction;
}

// Starts the walking action
- (void) walking:(int)direction {
    [_sprite stopAllActions];
    [_sprite runAction:[_walkAnimFrames objectAtIndex:direction]];
}

-(void)stopWalking{
 
    [_sprite stopAllActions];

}

- (void) walkingChangeDirection {
    _direction++;
    if ( _direction == 4 )
        _direction = 0;
    [self walking:_direction];
}

- (void) dealloc{
    [_walkAnimFrames release];
    [super dealloc];
}

@end
