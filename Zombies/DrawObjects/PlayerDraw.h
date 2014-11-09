//
//  PlayerDraw.h
//  Zombies
//
//  Created by ctsuser on 2/3/14.
//  Copyright (c) 2014 com.coolygon.zombies. All rights reserved.
//

#import "MovingNode.h"
#import "PlayerClass.h"
#import "CharacterDraw.h"
@interface PlayerDraw : CharacterDraw
{
    PlayerClass* _player;
}

+ (PlayerDraw*) drawWithPlayerClass:(PlayerClass*)player;

@end
