//
//  GameMechanics.h
//  Zombies
//
//  Created by ctsuser on 2/3/14.
//  Copyright (c) 2014 com.coolygon.zombies. All rights reserved.
//

#import <Foundation/Foundation.h>


struct PointInt{
    int x;
    int y;
};
typedef struct PointInt PointInt;
CG_INLINE PointInt PointIntMake(int x, int y)
{
    PointInt p; p.x = x; p.y = y; return p;
}


struct PointFloat{
    int x;
    int y;
};

typedef struct PointFloat PointFloat;
CG_INLINE PointFloat
PointFloatMake(int x, int y)
{
    PointFloat p; p.x = x; p.y = y; return p;
}

CG_INLINE PointFloat
PointFloatMake1(float x, float y)
{
    PointFloat p; p.x = x; p.y = y; return p;
}

@interface CharacterLocation : NSObject {
    PointFloat _fineLocation;
}
@property (nonatomic,readwrite) PointFloat fineLocation;
- (PointFloat) getLocation;
- (void) setLocation:(PointFloat) point;

@end

@interface GameMechanics : NSObject

@end

