//
//  GameScene.h
//  Flappy Bird
//

//  Copyright (c) 2014 Aditya Talpade. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene {
    
    SKSpriteNode *bird;
    
    SKSpriteNode *background;
    
    NSMutableArray *pipes;
    
    BOOL firstTouch;
    
    NSTimer *timer;
}

- (void)spawnPipes;

@end
