//
//  GameScene.swift
//  SpriteKitCircle
//
//  Created by Michael Dvorkin on 1/25/15.
//  Copyright (c) 2015 Michael Dvorkin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var ball: SKShapeNode!
    let radius = CGFloat(40.0)

    override func didMoveToView(view: SKView) {
        println("game scene didMoveToView()...")
        super.didMoveToView(view)
    }
    
    // Setup your scene here.
    override init(size: CGSize) {
        println("game scene init()...")
        super.init(size: size)

        // Set the scale mode to scale to fit the window.
        self.scaleMode = .AspectFill // .ResizeFill
        self.backgroundColor = SKColor.whiteColor()
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        ball = SKShapeNode(circleOfRadius: radius)
        ball.antialiased = true
        ball.lineWidth = 2
        ball.strokeColor = SKColor.purpleColor()
        ball.fillColor = SKColor.whiteColor()
        ball.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame));

        self.addChild(ball)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Called when a touch ends.
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let node = nodeAtPoint(touch.locationInNode(self))
            if node == ball {
                println("Touchdown")
                ball.fillColor = SKColor.purpleColor()
            }
        }
    }
}
