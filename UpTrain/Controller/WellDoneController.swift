//
//  WellDoneController.swift
//  UpTrain
//
//  Created by Quentin Cornu on 16/06/2018.
//  Copyright © 2018 Quentin. All rights reserved.
//

import UIKit
import RealmSwift

class WellDoneController: UIViewController {

    let manager = DBManager()
    var listOfResults = [ExerciceSession]()
    var session = Session()
    
    let wellDoneView: UILabel = {
        let lbl = UILabel()
        lbl.text = "Well Done !"
        lbl.textAlignment = .center
        lbl.textColor = UIColor.white
        lbl.font = UIFont.boldSystemFont(ofSize: 50)
        return lbl
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.orange
        button.setTitle("Finish", for: .normal)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(terminateSession), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        
        setupView()
        saveSession()
    }

    func setupView() {
        view.addSubview(wellDoneView)
        view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: wellDoneView)
        
        view.addSubview(nextButton)
        view.addConstraintsWithFormat(format: "H:|-80-[v0]-80-|", views: nextButton)
        
        view.addConstraintsWithFormat(format: "V:|-20-[v0]-20-[v1(60)]-80-|", views: wellDoneView, nextButton)
    }
    
    func saveSession() {
        manager.add(session)
        for result in listOfResults {
            manager.add(result)
        }
    }
    
    @objc func terminateSession() {
        dismiss(animated: true, completion: nil)
        presentingViewController?.dismiss(animated: true, completion: nil)
    } 
}
