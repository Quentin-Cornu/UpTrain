//
//  DetailsController.swift
//  UpTrain
//
//  Created by Quentin Cornu on 03/06/2018.
//  Copyright © 2018 Quentin. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {

    var workoutName: String?
    var imageName: String?
    
    let cellID = "exerciceCell"
    var exercicesList = [String]()
    
    
    //MARK: - Views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    let lblsView: UIView = {
        let view = UIView()
        return view
    }()
    
    let roundLabel: UILabel = {
        let label = UILabel()
        label.text = "Rounds (x4)"
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Weights"
        return label
    }()
    
    let roundSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        sw.onTintColor = UIColor.orange
        return sw
    }()
    
    let weightSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        sw.onTintColor = UIColor.orange
        return sw
    }()
    
    let buttonsView: UIView = {
        let view = UIView()
        return view
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 2
        button.layer.borderColor?.copy(alpha: 0.5)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    let terminateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.orange
        button.setTitle("Terminate", for: .normal)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(terminateAdding), for: .touchUpInside)
        return button
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter an exercice"
        return tf
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 15
        button.setTitle("+", for: .normal)
        button.addTarget(self, action: #selector(addExercice), for: .touchUpInside)
        return button
    }()
    
    let exerciceTableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    
    //MARK: - View did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        titleLabel.text = workoutName != "" ? workoutName : "Workout"
        setupViews()
        
        textField.delegate = self
 
        exerciceTableView.delegate = self
        exerciceTableView.dataSource = self
        
        exerciceTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }

    
    //MARK: - Private Functions
    func setupViews() {
        view.addSubview(titleLabel)
        
        view.addSubview(lblsView)
        
        view.addSubview(buttonsView)
        
        lblsView.addSubview(roundLabel)
        lblsView.addSubview(weightLabel)
        
        buttonsView.addSubview(terminateButton)
        buttonsView.addSubview(cancelButton)
        
        lblsView.addSubview(roundSwitch)
        lblsView.addSubview(weightSwitch)
        
        view.addSubview(textField)
        view.addSubview(exerciceTableView)
        
        view.addSubview(addButton)
        
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: titleLabel)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: lblsView)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: buttonsView)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-4-[v1]-16-|", views: textField, addButton)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: exerciceTableView)
        
        view.addConstraintsWithFormat(format: "V:|-40-[v0(50)]-8-[v1(100)]-8-[v2(50)]-8-[v3]-8-[v4(80)]-80-|", views: titleLabel, lblsView, textField, exerciceTableView, buttonsView)
        
        view.addConstraintsWithFormat(format: "V:|-208-[v0(30)]", views: addButton)
        
        lblsView.addConstraintsWithFormat(format: "H:[v0]-8-|", views: roundSwitch)
        lblsView.addConstraintsWithFormat(format: "H:[v0]-8-|", views: weightSwitch)
        
        lblsView.addConstraintsWithFormat(format: "H:|-8-[v0]-40-|", views: roundLabel)
        lblsView.addConstraintsWithFormat(format: "H:|-8-[v0]-40-|", views: weightLabel)

        lblsView.addConstraintsWithFormat(format: "V:|-4-[v0]", views: roundSwitch)
        lblsView.addConstraintsWithFormat(format: "V:[v0]-4-|", views: weightSwitch)
        lblsView.addConstraintsWithFormat(format: "V:|-12-[v0(20)]", views: roundLabel)
        lblsView.addConstraintsWithFormat(format: "V:[v0(20)]-12-|", views: weightLabel)
        
        
        terminateButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor, multiplier: 1).isActive = true
        buttonsView.addConstraintsWithFormat(format: "H:|-8-[v0]-16-[v1]-6-|", views: cancelButton, terminateButton)
        buttonsView.addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: terminateButton)
        buttonsView.addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: cancelButton)

    }
    
    //MARK: - Actions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    @objc func dismissView() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func addExercice() {
        print("Add exercice")
        if textField.text != "" {
            exercicesList.append(textField.text!)
            exerciceTableView.reloadData()
            textField.text = ""
        }
    }
    
    @objc func terminateAdding() {
        
        let manager = DBManager()
        
        let newWorkout = Workout()
        newWorkout.id = Workout.IncrementaID()
        newWorkout.name = workoutName!
        newWorkout.imageName = imageName!
        newWorkout.rounds = roundSwitch.isOn
        newWorkout.weight = weightSwitch.isOn
        manager.add(newWorkout)
        
        for exercice in exercicesList {
            let newExercice = Exercice()
            newExercice.id = Exercice.IncrementaID()
            newExercice.name = exercice
            newExercice.noWorkout = newWorkout.id
            
            manager.add(newExercice)
        }
        
        dismiss(animated: true, completion: nil)
        presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
}


extension DetailsController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension DetailsController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercicesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.text = exercicesList[indexPath.row]
        
        return cell
    }
    
}
