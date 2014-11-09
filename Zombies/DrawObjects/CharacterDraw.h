//
//  CharacterDraw.h
//  Zombies
//
//  Created by ctsuser on 2/3/14.
//  Copyright (c) 2014 com.coolygon.zombies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharacterClass.h"
#import "MovingNode.h"
@interface CharacterDraw : MovingNode
{
    CharacterClass* _character;
}

- (CharacterDraw*) initWithCharacterClass:(CharacterClass*)character spriteFile:(NSString*)spriteFile;
- (void) updatePosition:(ccTime)delta;

@end
