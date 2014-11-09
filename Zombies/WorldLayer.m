//
//  WorldLayer.m
//  Zombies
//
//  Created by ctsuser2 on 1/30/14.
//  Copyright (c) 2014 com.coolygon.zombies. All rights reserved.
//

#import "WorldLayer.h"
#import "PlayerClass.h"
#import "PlayerDraw.h"
#import "MainMenuLayer.h"
#import "enemyClass.h"
#import "enemyDraw.h"


@interface WorldLayer(){

     CGSize winSize;
    CGSize tileSize;
    CGPoint firingDirection;
}

@property (strong) CCTMXTiledMap *tileMap;
@property (strong) CCTMXLayer *background;
@property (strong) PlayerDraw *playerDraw;
@property(strong) PlayerClass *playerClass;
@property (strong) CCTMXLayer *meta;
@property (strong) CCTMXLayer *foreground;
@property (strong) MainMenuLayer *menu;
@property (assign) int numCollected;
@property (strong) NSMutableArray *enemies;
@property (strong) NSMutableArray *projectiles;


@end

@implementation WorldLayer


-(id)init{

    if(self = [super init]){
    
        winSize = [[CCDirector sharedDirector] winSize];
        self.touchEnabled = YES;
        
        _tileMap = [[CCTMXTiledMap alloc] initWithTMXFile:@"TileMap.tmx"];
       // [super setContentSize:[_tileMap contentSize]];
        
        self.background = [_tileMap layerNamed:@"Background"];
        self.foreground = [_tileMap layerNamed:@"Foreground"];
        self.meta = [_tileMap layerNamed:@"Meta"];
       // _meta.visible = NO;
        
        [self addChild:_tileMap z:-1];
        
        CCTMXObjectGroup *objectGroup = [_tileMap objectGroupNamed:@"Objects"];
        NSAssert(objectGroup !=nil, @"Tilemap has no objects");
        
        NSDictionary *spawnPoint = [objectGroup objectNamed:@"SpawnPoint"];
        
        
        int x = [[spawnPoint objectForKey:@"x"] integerValue];
        int y = [[spawnPoint objectForKey:@"y"] integerValue];
        
         tileSize = [self pixelToPointSize:_tileMap.tileSize];
        
       // y = (_tileMap.mapSize.height * _tileMap.tileSize.height) - y;
        
        CGPoint point = [self pixelToPoint:ccp(x, y)];
        firingDirection = point;
        
        _playerClass = [[PlayerClass alloc] initWithLocation:PointFloatMake1(point.x, point.y)];
        
        _playerDraw = [PlayerDraw drawWithPlayerClass:_playerClass];
        
        _playerClass.destination.fineLocation = PointFloatMake1(point.x, point.y);
	
        [self addChild:_playerDraw z:0];
        
        [self setViewPointCenter:[_playerDraw position]];
        
        [self schedule:@selector(update:)];
       // CCLOG(@"layer:%f%f",self.position.x, self.position.y);
        
        self.enemies = [[NSMutableArray alloc] init];
        self.projectiles = [[NSMutableArray alloc] init];
        [self schedule:@selector(testCollisions:)];
        
        //enemies:
        for (spawnPoint in [objectGroup objects]) {
            if ([[spawnPoint valueForKey:@"Enemy"] intValue] == 1){
              //  CCLOG(@"layer:%f%f",self.position.x, self.position.y);
                x = [[spawnPoint valueForKey:@"x"] intValue];
                y = [[spawnPoint valueForKey:@"y"] intValue];
                
              //  y = (_tileMap.mapSize.height * _tileMap.tileSize.height) - y;
                
                CGPoint point = [self pixelToPoint:ccp(x, y)];

                [self addEnemyAtX:point.x y:point.y];
                
            }
        }
        
        //get the menu object fromt he super
        //_menu = [super mainMenuLayer];
    }

    return self;
}

-(void)update:(ccTime)delta{
    

    //calculate the future position and use it for the collision calculation instead of the current position of the character.
    CGPoint position;
    PointFloat currentLoc = _playerClass.location.fineLocation;
    PointFloat destination = _playerClass.destination.fineLocation;
    
    PointFloat diff = PointFloatMake1(destination.x-currentLoc.x, destination.y-currentLoc.y);
    
    float distance =sqrtf(powf(diff.x,2)+powf(diff.y,2));
    
    if(distance>2){
    
    float deltaXDistance = 150*(diff.x/distance)*delta;
    float deltaYDistance = 150*(diff.y/distance)*delta;
    
    position = ccp(currentLoc.x+deltaXDistance,currentLoc.y+deltaYDistance);
    }else{
        position = _playerDraw.position;
    
    }
    

//update the location of the character
    CGPoint tileCoord = [self tileCoordForPosition:position];
    //CGPoint tileCoord = ccp(5, 5);
    // CCLOG(@"Tile Coordinates:%@",CGPointCreateDictionaryRepresentation(tileCoord));
    int tileGid = [_meta tileGIDAt:tileCoord];
    if (tileGid) {
        NSDictionary *properties = [_tileMap propertiesForGID:tileGid];
        if (properties) {
            NSString *collision = properties[@"Collidable"];
            if (collision && [collision isEqualToString:@"True"]) {
                return;
            }
            
            NSString *collectible = properties[@"Collectable"];
            if (collectible && [collectible isEqualToString:@"True"]) {
                [_meta removeTileAt:tileCoord];
                [_foreground removeTileAt:tileCoord];
                
                self.numCollected++;
                [_menu numCollectedChanged:_numCollected];
            }
        }
    }
    
    
 //   [_playerClass.destination setLocation:PointFloatMake(position.x, position.y)];
    [_playerDraw updatePosition:delta];
    [self setViewPointCenter:_playerDraw.position];

}

- (void)setViewPointCenter:(CGPoint) position {
    
    
    int x = MAX(position.x, winSize.width/2);
    int y = MAX(position.y, winSize.height/2);
    x = MIN(x, ((_tileMap.mapSize.width * tileSize.width)) - winSize.width/2);
    y = MIN(y, ((_tileMap.mapSize.height * tileSize.height)) - winSize.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
  //  self.position = viewPoint;
    
    float dutration = sqrtf(powf(viewPoint.x,2)+powf(viewPoint.y,2))/100;
    
    //x limit : - 1120
    //y limit : - 1280
    
    // CCLOG(@"viewPoint:%@",CGPointCreateDictionaryRepresentation(viewPoint));
    if (abs(viewPoint.x) <= ((_tileMap.mapSize.width * tileSize.width)-winSize.width) &&
        abs(viewPoint.y) <= ((_tileMap.mapSize.height * tileSize.height)-winSize.height))
    {
        
   // [self runAction:[CCMoveTo actionWithDuration:dutration position:viewPoint]];
        [self setPosition:viewPoint];
        
   }
}

-(void)setPlayerPosition:(CGPoint)position                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        {
    
    firingDirection =position;
    CGPoint tileCoord = [self tileCoordForPosition:position];
    
    //CGPoint tileCoord = ccp(5, 5);
   // CCLOG(@"Tile Coordinates:%@",CGPointCreateDictionaryRepresentation(tileCoord));
    int tileGid = [_meta tileGIDAt:tileCoord];
    if (tileGid) {
        NSDictionary *properties = [_tileMap propertiesForGID:tileGid];
        if (properties) {
            NSString *collision = properties[@"Collidable"];
            if (collision && [collision isEqualToString:@"True"]) {
                return;
            }
        }
    }
    [_playerClass.destination setLocation:PointFloatMake(position.x, position.y)];
   // [_playerDraw updatePosition];
}


// To convert the position coordinates to tilecoordinates
-(CGPoint)tileCoordForPosition:(CGPoint)position{
    
    int x = position.x/tileSize.width;
    //int y = (_tileMap.mapSize.height/2 - position.y)/_tileMap.tileSize.height/2;
    
    int y = ((_tileMap.mapSize.height * tileSize.height) - position.y)/tileSize.height;
    
   // CCLOG(@"tileCoods:%@",CGPointCreateDictionaryRepresentation(CGPointMake(x, y)));
    return ccp(x, y);
}


#pragma mark - handle touches
-(void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:0
                                                       swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	return YES;
}


-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    

        CGPoint touchLocation = [touch locationInView:touch.view];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
        touchLocation = [self convertToNodeSpace:touchLocation];
        
        CGPoint playerPos = touchLocation;
        
        // safety check on the bounds of the map
        if (playerPos.x <= ((_tileMap.mapSize.width * _tileMap.tileSize.width)) &&
            playerPos.y <= ((_tileMap.mapSize.height * _tileMap.tileSize.height)) &&
            playerPos.y >= 0 &&
            playerPos.x >= 0)
        {
            
            [self setPlayerPosition:playerPos];
        }
    
}



-(CGPoint) pixelToPoint:(CGPoint) pixelPoint{
    return ccpMult(pixelPoint, 1/CC_CONTENT_SCALE_FACTOR());
}
-(CGSize) pixelToPointSize:(CGSize) pixelSize{
    return CGSizeMake((pixelSize.width / CC_CONTENT_SCALE_FACTOR()), (pixelSize.height / CC_CONTENT_SCALE_FACTOR()));
}

-(void)setMenuLayerRef:(CCLayer *)menu{

    _menu=(MainMenuLayer *)menu;
}

-(void)shoot{

    // Create a projectile and put it at the player's location
    CCSprite *projectile = [CCSprite spriteWithFile:@"Projectile.png"];
    projectile.position = _playerDraw.position;
    [self addChild:projectile];
    
    // Determine where we wish to shoot the projectile to
    int realX;
    
    // Are we shooting to the left or right?
    CGPoint diff = ccpSub(firingDirection, _playerDraw.position);
    if (diff.x > 0)
    {
        realX = (_tileMap.mapSize.width * _tileMap.tileSize.width) +
        (projectile.contentSize.width/2);
    } else {
        realX = -(_tileMap.mapSize.width * _tileMap.tileSize.width) -
        (projectile.contentSize.width/2);
    }
    float ratio = (float) diff.y / (float) diff.x;
    int realY = ((realX - projectile.position.x) * ratio) + projectile.position.y;
    CGPoint realDest = ccp(realX, realY);
    
    // Determine the length of how far we're shooting
    int offRealX = realX - projectile.position.x;
    int offRealY = realY - projectile.position.y;
    float length = sqrtf((offRealX*offRealX) + (offRealY*offRealY));
    float velocity = 480/1; // 480pixels/1sec
    float realMoveDuration = length/velocity;
    
    
    
    // Move projectile to actual endpoint
    id actionMoveDone = [CCCallFuncN actionWithTarget:self
                                             selector:@selector(projectileMoveFinished:)];
    [projectile runAction:
     [CCSequence actionOne:
      [CCMoveTo actionWithDuration: realMoveDuration
                          position: realDest]
                       two: actionMoveDone]];
    
    [self.projectiles addObject:projectile];

}

//adds enemy
-(void)addEnemyAtX:(int)x y:(int)y {
  //  CCSprite *enemy = [CCSprite spriteWithFile:@"enemy1.png"];
    enemyClass *enemyclass = [[enemyClass alloc] initWithLocation:PointFloatMake1(x, y)];
    
    enemyDraw *enemySprite = [enemyDraw drawWithEnemyClass:enemyclass];
    
    //_playerClass.destination.fineLocation = PointFloatMake1(point.x, point.y);
    
    enemySprite.position = ccp(x, y);
    [self addChild:enemySprite];
    [self animateEnemy:enemySprite];
    [self.enemies addObject:enemySprite];
}

// callback. starts another iteration of enemy movement.
- (void) enemyMoveFinished:(id)sender {
    enemyDraw *enemy = (enemyDraw *)sender;
    
    [self animateEnemy: enemy];
}

// a method to move the enemy 10 pixels toward the player
- (void) animateEnemy:(enemyDraw*)enemy
{
    // speed of the enemy
    ccTime actualDuration = 0.3;
    
    // rotate to face the player
    CGPoint diff = ccpSub(_playerDraw.position,enemy.position);
    float angleRadians = atanf((float)diff.y / (float)diff.x);
    float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
    float cocosAngle = -1 * angleDegrees;
    if (diff.x < 0) {
        cocosAngle += 180;
    }
    enemy.rotation = cocosAngle;
    // Create the actions
    id actionMove = [CCMoveBy actionWithDuration:actualDuration
                                        position:ccpMult(ccpNormalize(ccpSub(_playerDraw.position,enemy.position)), 10)];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self
                                             selector:@selector(enemyMoveFinished:)];
    [enemy runAction:
     [CCSequence actions:actionMove, actionMoveDone, nil]];
    
}


- (void) projectileMoveFinished:(id)sender {
    CCSprite *sprite = (CCSprite *)sender;
    [self removeChild:sprite cleanup:YES];
    [self.projectiles removeObject:sprite];
}

- (void)testCollisions:(ccTime)dt {
    
    NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
    
    // iterate through projectiles
    for (CCSprite *projectile in self.projectiles) {
        CGRect projectileRect = CGRectMake(
                                           projectile.position.x - (projectile.contentSize.width/2),
                                           projectile.position.y - (projectile.contentSize.height/2),
                                           projectile.contentSize.width,
                                           projectile.contentSize.height);
        
        NSMutableArray *targetsToDelete = [[NSMutableArray alloc] init];
        
        // iterate through enemies, see if any intersect with current projectile
        for (CCSprite *target in self.enemies) {
            CGRect targetRect = CGRectMake(
                                           target.position.x - (target.contentSize.width/2),
                                           target.position.y - (target.contentSize.height/2),
                                           target.contentSize.width,
                                           target.contentSize.height);
            
            if (CGRectIntersectsRect(projectileRect, targetRect)) {
                [targetsToDelete addObject:target];
            }
        }
        
        // delete all hit enemies
        for (CCSprite *target in targetsToDelete) {
            [self.enemies removeObject:target];
            [self removeChild:target cleanup:YES];
        }
        
        if (targetsToDelete.count > 0) {
            // add the projectile to the list of ones to remove
            [projectilesToDelete addObject:projectile];
        }
    }
    
    // remove all the projectiles that hit.
    for (CCSprite *projectile in projectilesToDelete) {
        [self.projectiles removeObject:projectile];
        [self removeChild:projectile cleanup:YES];
    }
}

@end
