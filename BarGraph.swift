//
//  BarGraph.swift
//  [i]Kegerator
//
//  Created by Ben Lambert on 9/11/15.
//  Copyright © 2015 Collective Idea. All rights reserved.
//

import UIKit

class BarGraph: GraphView {
    
    override func createGraphSection() {
        drawGraph()
    }
    
     func drawGraph() {
        for number in 0..<points[0].count{
            let bar = CAGradientLayer()
            bar.colors = [colors[1].CGColor, colors[0].CGColor]
            bar.frame = CGRect(x: points[0][number].x - 1, y: points[0][number].y, width: 2.0, height: scrollView.frame.origin.y + CGRectGetHeight(scrollView.frame) - bottomGutterSize - points[0][number].y)
            scrollView.layer.addSublayer(bar)
        }
    }
    
    func addImages(images:[UIImageView]) {
        for number in 0..<points[0].count {
            let image = images[number]
            adjustImageView(image)
            let point = points[0][number]
            image.center = CGPoint(x: point.x, y: point.y)
            
            scrollView.addSubview(image)
        }
    }
    
    func adjustImageView(image:UIImageView) {
        image.clipsToBounds = true
        
        image.layer.cornerRadius = 4
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor(red: 139.0/255.0, green: 139.0/255.0, blue: 139.0/255.0, alpha: 1.0).CGColor
    }
}
