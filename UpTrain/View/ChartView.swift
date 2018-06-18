//
//  ChartView.swift
//  UpTrain
//
//  Created by Quentin Cornu on 16/06/2018.
//  Copyright © 2018 Quentin. All rights reserved.
//

import UIKit

class ChartView: UIView {

    var values = [1, 4, 5, 3, 7]
    
    let bars: [UIView] = {
        var bars = [UIView]()
        for _ in 0...4 {
            let bar = UIView()
            bar.backgroundColor = UIColor.orange
            bar.layer.cornerRadius = 10
            bars.append(bar)
        }
        return bars
    }()
    
    init(frame: CGRect, values: [Int]) {
        super.init(frame: frame)
        self.values = values
        setupGraph()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGraph()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    func setupGraph() {
        
        let graph: UIStackView = {
            let stack = UIStackView(arrangedSubviews: bars)
            stack.spacing = 30
            
            var multiplier: Float
            var max = Float(values.max()!)
            
            if max == 0 {
                max = 1
            }
            
            multiplier = Float(values[0])/max
            bars[0].heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: CGFloat(multiplier)).isActive = true
            multiplier = Float(values[1])/max
            bars[1].heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: CGFloat(multiplier)).isActive = true
            multiplier = Float(values[2])/max
            bars[2].heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: CGFloat(multiplier)).isActive = true
            multiplier = Float(values[3])/max
            bars[3].heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: CGFloat(multiplier)).isActive = true
            multiplier = Float(values[4])/max
            bars[4].heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: CGFloat(multiplier)).isActive = true
            
            
            stack.distribution = .fillEqually
            stack.alignment = .bottom
            return stack
        }()
        
        addSubview(graph)
        addConstraintsWithFormat(format: "H:|[v0]|", views: graph)
        addConstraintsWithFormat(format: "V:|[v0]|", views: graph)
    }
    
    

}
