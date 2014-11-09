//
//  CharacterClass.m
//  Zombies
//
//  Created by ctsuser on 2/3/14.
//  Copyright (c) 2014 com.coolygon.zombies. All rights reserved.
//

#import "CharacterClass.h"

@implementation CharacterClass

- (CharacterClass*) initWithLocation:(PointFloat)point{
    if ( self = [super init]){
        
        _location = [[CharacterLocation alloc] init];
        _destination = [[CharacterLocation alloc] init];
        [_location setLocation:point];
    }
    return self;
}

//- (void) assignDestination:(PointInt)point{
//    
//}

//- (void) update:(float)dt{
//    float locationX = self.location.fineLocation.x;
//    float locationY = self.location.fineLocation.y;
//    
//    int destinationX = [self.destination getLocation].x;
//    int destinationY = [self.destination getLocation].y;
//
//}

@end
