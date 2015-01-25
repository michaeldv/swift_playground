//
//  GameController.swift
//  SpriteKitBoard
//
//  Created by Michael Dvorkin on 1/23/15.
//  Copyright (c) 2015 Michael Dvorkin. All rights reserved.
//

import UIKit
import SpriteKit

class GameController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("Game controller!")

        let gameScene = GameScene(size: view.bounds.size)
        gameScene.scaleMode = .ResizeFill
        gameScene.backgroundColor = SKColor.whiteColor()
        
        let gameView = view as SKView
        gameView.showsFPS = false//true
        gameView.showsNodeCount = false//true
        gameView.ignoresSiblingOrder = true
        gameView.presentScene(gameScene)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
