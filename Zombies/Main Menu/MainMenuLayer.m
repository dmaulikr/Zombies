//
//  MainMenuLayer.m
//  Zombies
//
//  Created by ctsuser on 1/9/14.
//  Copyright (c) 2014 com.isirigames.zombies. All rights reserved.
//

#import "MainMenuLayer.h"

@implementation MainMenuLayer
{
    CCLabelTTF *_label;
    CCMenuItem *_navMenuRef;

}

- (id)init
{
    self = [super init];
    if (self) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        _label = [CCLabelTTF labelWithString:@"0" fontName:@"Verdana-Bold" fontSize:18.0];
        _label.color = ccc3(0,0,0);
        int margin = 10;
        _label.position = ccp(winSize.width - (_label.contentSize.width/2) - margin, _label.contentSize.height/2 + margin);
        [self addChild:_label];
        
        // define the button
//        CCMenuItem *on;
//        CCMenuItem *off;
//        
//        on = [CCMenuItemImage itemWithNormalImage:@"projectile-button-on.png"
//                                    selectedImage:@"projectile-button-on.png" target:nil selector:nil];
//        off = [CCMenuItemImage itemWithNormalImage:@"projectile-button-off.png"
//                                     selectedImage:@"projectile-button-off.png" target:nil selector:nil];
//        
//        CCMenuItemToggle *toggleItem = [CCMenuItemToggle itemWithTarget:self
//                                                               selector:@selector(projectileButtonTapped:) items:off, on, nil];
//        CCMenu *toggleMenu = [CCMenu menuWithItems:toggleItem, nil];
//        toggleMenu.position = ccp(100, 32);
//        [self addChild:toggleMenu];
        
        _navMenuRef = [CCMenuItemImage itemWithNormalImage:@"fireGun.png" selectedImage:@"fireGunSel.png" target:self selector:@selector(projectileButtonTapped:)];
        
        CCMenu *navMenu = [CCMenu menuWithItems:_navMenuRef, nil];
        
        navMenu.position = ccp(_navMenuRef.boundingBox.size.width/2,_navMenuRef.boundingBox.size.height/2);
        [self addChild:navMenu];
        
    }
    return self;
}

-(void)numCollectedChanged:(int)numCollected
{
    _label.string = [NSString stringWithFormat:@"%d",numCollected];
}

-(void)setWorldLayerRef:(CCLayer *)world{
    
    _gameLayer=(WorldLayer *)world;
}

// callback for the button
// mode 1 = ninja star throwing mode
- (void)projectileButtonTapped:(id)sender
{

    [_gameLayer shoot];
}


@end

