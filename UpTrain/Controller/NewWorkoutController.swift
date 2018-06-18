//
//  NewWorkoutController.swift
//  UpTrain
//
//  Created by Quentin Cornu on 02/06/2018.
//  Copyright © 2018 Quentin. All rights reserved.
//

import UIKit

class NewWorkoutController: UIViewController {
    
    //MARK: - Properties
    let imagesNames = ["abs", "adult", "back", "blur", "box", "crossfit", "muscleup", "people", "pushup", "sports", "street", "yoga"]
    
    var selectedImage: Int = 0 {
        didSet {
            imageView.image = UIImage(named: imagesNames[selectedImage])
        }
    }
    
    //MARK: - Views
    
    let configView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "abs")
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Choose a name"
        textField.textColor = UIColor.black
        textField.backgroundColor = UIColor(white: 1, alpha: 0.5)
        textField.textAlignment = .center
        return textField
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
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.orange
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 30
        button.alpha = 0.5
        button.addTarget(self, action: #selector(presentNextView), for: .touchUpInside)
        return button
    }()
    
    let leftArrow: UIButton = {
        let leftArrow = UIButton()
        leftArrow.alpha = 0.7
        leftArrow.setBackgroundImage(UIImage(named: "left_arrow"), for: .normal)
        leftArrow.addTarget(self, action: #selector(previousImage), for: .touchUpInside)
        return leftArrow
    }()
    
    let rightArrow: UIButton = {
        let rightArrow = UIButton()
        rightArrow.alpha = 0.7
        rightArrow.setBackgroundImage(UIImage(named: "right_arrow"), for: .normal)
        rightArrow.addTarget(self, action: #selector(nextImage), for: .touchUpInside)
        return rightArrow
    }()
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        textField.delegate = self
        
        nextButton.isEnabled = false
        
        setupViews()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    
    //MARK: - Keyboard manager
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    //MARK: - Private Functions
    
    func setupViews() {
        view.backgroundColor = UIColor.white

        view.addSubview(configView)
        view.addSubview(buttonsView)
        
        buttonsView.addSubview(nextButton)
        buttonsView.addSubview(cancelButton)
        
        configView.addSubview(imageView)
        configView.addSubview(textField)
        configView.addSubview(leftArrow)
        configView.addSubview(rightArrow)
        
        
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: configView)
        view.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: buttonsView)
        
        view.addConstraintsWithFormat(format: "V:|-50-[v0]-16-[v1(80)]-80-|", views: configView, buttonsView)
        
        
        nextButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor, multiplier: 1).isActive = true
        buttonsView.addConstraintsWithFormat(format: "H:|-8-[v0]-16-[v1]-6-|", views: cancelButton, nextButton)

        buttonsView.addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: nextButton)
        buttonsView.addConstraintsWithFormat(format: "V:|-10-[v0]-10-|", views: cancelButton)
        
        
        configView.addConstraintsWithFormat(format: "V:|-0-[v0]-0-|", views: imageView)
        configView.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: imageView)
        
        configView.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: textField)
        configView.addConstraintsWithFormat(format: "V:[v0(60)]|", views: textField)

        configView.addConstraintsWithFormat(format: "V:|-200-[v0(50)]", views: leftArrow)
        configView.addConstraintsWithFormat(format: "H:|[v0(50)]", views: leftArrow)
        
        configView.addConstraintsWithFormat(format: "V:|-200-[v0(50)]", views: rightArrow)
        configView.addConstraintsWithFormat(format: "H:[v0(50)]|", views: rightArrow)

    }
    
    

    //MARK - Button Actions
    
    @objc func nextImage() {
        selectedImage = (selectedImage + 1) % imagesNames.count
    }
    
    @objc func previousImage() {
        if selectedImage == 0 {
            selectedImage = imagesNames.count - 1
        } else {
            selectedImage -= 1
        }
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func presentNextView() {
        let detailsVC = DetailsController()

        detailsVC.imageName = imagesNames[selectedImage]
        detailsVC.workoutName = textField.text
        present(detailsVC, animated: false, completion: nil)

        
    }

}

extension NewWorkoutController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        nextButton.isEnabled = true
        nextButton.alpha = 1
    }
    
}
