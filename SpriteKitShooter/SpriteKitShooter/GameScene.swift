//
//  GameScene.swift
//  SpriteKitShooter
//
//  Created by Michael Dvorkin on 1/8/15.
//  Copyright (c) 2015 Michael Dvorkin. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let None:    UInt32 = 0
    static let Monster: UInt32 = 1
    static let Bullet:  UInt32 = 2
}

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func / (point: CGPoint, divisor: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / divisor, y: point.y / divisor)
}

func * (point: CGPoint, multiplier: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * multiplier, y: point.y * multiplier)
}

func random(#min: CGFloat, #max: CGFloat) -> CGFloat { // <-- Shorthand external parameter names.
    let seed = CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    return seed * (max - min) + min
}

extension CGPoint {
    func normalize() -> CGPoint {
        let length = CGFloat(sqrtf(Float(self.x * self.x + self.y * self.y)))
        return self / length
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    let player = SKSpriteNode(imageNamed: "player")
    let score = SKLabelNode(fontNamed: "Chalkduster")
    
    override func didMoveToView(view: SKView) {
        playMusic("bensonhurst.mp3")
        backgroundColor = SKColor.whiteColor()
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        addChild(player)

        score.text = "Kills: 0";
        score.fontColor = SKColor.grayColor()
        score.fontSize = 14;
        score.position = CGPoint(x: size.width * 0.5, y: size.height - 22.0)
        addChild(score)

        // Set up the physics world to have no gravity.
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self

        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addMonster),
                SKAction.waitForDuration(1.0)
            ])
        ))
    }


    func addMonster() {
        // Create moster sprite.
        let monster = SKSpriteNode(imageNamed: "monster")
        
        // Create physics body for the monster sprite.
        monster.physicsBody = SKPhysicsBody(rectangleOfSize: monster.size)

        // Control monter movement in the code.
        monster.physicsBody?.dynamic = true

        // Set up monster's contact and collision masks.
        monster.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.Bullet
        monster.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        // Determine where to spawn the monster along Y axis.
        let y = random(min: monster.size.height /  2, max: size.height - monster.size.height / 2)

        // Position the monster slightly off screen along the right edge, and randomly
        // along the Y axis calculated above.
        monster.position = CGPoint(x: size.width + monster.size.width /  2, y: y)
        
        // Add the monster to the scene.
        addChild(monster)

        // Determine monster's speed.
        let duration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        // Create the actions.
        let move = SKAction.moveTo(CGPoint(x: -monster.size.width / 2, y: y), duration: NSTimeInterval(duration))
        let done = SKAction.removeFromParent()
        monster.runAction(SKAction.sequence([move, done]))
    }

    func hitMonster(monster: SKSpriteNode, bullet: SKSpriteNode) {
        println("Hit \(monster.texture!) with \(bullet.texture!)")
        bullet.removeFromParent()
        monster.removeFromParent()
    }

    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        // Indentify the touch.
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInNode(self)

        // Set up initial bullet location.
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.position = player.position

        // Create physics body for the bullet sprite.
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width / 2)
        
        // Control bullet movement in the code.
        bullet.physicsBody?.dynamic = true
        
        // Set up bullet's contact and collision masks.
        bullet.physicsBody?.categoryBitMask = PhysicsCategory.Bullet
        bullet.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        bullet.physicsBody?.collisionBitMask = PhysicsCategory.None
        bullet.physicsBody?.usesPreciseCollisionDetection = true // <-- Detect each bullet hit.

        // Calculate touch offset from the bullet position.
        let offset = location - bullet.position
        
        if offset.x > 0 {
            addChild(bullet)
            
            // Get the direction of where to shoot.
            let direction = offset.normalize()
            
            // Shoot far enough to make it off screen
            let target = direction * 1000

            // Find out bullet destination coordinates.
            let destination = bullet.position + target

            // Add sprite actions.
            let move = SKAction.moveTo(destination, duration: 2.0)
            let done = SKAction.removeFromParent()
            bullet.runAction(SKAction.sequence([move, done]))
            runAction(SKAction.playSoundFileNamed("shoot.wav", waitForCompletion: false))
        }
    }

    func didBeginContact(contact: SKPhysicsContact) {
        var monster, bullet: SKPhysicsBody

        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            monster = contact.bodyA
            bullet = contact.bodyB
        } else {
            monster = contact.bodyB
            bullet = contact.bodyA
        }
        
        if (monster.categoryBitMask & PhysicsCategory.Monster != 0) && (bullet.categoryBitMask & PhysicsCategory.Bullet != 0) {
            hitMonster(monster.node as SKSpriteNode, bullet: bullet.node as SKSpriteNode)
        }
    }
}
