//
//  SessionController.swift
//  UpTrain
//
//  Created by Quentin Cornu on 12/06/2018.
//  Copyright © 2018 Quentin. All rights reserved.
//

import UIKit

class SessionController: UIViewController {

    var exercices = [Exercice]()
    var valueForCountdown = 3
    var timer = Timer()
    var subTimer = Timer()
    let numbers: [Int] = {
        var array = [Int]()
        for i in 0...20 {
            array.append(i)
        }
        return array
    }()
    var selectedNumberOfRep = 8
    var totalTime = 1
    var exerciceTime = 1
    
    var onPause: Bool = false
    var currentExerciceNo = 0
    var listOfResults = [ExerciceSession]()
    var session = Session()
    
    // MARK: - Views
    let quitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "quit"), for: .normal)
        button.addTarget(self, action: #selector(quitSession), for: .touchUpInside)
        return button
    }()
    
    let countdown: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica-Bold", size: 200)
        label.isHidden = true
        return label
    }()
    
    let exerciceName: UILabel = {
        let label = UILabel()
        label.text = "Exercice 1"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25)
        label.isHidden = true
        return label
    }()
    
    let totalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.isHidden = true
        return label
    }()
    
    let numbersOfReps: NumberScroll = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let scroll = NumberScroll(frame: CGRect(x: 0, y: 0, width: 200, height: 100), collectionViewLayout: layout)
        scroll.backgroundColor = UIColor.darkGray
        scroll.showsHorizontalScrollIndicator = false
        scroll.isHidden = true
        return scroll
    }()
    
    let progressBarBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.isHidden = true
        return view
    }()
    
    let progressBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        
        return view
    }()
    
    let exerciceTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 100)
        label.isHidden = true
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.orange
        button.setTitle("Pause", for: .normal)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(presentNextView), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
        session.id = Session.IncrementaID()
        session.date = Date()
        
        setupCollectionVIew(numbersOfReps)
        setupView()
        startCountdown()
        
    }
    
    // MARK: - Private Functions
    fileprivate func setupView() {
        view.addSubview(quitButton)
        view.addConstraintsWithFormat(format: "H:[v0(20)]-20-|", views: quitButton)
        view.addConstraintsWithFormat(format: "V:|-50-[v0(20)]", views: quitButton)

        view.addSubview(countdown)
        view.addConstraintsWithFormat(format: "H:|-80-[v0]-80-|", views: countdown)
        view.addConstraintsWithFormat(format: "V:|-160-[v0]-160-|", views: countdown)
        
        view.addSubview(exerciceName)
        view.addConstraintsWithFormat(format: "H:|-80-[v0]-80-|", views: exerciceName)
        
        view.addSubview(totalTimeLabel)
        view.addConstraintsWithFormat(format: "H:|-80-[v0]-80-|", views: totalTimeLabel)
        
        view.addSubview(numbersOfReps)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: numbersOfReps)
        
        view.addSubview(progressBarBackground)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: progressBarBackground)
        
        view.addSubview(exerciceTimeLabel)
        view.addConstraintsWithFormat(format: "H:|-80-[v0]-80-|", views: exerciceTimeLabel)
        
        view.addSubview(nextButton)
        view.addConstraintsWithFormat(format: "H:|-80-[v0]-80-|", views: nextButton)
        
        view.addConstraintsWithFormat(format: "V:|-30-[v0(60)]-16-[v1(50)]-32-[v2(80)]-0-[v3(5)]-32-[v4]-32-[v5(60)]-80-|", views: exerciceName, totalTimeLabel, numbersOfReps, progressBarBackground, exerciceTimeLabel, nextButton)
        
        progressBarBackground.addSubview(progressBar)
        let width = Float(currentExerciceNo)*Float(view.frame.width)/Float(exercices.count)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: progressBar)
        progressBar.leftAnchor.constraint(equalTo: progressBarBackground.leftAnchor).isActive = true
        progressBar.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
    }
    
    fileprivate func startCountdown() {
        countdown.isHidden = false
        
        countdown.text = String(valueForCountdown)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseCountdown), userInfo: nil, repeats: true)
        
        
        
    }

    @objc fileprivate func decreaseCountdown() {
        if valueForCountdown == 0 {
            timer.invalidate()
            countdown.isHidden = true
            
            startTotalTime()
            startExercice(for: exercices[currentExerciceNo])
            
        } else {
            valueForCountdown -= 1
            countdown.text = String(valueForCountdown)
        }
    }
    
    fileprivate func startTotalTime() {
        totalTimeLabel.isHidden = false
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(incrementeTotalTime), userInfo: nil, repeats: true)
        
        
    }
    
    @objc fileprivate func incrementeTotalTime() {
        let min = totalTime/60
        let sec = totalTime%60
        var minStr: String
        var secStr: String
        
        if min < 10 {
            minStr = "0\(min)"
        } else {
            minStr = "\(min)"
        }
        
        if sec < 10 {
            secStr = "0\(sec)"
        } else {
            secStr = "\(sec)"
        }
        totalTimeLabel.text = minStr + ":" + secStr
        
        totalTime += 1
    }
    
    fileprivate func startExercice(for exercice: Exercice) {
        exerciceName.isHidden = false
        exerciceName.text = exercice.name
        
        numbersOfReps.isHidden = false
        exerciceTimeLabel.isHidden = false
        nextButton.isHidden = false
        progressBarBackground.isHidden = false
        
        subTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(incrementeExerciceTime), userInfo: nil, repeats: true)
        
        
        
    }
    
    @objc fileprivate func incrementeExerciceTime() {
        exerciceTimeLabel.text = String(exerciceTime)
        exerciceTime += 1
    }

    // MARK: - Actions
    @objc fileprivate func quitSession() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func presentNextView() {
        if !onPause {
            
            let result = ExerciceSession()
            result.idExercice = exercices[currentExerciceNo].id
            result.reps = selectedNumberOfRep
            result.idSession = session.id
            listOfResults.append(result)
            
            nextButton.setTitle("Go !", for: .normal)
            onPause = true
            exerciceTime = 0
            exerciceName.text = "Pause"
            currentExerciceNo += 1
        } else {
            nextButton.setTitle("Pause", for: .normal)
            onPause = false
            exerciceTime = 0
            
            if currentExerciceNo >= exercices.count {
                let VC = WellDoneController()
                VC.session = self.session
                VC.listOfResults = self.listOfResults
                present(VC, animated: true, completion: nil)
            } else {
                subTimer.invalidate()
                startExercice(for: exercices[currentExerciceNo])
            }
        }
        
    }
}

extension SessionController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "numberCell", for: indexPath) as! NumberCell
        cell.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        
        cell.numberLabel.text = String(numbers[indexPath.row])
        
        return cell
    }

    fileprivate func setupCollectionVIew(_ collection: NumberScroll) {
        collection.register(NumberCell.self, forCellWithReuseIdentifier: "numberCell")
        
        collection.delegate = self
        collection.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! NumberCell
        selectedCell.numberLabel.textColor = UIColor.orange
        selectedCell.numberLabel.font = UIFont.boldSystemFont(ofSize: 40)
        selectedNumberOfRep = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! NumberCell
        selectedCell.numberLabel.textColor = UIColor.white
        selectedCell.numberLabel.font = UIFont.boldSystemFont(ofSize: 25)
    }
    

    
    
}
