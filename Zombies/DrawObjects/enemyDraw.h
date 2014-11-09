//
//  enemyDraw.h
//  Zombies
//
//  Created by ctsuser2 on 2/20/14.
//  Copyright (c) 2014 com.coolygon.zombies. All rights reserved.
//

#import "CharacterDraw.h"
#import "enemyClass.h"

@interface enemyDraw : CharacterDraw{

    enemyClass *_enemyClass;

}

+(enemyDraw *) drawWithEnemyClass:(enemyClass *)enemyClass;

@end
