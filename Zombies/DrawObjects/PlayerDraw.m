//
//  PlayerDraw.m
//  Zombies
//
//  Created by ctsuser on 2/3/14.
//  Copyright (c) 2014 com.coolygon.zombies. All rights reserved.
//

#import "PlayerDraw.h"

@implementation PlayerDraw

+ (PlayerDraw*) drawWithPlayerClass:(PlayerClass*)player{
    return [[[self alloc]initWithPlayerClass:player]autorelease];
}

- (PlayerDraw*) initWithPlayerClass:(PlayerClass*)player{
    if ( self = [super initWithCharacterClass:player spriteFile:@"human_000.png"] ){
        _player = player;
    }
    return self;
}

@end
