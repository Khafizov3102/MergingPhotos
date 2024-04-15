//
//  ResultViewController.swift
//  MergingPhotos
//
//  Created by Денис Хафизов on 15.04.2024.
//

import UIKit

class ResultViewController: UIViewController {
    
    private var resultImageView = UIImageView()
    private var firstImage = UIImage()
    private var secondImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        
        resultImageView.image = firstImage.merge(image: secondImage)
    }
    
    func configure(firstImage: UIImage, secondImage: UIImage) {
        self.firstImage = firstImage
        self.secondImage = secondImage
    }
    
    private func setupUI() {
        resultImageView.layer.cornerRadius = 10
        resultImageView.contentMode = .scaleAspectFit
        resultImageView.backgroundColor = .gray
        resultImageView.clipsToBounds = true
        resultImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultImageView)
        
        NSLayoutConstraint.activate([
            resultImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            resultImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            resultImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
}


