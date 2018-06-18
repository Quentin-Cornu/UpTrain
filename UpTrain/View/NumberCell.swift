//
//  NumberCell.swift
//  UpTrain
//
//  Created by Quentin Cornu on 13/06/2018.
//  Copyright © 2018 Quentin. All rights reserved.
//

import UIKit

class NumberCell: UICollectionViewCell {
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        addSubview(numberLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: numberLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: numberLabel)
    }
    
    
   
}
