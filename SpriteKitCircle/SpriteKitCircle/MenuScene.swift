//
//  MenuScene.swift
//  SpriteKitCircle
//
//  Created by Michael Dvorkin on 1/25/15.
//  Copyright (c) 2015 Michael Dvorkin. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    var start: SKShapeNode!
    var label: SKLabelNode!

    override func didMoveToView(view: SKView) {
        println("menu scene didMoveToView()...")
        super.didMoveToView(view)
    }

    // Setup your scene here.
    override init(size: CGSize) {
        println("menu scene init()...")
        super.init(size: size)

        // Set the scale mode to scale to fit the window.
        self.scaleMode = .AspectFill // .ResizeFill
        self.backgroundColor = SKColor.whiteColor()
        
        start = SKShapeNode(circleOfRadius: 40.0)
        start.antialiased = true
        start.lineWidth = 2
        start.strokeColor = SKColor.blueColor()
        start.fillColor = SKColor.whiteColor()
        start.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame));
        println("menu scene frame: \(self.frame)")

        label = SKLabelNode(fontNamed:"Lucida Grande")
        label.text = "Start";
        label.fontSize = 18;
        label.fontColor = SKColor.blueColor()
        label.verticalAlignmentMode = .Center
        label.horizontalAlignmentMode = .Center
        
        start.addChild(label)
        self.addChild(start)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Called when a touch ends.
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let node = nodeAtPoint(touch.locationInNode(self))
            if node == start || node == label {
                println("Touched start")
                let transition = SKTransition.flipVerticalWithDuration(0.75)
                let scene = GameScene(size: self.size)
                self.view!.presentScene(scene, transition: transition)
                break
            }
        }
    }

    // Called before each frame is rendered.
    override func update(currentTime: CFTimeInterval) {
        // TBD.
    }
}
