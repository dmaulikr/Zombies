//
//  CustomBatchNode.m
//  Zombies
//
//  Created by ctsuser on 1/9/14.
//  Copyright (c) 2014 com.coolygon.zombies. All rights reserved.
//

#import "CustomBatchNode.h"

@implementation CustomBatchNode

@synthesize rows = _rows;
@synthesize columns = _columns;
@synthesize size = _size;

+ (CustomBatchNode*) batchNodeWithFile:(NSString*)fileImage capacity:(NSUInteger)capacity size:(CGSize)size columns:(int)columns rows:(int)rows {
    
    return [[[self alloc] initWithFile:fileImage capacity:capacity size:size columns:columns rows:rows] autorelease];
}

- (CustomBatchNode*) initWithFile:(NSString*)fileImage capacity:(NSUInteger)capacity size:(CGSize)size columns:(int)columns rows:(int)rows {
    
    if ( self = [super initWithFile:fileImage capacity:capacity] ){
        _columns = columns;
        _rows = rows;
        _size = size;
        //[self addAllSprites:capacity];
    }
    return self;
}

- (CCSpriteFrame*) addSpriteFrameByIndex:(int)index {

    int x = index % _columns;
    int y = floor( index / _columns );
    
    float width = _size.width / _columns;
    float height = _size.height / _rows;
    
    CCSpriteFrame* spriteframe = [CCSpriteFrame frameWithTexture:self.texture rect:CGRectMake(x * width, y * height, width, height)];
    return spriteframe;
}

- (CCSprite*) addSpriteByIndex:(int)index {
    
    int x = index % _columns;
    int y = floor( index / _columns );
    
    float width = _size.width / _columns;
    float height = _size.height / _rows;
    
    CCSprite* sprite = [CCSprite spriteWithTexture:self.texture rect:CGRectMake(x * width, y * height, width, height)];
    return sprite;
}

/*
- (CCSpriteFrame*) addSpriteFrame:(int) index {
    
    CCSpriteFrame* sprite = [self addSpriteFrameByIndex:index];
    [self addChild:sprite z:0 tag:index];
    return sprite;
}

- (void) addAllSprites:(int) amount {
    for ( int i = 0; i < amount; i ++ ){
        CCSprite* sprite = [self addSprite:i];
        if ( i == 0 ){
            [sprite setVisible:true];
        }
        else {
            [sprite setVisible:false];
        }
    }
}*/

@end
