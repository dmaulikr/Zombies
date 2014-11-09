//
//  CharacterDraw.m
//  Zombies
//
//  Created by ctsuser on 2/3/14.
//  Copyright (c) 2014 com.coolygon.zombies. All rights reserved.
//

#import "CharacterDraw.h"

@implementation CharacterDraw{


}

/*
+ (CharacterDraw*) drawWithCharacterClass:(CharacterClass*)character spriteFile:(NSString*)spriteFile{
    return [[[self alloc]initWithPlayerClass:character spriteFile:(NSString*)spriteFile]autorelease];
}*/

- (CharacterDraw*) initWithCharacterClass:(CharacterClass*)character spriteFile:(NSString*)spriteFile{
    if ( self = [super initWithSpriteFile:spriteFile size:CGSizeMake(86, 128)] ){
        _character = character;
         PointFloat loc = _character.location.fineLocation;
        [self setPosition:ccp(loc.x,loc.y)];
    }
    return self;
}

- (void) updatePosition:(ccTime)delta {

    PointFloat currentLoc = _character.location.fineLocation;
    PointFloat destination = _character.destination.fineLocation;
    
    PointFloat diff = PointFloatMake1(destination.x-currentLoc.x, destination.y-currentLoc.y);
    
   float distance =sqrtf(powf(diff.x,2)+powf(diff.y,2));
  
    
    if(distance>2){
        
         
        float deltaXDistance = 150*(diff.x/distance)*delta;
        float deltaYDistance = 150*(diff.y/distance)*delta;
        
        _character.location.fineLocation = PointFloatMake(currentLoc.x+deltaXDistance,currentLoc.y+deltaYDistance);
        
//        [self runAction:[CCSequence actions:[CCMoveTo actionWithDuration:delta position:ccp(currentLoc.x+deltaXDistance,currentLoc.y+deltaYDistance)],[CCCallBlockN actionWithBlock:^(CCNode *node) {
//            //[self stopWalking];
//        }],
//                         nil]];
        
        [self setPosition:ccp(currentLoc.x+deltaXDistance,currentLoc.y+deltaYDistance)];
        
       //Determine the walking direction:
        
        if ( abs(diff.x) > abs(diff.y) ) {
            if (diff.x>0) {
                //positve x direction
                [self walking:2];
            }else{
                
                //Negative x direction
                [self walking:1];
                
            }
        }else{
            
            if (diff.y>0) {
                //positve y direction
                [self walking:3];
            }else{
                
                //Negative y direction
                [self walking:0];
            }
        }
        
//        CCLOG(@"deltaXDistance:%f",deltaXDistance);
//        CCLOG(@"deltaYDistance:%f",deltaYDistance);
//        CCLOG(@"distancedifference:%f",sqrtf(powf(diff.x,2)+powf(diff.y,2)));
//        CCLOG(@"delta: %f",delta);
//    //    CCLOG(@"difff: %@",CGPointCreateDictionaryRepresentation(diff));
//        CCLOG(@"newpoint: %@",CGPointCreateDictionaryRepresentation(self.position));
        
    }else{
    
    [self stopWalking];
    
    }
}

- (void) draw {
    
    //[self updatePosition];
    
    [super draw];
}
@end
