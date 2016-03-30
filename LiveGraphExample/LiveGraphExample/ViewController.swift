//
//  ViewController.swift
//  LiveGraphExample
//
//  Created by Chris Rittersdorf on 3/29/16.
//  Copyright © 2016 Collective Idea. All rights reserved.
//

import UIKit
import LiveGraph

class ViewController: UIViewController {
    @IBOutlet weak var lineGraph: LineGraph!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineGraph.plotGraph(
            ["one", "two", "three"],
            yVals: [[1.0, 2.0, 1.0], [3.0, 4.0, 5.0]]
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}