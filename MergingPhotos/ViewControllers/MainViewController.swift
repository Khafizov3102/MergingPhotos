//
//  ViewController.swift
//  MergingPhotos
//
//  Created by Денис Хафизов on 15.04.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var firstImageView = UIImageView()
    private var secondImageView = UIImageView()
    private var mergeButton: UIButton = {
        var button = UIButton()
        button.setTitle("Merge photos ", for: .normal)
        return button
    }()
    
    private var firstImagePickerController = UIImagePickerController()
    private var secondImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    @objc
    private func makeFirstPhotoButtonPressed() {
        firstImagePickerController.delegate = self
        firstImagePickerController.sourceType = .photoLibrary
        present(firstImagePickerController, animated: true)
    }
    
    @objc
    private func makeSecondPhotoButtonPressed() {
        secondImagePickerController.delegate = self
        secondImagePickerController.sourceType = .camera
        present(secondImagePickerController, animated: true)
    }
    
    @objc
    private func mergeButtonPressed() {
        let resultVC = ResultViewController()
        resultVC.configure(firstImage: firstImageView.image ?? UIImage(), secondImage: secondImageView.image ?? UIImage())
        present(resultVC, animated: true)
    }
    
    private func setupUI() {
        firstImageView.layer.cornerRadius = 10
        firstImageView.contentMode = .scaleAspectFill
        firstImageView.backgroundColor = .gray
        firstImageView.clipsToBounds = true
        
        secondImageView.layer.cornerRadius = 10
        secondImageView.contentMode = .scaleAspectFill
        secondImageView.backgroundColor = .gray
        secondImageView.clipsToBounds = true
        
        let firstButton = UIButton()
        firstButton.setTitle("Make first photo", for: .normal)
        firstButton.setTitleColor(.black, for: .normal)
        firstButton.addTarget(self, action: #selector(makeFirstPhotoButtonPressed), for: .touchUpInside)
        
        let secondButton = UIButton()
        secondButton.setTitle("Make second photo", for: .normal)
        secondButton.setTitleColor(.black, for: .normal)
        secondButton.addTarget(self, action: #selector(makeSecondPhotoButtonPressed), for: .touchUpInside)
        
        let firstPhotoStackView = UIStackView(arrangedSubviews: [firstImageView, firstButton])
        firstPhotoStackView.axis = .vertical
        firstPhotoStackView.spacing = 10
        firstPhotoStackView.distribution = .fill
        
        let secondPhotoStackView = UIStackView(arrangedSubviews: [secondImageView, secondButton])
        secondPhotoStackView.axis = .vertical
        secondPhotoStackView.spacing = 10
        secondPhotoStackView.distribution = .fill
        
        mergeButton.translatesAutoresizingMaskIntoConstraints = false
        mergeButton.addTarget(self, action: #selector(mergeButtonPressed), for: .touchUpInside)
        mergeButton.setTitleColor(.darkGray, for: .normal)
        view.addSubview(mergeButton)
        
        let mainStackView = UIStackView(arrangedSubviews: [firstPhotoStackView, secondPhotoStackView])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 30
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStackView.heightAnchor.constraint(equalToConstant: 200),
            
            mergeButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20),
            mergeButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            mergeButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
    }
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            dismiss(animated: true)
            return
        }
        if picker == firstImagePickerController {
            firstImageView.image = image
        } else if picker == secondImagePickerController {
            secondImageView.image = image
        }
        dismiss(animated: true)
    }
}
