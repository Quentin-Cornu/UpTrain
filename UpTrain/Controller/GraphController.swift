//
//  GraphController.swift
//  UpTrain
//
//  Created by Quentin Cornu on 16/06/2018.
//  Copyright © 2018 Quentin. All rights reserved.
//

import UIKit

class GraphController: UIViewController {

    // MARK: - Views
    var values = [Int]()
    var chartView = ChartView()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Your Pogress"
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 2
        button.layer.borderColor?.copy(alpha: 0.5)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        return button
    }()
    
    let placeholderView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "no_session")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        chartView = ChartView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), values: values)
        
        if values.max() == 0 {
            view.addSubview(placeholderView)
            view.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: placeholderView)
            view.addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: placeholderView)
            placeholderView.isHidden = false
        }
        setupView()
    }

    // MARK: - Private methods
    
    fileprivate func setupView() {
        view.addSubview(chartView)
        view.addConstraintsWithFormat(format: "H:|-32-[v0]-32-|", views: chartView)
        
        view.addSubview(titleLabel)
        view.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: titleLabel)
        
        view.addSubview(cancelButton)
        view.addConstraintsWithFormat(format: "H:|-60-[v0]-60-|", views: cancelButton)
        
        view.addConstraintsWithFormat(format: "V:|-32-[v0]-80-[v1]-80-[v2(60)]-80-|", views: titleLabel, chartView, cancelButton)
    }
    
    // MARK: - Actions
    
    @objc func dismissController() {
        dismiss(animated: true, completion: nil)
    }

}
