//
//  CharacterClass.h
//  Zombies
//
//  Created by ctsuser on 2/3/14.
//  Copyright (c) 2014 com.coolygon.zombies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameMechanics.h"
@interface CharacterClass : NSObject
{
    CharacterLocation* _location;
    CharacterLocation* _destination;
    
    float _speed;

}
@property (readwrite,nonatomic,retain) CharacterLocation* location;
@property (readwrite,nonatomic,retain) CharacterLocation* destination;

@property (readwrite,nonatomic) float speed;


- (CharacterClass*) initWithLocation:(PointFloat)location;
@end
