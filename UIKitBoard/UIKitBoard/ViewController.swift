//
//  ViewController.swift
//  UIKitBoard
//
//  Created by Michael Dvorkin on 1/20/15.
//  Copyright (c) 2015 Michael Dvorkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onStartGameTouchUpInside(sender: UIButton) {
        let game = GameController()
        self.presentViewController(game, animated: true, completion: nil)
    }
}

