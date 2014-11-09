//
//  MainMenuLayer.h
//  Zombies
//
//  Created by ctsuser on 1/9/14.
//  Copyright (c) 2014 com.isirigames.zombies. All rights reserved.
//

#import "System.h"
#import  "WorldLayer.h"
@interface MainMenuLayer : CCLayer{
 
}
//+(CCScene *) scene;

@property (unsafe_unretained) WorldLayer *gameLayer;

 - (void)numCollectedChanged:(int)numCollected;
 -(void)setWorldLayerRef:(CCLayer *)world;

@end
