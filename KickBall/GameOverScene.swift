//
//  GameOverScene.swift
//  KickBall
//
//  Created by lsw on 14-12-13.
//  Copyright (c) 2014年 lsw. All rights reserved.
//

import Foundation

import SpriteKit

class GameOverScene: SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.blackColor()
        
        var label = SKLabelNode()
        label.text = "Game Over!"
        label.fontColor = UIColor.greenColor()
        label.fontSize = 40
        label.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}