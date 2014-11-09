//
//  GameScene.m
//  Zombies
//
//  Created by ctsuser2 on 1/30/14.
//  Copyright (c) 2014 com.coolygon.zombies. All rights reserved.
//

#import "GameScene.h"
#import "WorldLayer.h"
#import "MainMenuLayer.h"

@interface GameScene(){
    WorldLayer *worldLayer;
    MainMenuLayer *mainMenuLayer;
}

@property(strong)CCSprite *player;

@end

@implementation GameScene{


}


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)init{
    
    if(self=[super init]){
    
         worldLayer = [WorldLayer node];
        [self addChild:worldLayer z:0];
        
         mainMenuLayer = [MainMenuLayer node];
        [self addChild:mainMenuLayer z:1];
        
        [worldLayer setMenuLayerRef:mainMenuLayer];
        [mainMenuLayer setWorldLayerRef:worldLayer];
    }


    return self;
}
@end
