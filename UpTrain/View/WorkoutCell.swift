//
//  WorkoutCell.swift
//  UpTrain
//
//  Created by Quentin Cornu on 02/06/2018.
//  Copyright © 2018 Quentin. All rights reserved.
//

import UIKit

class WorkoutCell: UICollectionViewCell {
    
    var workout = Workout() {
        didSet {
            nameLabel.text = workout.name
            imageWorkoutView.image = UIImage(named: (workout.imageName))
        }
    }
    
    
    //MARK: - Subviews
    
    let imageWorkoutView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.darkGray
        imageView.image = UIImage()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    let backLabelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.alpha = 0.5
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Name"
        return label
    }()
    
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Private functions
    
    private func setupViews() {
        
        addSubview(imageWorkoutView)
        imageWorkoutView.addSubview(backLabelView)
        imageWorkoutView.addSubview(nameLabel)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: imageWorkoutView)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: imageWorkoutView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: backLabelView)
        addConstraintsWithFormat(format: "V:[v0(50)]|", views: backLabelView)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(50)]|", views: nameLabel)
    }
    
}
