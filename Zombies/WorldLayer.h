//
//  WorldLayer.h
//  Zombies
//
//  Created by ctsuser2 on 1/30/14.
//  Copyright (c) 2014 com.coolygon.zombies. All rights reserved.
//

#import "System.h"
#import "MovingNode.h"

@interface WorldLayer : CCLayer

@property (assign) int mode;
-(void)setMenuLayerRef:(CCLayer *)menu;
-(void)shoot;

@end
