//
//  WorkoutController.swift
//  UpTrain
//
//  Created by Quentin Cornu on 12/06/2018.
//  Copyright © 2018 Quentin. All rights reserved.
//

import UIKit

class WorkoutController: UIViewController {
    
    let manager = DBManager()
    var workout: Workout?
    var exercices = [Exercice]()
    let cellID = "exerciceCell"

    // MARK: - Views
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let exercicesTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.allowsSelection = false
        
        return tableView
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(startWorkout), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exercices = manager.fetchExercices(idWorkout: workout!.id)
        
        if workout!.rounds {
            exercices.append(contentsOf: exercices)
            exercices.append(contentsOf: exercices)
        }
                
        view.backgroundColor = UIColor.white
        
        
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(dismissWorkoutController)), animated: true)
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Stats", style: .done, target: self, action: #selector(presentDetailsController)), animated: true)
        navigationController?.navigationBar.isTranslucent = false
        
        setTitle("\(workout!.name)", for: navigationItem)
        
        exercicesTableView.dataSource = self
        exercicesTableView.delegate = self
        exercicesTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        setupViews()
        
    }

    // MARK: - Actions
    
    @objc func dismissWorkoutController() {
        dismiss(animated: true, completion: nil)
    }

    @objc func presentDetailsController() {
        let VC = GraphController()
        VC.values = resizeArray(newSize: 5, manager.fetchResults(for: workout!.id))
        present(VC, animated: true, completion: nil)
    }
    
    @objc func startWorkout() {
        let sessionVC = SessionController()
        sessionVC.exercices = exercices
        sessionVC.session.noWorkout = (workout?.id)!
        present(sessionVC, animated: true, completion: nil)
    }
    
    // MARK: - Private functions
    
    fileprivate func setupViews() {
        view.addSubview(imageView)
        imageView.image = UIImage(named: workout!.imageName)
        view.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: imageView)
        
        view.addSubview(exercicesTableView)
        view.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: exercicesTableView)
        
        view.addSubview(startButton)
        view.addConstraintsWithFormat(format: "H:|-60-[v0]-60-|", views: startButton)
        
        view.addConstraintsWithFormat(format: "V:|-0-[v0(300)]-0-[v1]-16-[v2(60)]-80-|", views: imageView, exercicesTableView, startButton)
        
    }
    
    fileprivate func resizeArray(newSize: Int, _ array: [Int]) -> [Int]{
        var result = [Int]()
        
        if array.count > newSize {
            result.append(contentsOf: array[array.count-newSize...array.count-1])
        } else {
            let toFill = newSize-array.count
            for _ in 0..<toFill {
                result.append(0)
            }
            for element in array {
                result.append(element)
            }
        }
        
        return result
    }

}

extension WorkoutController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = exercices[indexPath.row].name
        
        return cell
    }
    
    
    
}
