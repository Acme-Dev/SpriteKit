//
//  MyScene.m
//  Tower Defense
//
//  Created by Jason Chu on 6/23/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "MyScene.h"

@interface MyScene ()

@property Map* map;

@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
		self.anchorPoint = CGPointMake(0.0, 0.7);
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
		Map* map = [[Map alloc] initWithWidth:320.0 height:200.0 map:defaultMap];
		[map drawMap:self];
		self.map = map;
		
		self.enemies = [[NSMutableArray alloc] init];
		
		[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(spawnEnemies) userInfo:NULL repeats:YES];
        //[self addChild:myLabel];
    }
    return self;
}

-(void)spawnMutlistageEnemy:(NSTimer*)timer {
    Enemy* enemy = ((NSArray*)[timer userInfo])[0];
    NSInteger stage = ((NSArray*)[timer userInfo])[1];
    
    if (stage >= 0.4) {
        
    } else {
        
    }
    
	SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(10.0, 10.0)];
    sprite.zPosition = 10;
    enemy.visualEnemy = sprite;
	SKAction *action = [SKAction followPath:[self.map returnVisiblePath] duration:[self.map totalTimeForSpeed:0.5]];
	[sprite runAction:action];
	[self addChild:sprite];
    [self.enemies addObject:enemy];
}


-(void)spawnEnemies {
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(10.0, 10.0)];
    [enemy addTargetEnemy:sprite timeDiff:0.6];
	sprite.enemy = YES;
	SKAction *action = [SKAction followPath:[self.map returnVisiblePath] duration:[self.map totalTimeForSpeed:0.5]];
	[sprite runAction:action];
	[self addChild:sprite];
	[NSTimer scheduledTimerWithTimeInterval:0.4
                                     target:self selector:@selector(spawnVisualEnemy:) userInfo:sprite repeats:FALSE];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint touchPoint = [touch locationInNode:self];
		CGPoint gridPoints = [self.map gridFromTouchPoint:touchPoint];
		if ([self.map retrieveObjectAtX:gridPoints.x y:gridPoints.y].empty) {
			TowerObject* tower = [[TowerObject alloc] initWithName:@"Tower" imageName:NULL color:[UIColor redColor] objectType:Tower spriteObject:NULL scene:self];
			tower.attackSpeed = 1;
			tower.attackDamage = 10;
			[tower startTower];
			[self.map storeObjectAtX:gridPoints.x y:gridPoints.y mapObject:tower];
		} else {
			NSLog(@"Space occupied");
		}
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
