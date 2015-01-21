//
//  GameController.swift
//  UIKitBoard
//
//  Created by Michael Dvorkin on 1/20/15.
//  Copyright (c) 2015 Michael Dvorkin. All rights reserved.
//

import UIKit

class GameController : UIViewController {
    let rows = 9
    let columns = 6
    var gap: CGFloat = 0.0
    var cell: CGFloat = 0.0
    var edge: CGFloat = 0.0
    
    var bestScore: UILabel?
    var currentScore: UILabel?
    var footer: UILabel?

    override init() {
        super.init(nibName: nil, bundle: nil)
        println("GameController#init()")
        self.view.backgroundColor = UIColor.whiteColor()
    }

    // View Controller
    override func viewDidLoad()  {
        super.viewDidLoad()
        println("frame \(view.frame.size) bounds \(view.bounds.size)") // 375.0 x 667.0
        computeSizes()
        setupHeader()
        setupBoard()
        setupFooter()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    func computeSizes() {
        self.gap = view.bounds.size.width * 5.0 / 100.0 // 5%
        self.cell = (view.bounds.size.width - gap * CGFloat(columns + 1)) / CGFloat(columns)
        self.edge = (view.bounds.size.height - (gap * CGFloat(rows + 1) + cell * CGFloat(rows))) / 2.0
        println("total width \(view.bounds.size.width), gap width \(gap), cell width \(cell) header/footer \(edge)")
    }

    // Starts at the upper left corner and goes right and down.
    // [0,0] is A8, [0,1] is B8 etc. on chess board.
    func setupBoard() {
        for row in 0..<rows {
            for col in 0..<columns {
                let r = CGRectMake(gap + CGFloat(col) * (gap + cell), edge + gap + CGFloat(row) * (gap + cell), cell, cell)
                println("[\(row), \(col)] => \(r)")
                let box = UIButton(frame: r)
                box.backgroundColor = UIColor.grayColor()
                self.view.addSubview(box)
            }
        }
    }

    func setupHeader() {
        bestScore = UILabel(frame: CGRectMake(0, 0, view.bounds.size.width / 2, edge))
        bestScore!.text = "4242"
        bestScore!.textColor = UIColor.redColor()
        bestScore!.textAlignment = NSTextAlignment.Center
        bestScore!.backgroundColor = UIColor.greenColor()
        self.view.addSubview(bestScore!)
        
        currentScore = UILabel(frame: CGRectMake(view.bounds.size.width / 2, 0, view.bounds.size.width / 2, edge))
        currentScore!.text = "42"
        currentScore!.textColor = UIColor.redColor()
        currentScore!.textAlignment = NSTextAlignment.Center
        currentScore!.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(currentScore!)
    }

    func setupFooter() {
        footer = UILabel(frame: CGRectMake(0, view.bounds.size.height - edge, view.bounds.size.width, edge))
        footer!.text = "TBD"
        footer!.textColor = UIColor.blackColor()
        footer!.textAlignment = NSTextAlignment.Center
        footer!.backgroundColor = UIColor.cyanColor()
        self.view.addSubview(footer!)
    }
}

