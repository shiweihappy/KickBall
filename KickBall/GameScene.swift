//
//  GameScene.swift
//  KickBall
//
//  Created by lsw on 14-12-11.
//  Copyright (c) 2014年 lsw. All rights reserved.
//

import SpriteKit


let Mask_Edge = 0b1
let Mask_Ball = 0b10
let Mask_Flag = 0b100

class GameScene: SKScene , SKPhysicsContactDelegate{
    
    var gameStart:Bool = false
    var ball:SKSpriteNode!
    var startGameLabel:SKLabelNode!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.contactTestBitMask = UInt32(Mask_Edge)
        
        ball = childNodeWithName("ball") as SKSpriteNode
        ball.xScale = 0.5
        ball.yScale = 0.5
        startGameLabel = childNodeWithName("label_1") as SKLabelNode
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if gameStart {
            var flag = SKSpriteNode(imageNamed: "flag_1")
            
            flag.physicsBody = SKPhysicsBody(rectangleOfSize: flag.frame.size)
            flag.physicsBody?.contactTestBitMask = UInt32(Mask_Flag)
            flag.position = touches.anyObject()!.locationInNode(self)
            flag.physicsBody?.velocity = CGVector(dx: 0, dy: 500)
            flag.xScale = 0.6
            flag.yScale = 0.6
            
            self.addChild(flag)
        } else {
            gameStart = true
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.width/2)
            ball.physicsBody?.contactTestBitMask = UInt32(Mask_Ball)
            startGameLabel.hidden = true
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var maskTestBitmap = contact.bodyA.contactTestBitMask | contact.bodyB.contactTestBitMask
        if maskTestBitmap == UInt32(Mask_Flag | Mask_Edge) {
            if contact.bodyA.contactTestBitMask == UInt32(Mask_Flag) {
                contact.bodyA.node?.removeFromParent()
            }
            
            if contact.bodyB.contactTestBitMask == UInt32(Mask_Flag) {
                contact.bodyB.node?.removeFromParent()
            }
        } else if maskTestBitmap == UInt32(Mask_Ball | Mask_Edge) {
            var transition = SKTransition.doorsOpenHorizontalWithDuration(1.0)
            self.view?.presentScene(GameOverScene(size: self.frame.size), transition: transition)
            
            
//            self.view?.presentScene(GameOverScene(size: self.frame.size))
        }
    }
    func didEndContact(contact: SKPhysicsContact) {
        println(">>>> 2")
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
