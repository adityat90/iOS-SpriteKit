//
//  GameScene.m
//  Flappy Bird
//
//  Created by Sunil N. Talpade on 05/06/14.
//  Copyright (c) 2014 Aditya Talpade. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    pipes = [[NSMutableArray alloc] init];
    
    
    bird = [SKSpriteNode spriteNodeWithImageNamed:@"bird"];
    bird.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    bird.size = CGSizeMake(56, 46);
    bird.zPosition = 3;
    
    bird.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bird.frame.size];
    bird.physicsBody.usesPreciseCollisionDetection = YES;
    bird.physicsBody.mass = 0.2;
    bird.physicsBody.affectedByGravity = NO;
    bird.physicsBody.dynamic = YES;
    bird.physicsBody.allowsRotation = NO;
    
    [self addChild:bird];
    
    [self spawnPipes];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:4.5f target:self selector:@selector(spawnPipes) userInfo:nil repeats:YES];
    
    firstTouch = YES;
}

- (void)spawnPipes {
    int random = arc4random() % ((int)self.frame.size.height-300) + 300;
    //self.frame.size.height;//(arc4random() % (int)self.frame.size.height - 150) + 400;
    
    // Upper pipe
    SKSpriteNode *upperPipe = [SKSpriteNode spriteNodeWithImageNamed:@"pipe-top"];
    upperPipe.size = CGSizeMake(70, 25);
    upperPipe.position = CGPointMake(self.frame.size.width, random);
    
    // Lower pipe
    SKSpriteNode *lowerPipe = [SKSpriteNode spriteNodeWithImageNamed:@"pipe-top"];
    lowerPipe.size = CGSizeMake(70, 25);
    lowerPipe.position = CGPointMake(upperPipe.position.x, upperPipe.position.y - 300);
    
    // rest below
    SKSpriteNode *restBelow = [SKSpriteNode spriteNodeWithImageNamed:@"pipe-bottom"];
    restBelow.size = CGSizeMake(60, lowerPipe.position.y);
    restBelow.position = CGPointMake(lowerPipe.position.x, lowerPipe.position.y -restBelow.size.height/2 - lowerPipe.size.height/2 + 1);

    // rest below
    SKSpriteNode *restAbove = [SKSpriteNode spriteNodeWithImageNamed:@"pipe-bottom"];
    restAbove.size = CGSizeMake(60, self.frame.size.height + upperPipe.position.y);
    restAbove.position = CGPointMake(upperPipe.position.x, upperPipe.position.y + restAbove.size.height/2 + upperPipe.size.height/2 - 2);

    [self addChild:upperPipe];
    [self addChild:lowerPipe];
    [self addChild:restBelow];
    [self addChild:restAbove];
    
    [pipes addObject:upperPipe];
    [pipes addObject:lowerPipe];
    [pipes addObject:restBelow];
    [pipes addObject:restAbove];
    
    for (int i =0; i<[pipes count]; i++) {
        SKSpriteNode *sprite = [pipes objectAtIndex:i];
        sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.frame.size];
        sprite.physicsBody.usesPreciseCollisionDetection = YES;
        sprite.physicsBody.affectedByGravity = NO;
        sprite.physicsBody.mass = 1000.0f;
        sprite.name = @"beforeBird";
        sprite.zPosition = 3;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [bird.physicsBody applyImpulse:CGVectorMake(0.0f, 160.0f)];
    
    if (firstTouch) {
        firstTouch = NO;
        bird.physicsBody.affectedByGravity = YES;
    }
    
}

-(void)update:(CFTimeInterval)currentTime {
    for (int i = 0; i< [pipes count]; i++) {
        SKSpriteNode *pipe = [pipes objectAtIndex:i];
        
        if (pipe.position.x < -50) {
            [pipe removeFromParent];
            [pipes removeObject:pipe];
        }
        
        pipe.position = CGPointMake(pipe.position.x - 2, pipe.position.y);
        bird.position = CGPointMake(self.frame.size.width / 2, bird.position.y);
    }
}

@end
