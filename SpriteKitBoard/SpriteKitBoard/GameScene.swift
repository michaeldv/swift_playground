//
//  GameScene.swift
//  SpriteKitBoard
//
//  Created by Michael Dvorkin on 1/23/15.
//  Copyright (c) 2015 Michael Dvorkin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let bestScore = SKLabelNode(fontNamed: "Lucida Grande")
    let currentScore = SKLabelNode(fontNamed: "Lucida Grande")
    var headerLeft, headerRight, footer: SKShapeNode?

    let rows = 9
    let columns = 6

    var gap: CGFloat = 0.0
    var cell: CGFloat = 0.0
    var edge: CGFloat = 0.0

    override func didMoveToView(view: SKView) {
        println("Game scene... width \(size.width) height \(size.height)") // 320 x 568

        computeSizes()
        setupHeader()
        setupBoard()
        setupFooter()
//        var box = SKShapeNode(rectOfSize: CGSize(width: 200.0, height: 200.0))
//        box.strokeColor = SKColor.grayColor()
//        box.fillColor = SKColor.grayColor()
//        box.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
//        addChild(box)
    }

    func computeSizes() {
        self.gap = size.width * 5.0 / 100.0 // 5%
        self.cell = (size.width - gap * CGFloat(columns + 1)) / CGFloat(columns)
        self.edge = (size.height - (gap * CGFloat(rows + 1) + cell * CGFloat(rows))) / 2.0
        println("total width \(size.width), gap width \(gap), cell width \(cell) header/footer \(edge)")
    }

    // Starts at the lower left corner and goes right and up.
    // [0,0] is A1, [0,1] is B1 etc. on chess board.
    func setupBoard() {
        for row in 0..<rows {
            for col in 0..<columns {
                let r = CGRectMake(gap + CGFloat(col) * (gap + cell), edge + gap + CGFloat(row) * (gap + cell), cell, cell)
                println("[\(row), \(col)] => \(r)")
                let box = SKShapeNode(rect: r)
                box.strokeColor = SKColor.grayColor()
                box.fillColor = SKColor.grayColor()
                addChild(box)
            }
        }
    }

    func setupHeader() {
        headerLeft = SKShapeNode(rect: CGRectMake(0.0, size.height - edge, size.width * 0.5, edge))
        headerLeft!.strokeColor = SKColor.greenColor() // Border
        headerLeft!.fillColor = SKColor.greenColor()

        bestScore.text = "4242"
        bestScore.fontColor = SKColor.redColor()
        bestScore.fontSize = 24
        bestScore.position = CGPoint(x: size.width * 0.25, y: size.height - edge * 0.5)
        bestScore.verticalAlignmentMode = .Center

        headerLeft!.addChild(bestScore)
        addChild(headerLeft!)

        headerRight = SKShapeNode(rect: CGRectMake(size.width * 0.5, size.height - edge, size.width * 0.5, edge))
        headerRight!.strokeColor = SKColor.yellowColor() // Border
        headerRight!.fillColor = SKColor.yellowColor()

        currentScore.text = "0"
        currentScore.fontColor = SKColor.redColor()
        currentScore.fontSize = 24
        currentScore.position = CGPoint(x: size.width * 0.75, y: size.height - edge * 0.5)
        currentScore.verticalAlignmentMode = .Center

        headerRight!.addChild(currentScore)
        addChild(headerRight!)
    }

    func setupFooter() {
        footer = SKShapeNode(rect: CGRectMake(0.0, 0.0, size.width, edge))
        footer!.strokeColor = SKColor.cyanColor() // Border
        footer!.fillColor = SKColor.cyanColor()

        let tbd = SKLabelNode(fontNamed: "Lucida Grande")
        tbd.text = "TBD"
        tbd.fontColor = SKColor.blackColor()
        tbd.fontSize = 24
        tbd.position = CGPoint(x: size.width * 0.5, y: edge * 0.5)
        tbd.verticalAlignmentMode = .Center
        
        footer!.addChild(tbd)
        addChild(footer!)
    }
}
