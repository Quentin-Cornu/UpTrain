//
//  ViewController.swift
//  UpTrain
//
//  Created by Quentin Cornu on 02/06/2018.
//  Copyright © 2018 Quentin. All rights reserved.
//

import UIKit
import RealmSwift

class HomeController: UICollectionViewController {

    let manager = DBManager()
    var workouts = [Workout]()
    
    //    var workouts: [Workout] = {
    //        var firstWorkout = Workout()
    //        firstWorkout.name = "Les bras"
    //        firstWorkout.imageName = "back"
    //
    //        var secondWorkout = Workout()
    //        secondWorkout.name = "Les Jambes"
    //        secondWorkout.imageName = "adult"
    //
    //        var thirdWorkout = Workout()
    //        thirdWorkout.name = "Tractions"
    //        thirdWorkout.imageName = "muscleup"
    //
    //        return [firstWorkout, secondWorkout, thirdWorkout]
    //    }()
    
    let placeholderView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "add_a_workout")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddWorkoutController)), animated: true)
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(WorkoutCell.self, forCellWithReuseIdentifier: "cellId")
        
        navigationController?.navigationBar.isTranslucent = false
        
        if workouts.count == 0 {
            view.addSubview(placeholderView)
            view.addConstraintsWithFormat(format: "H:|[v0]|", views: placeholderView)
            view.addConstraintsWithFormat(format: "V:|-50-[v0(300)]", views: placeholderView)
            placeholderView.isHidden = false
        }
        
        
        setTitle("Workouts", for: navigationItem)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        workouts = manager.fetchWorkouts()
        
        if workouts.count != 0 {
            placeholderView.isHidden = true
        }
        self.collectionView!.reloadData()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workouts.count
    }
    
    
    
    //MARK: Creating Cells
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! WorkoutCell
        cell.workout = workouts[indexPath.item]
        
//        if (indexPath.item < workouts.count) {
//            cell.workout = workouts[indexPath.item]
//        } else {
//            hideCellview(cell)
//            let addView: UIView = {
//                let view = UIView();
//                view.backgroundColor = UIColor.orange
//                return view
//            }()
//            let addImageView: UIImageView = {
//                let imageView = UIImageView()
//                imageView.image = UIImage(named: "add_icon")
//
//                return imageView
//            }()
//            setupAddView(cell, addView)
//            setupAddImageView(addView, addImageView)
//
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentAddWorkoutController))
//            addView.addGestureRecognizer(tapGesture)
//        }

        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = WorkoutController()
        VC.workout = workouts[indexPath.row]
        
        let NVC = UINavigationController(rootViewController: VC)
        present(NVC, animated: true, completion: nil)
    }
    
    @objc func presentAddWorkoutController() {
        present(NewWorkoutController(), animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK: - Private functions
    
    fileprivate func hideCellview(_ cell: WorkoutCell) {
        cell.imageWorkoutView.isHidden = true
        cell.backLabelView.isHidden = true
        cell.nameLabel.isHidden = true
    }
    
    fileprivate func setupAddView(_ cell: WorkoutCell, _ addView: UIView) {
        cell.addSubview(addView)
        cell.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: addView)
        cell.addConstraintsWithFormat(format: "V:|-50-[v0]-50-|", views: addView)
        addView.layer.cornerRadius = cell.frame.width/2 - 50
    }
    
    fileprivate func setupAddImageView(_ addView: UIView, _ addImageView: UIImageView) {
        addView.addSubview(addImageView)
        addView.addConstraintsWithFormat(format: "H:|-25-[v0]-25-|", views: addImageView)
        addView.addConstraintsWithFormat(format: "V:|-25-[v0]-25-|", views: addImageView)
    }
    

}

//MARK: - Collection View Layout
extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2, height: view.frame.width/2)
    }
    
}


