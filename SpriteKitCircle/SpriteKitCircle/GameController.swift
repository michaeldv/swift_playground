//
//  GameController.swift
//  SpriteKitCircle
//
//  Created by Michael Dvorkin on 1/25/15.
//  Copyright (c) 2015 Michael Dvorkin. All rights reserved.
//

import UIKit
import SpriteKit

class GameController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let menuScene = MenuScene(size: view.bounds.size)

        let menuView = view as SKView
        menuView.showsFPS = false
        menuView.showsNodeCount = true//false

        // Sprite Kit applies additional optimizations to improve rendering performance.
        menuView.ignoresSiblingOrder = true

        println("Presenting menu scene...")
        menuView.presentScene(menuScene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func shouldAutorotate() -> Bool {
        return false
    }
}
