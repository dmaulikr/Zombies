//
//  GameMechanics.m
//  Zombies
//
//  Created by ctsuser on 2/3/14.
//  Copyright (c) 2014 com.coolygon.zombies. All rights reserved.
//

#import "GameMechanics.h"


@implementation CharacterLocation

- (PointFloat) getLocation {
    return PointFloatMake(self.fineLocation.x,self.fineLocation.y);
}

- (void) setLocation:(PointFloat) point {

    self.fineLocation = PointFloatMake(point.x, point.y);

}
@end
