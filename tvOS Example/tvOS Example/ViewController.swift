//
//  ViewController.swift
//  tvOS Example
//
//  Created by Chris Rittersdorf on 4/4/16.
//  Copyright © 2016 Chris Rittersdorf. All rights reserved.
//

import UIKit
import LiveGraph

class ViewController: UIViewController {
    @IBOutlet weak var lineGraph: LineGraph!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lineGraph.dataWindow = 10
        lineGraph.plotGraph(["one one one", "two two two", "three three three", "four", "five", "six"], yVals: [[1.0, 2.0, 3.0, 2.0, 2.0, 2.0], [3.5, 2.5, 1.5, 1.0, 1.0, 1.0]])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

