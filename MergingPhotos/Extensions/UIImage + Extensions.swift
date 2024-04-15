//
//  UIImage + Extensions.swift
//  MergingPhotos
//
//  Created by Денис Хафизов on 15.04.2024.
//

import UIKit

extension UIImage {
    func merge(image: UIImage) -> UIImage {
        let size = CGSize(width: self.size.width + image.size.width, height: max(self.size.height, image.size.height))
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        image.draw(in: CGRect(x: self.size.width, y: 0, width: image.size.width, height: image.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
