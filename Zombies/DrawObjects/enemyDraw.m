//
//  enemyDraw.m
//  Zombies
//
//  Created by ctsuser2 on 2/20/14.
//  Copyright (c) 2014 com.coolygon.zombies. All rights reserved.
//

#import "enemyDraw.h"

@implementation enemyDraw


+(enemyDraw *) drawWithEnemyClass:(enemyClass *)enemyClass{

    return [[[self alloc]initWithEnemyClass:enemyClass] autorelease];

}

-(enemyDraw *)initWithEnemyClass:(enemyClass *)enemyClass{

    if(self = [super initWithCharacterClass:enemyClass spriteFile:@"human_000.png"]){
    
        _enemyClass = enemyClass;
    }
    
    return self;
}
@end
