//
//  GameViewController.swift
//  SpriteKitShooter
//
//  Created by Michael Dvorkin on 1/8/15.
//  Copyright (c) 2015 Michael Dvorkin. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    // I still get goose bumps every time I override a method. —- Harry Wiguna
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .ResizeFill

        let skView = view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
