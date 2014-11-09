//
//  CustomBatchNode.h
//  Zombies
//
//  Created by ctsuser on 1/9/14.
//  Copyright (c) 2014 com.coolygon.zombies. All rights reserved.
//

#import "System.h"

@interface CustomBatchNode : CCSpriteBatchNode
{
    int _rows;
    int _columns;
    CGSize _size;
}
// Number of rows in the whole sprite sheet
@property ( nonatomic,readwrite, assign ) int rows;

// Number of columns in the whole sprite sheet
@property ( nonatomic,readwrite, assign ) int columns;

// size of the whole sprite sheet
@property ( nonatomic,readwrite, assign ) CGSize size;

+ (CustomBatchNode*) batchNodeWithFile:(NSString*)fileImage capacity:(NSUInteger)capacity size:(CGSize)size columns:(int)columns rows:(int)rows;

- (CCSpriteFrame*) addSpriteFrameByIndex:(int)index;
- (CCSprite*) addSpriteByIndex:(int)index;
@end
