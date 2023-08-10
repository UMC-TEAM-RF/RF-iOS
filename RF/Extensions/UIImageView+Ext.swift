//
//  UIImageView+Ext.swift
//  RF
//
//  Created by 용용이 on 2023/08/10.
//

import Foundation
import UIKit


extension UIImageView{
//    func gradientFrameSync(){
//        self.layer.sublayers?[0].frame = self.bounds
//    }
    func gradientFilter(colors : [CGColor]) -> UIImageView{
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors
        self.layer.insertSublayer(gradient, at: 0)
        
        return self
    }
}


//Example Code
//let startColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1).cgColor
//let endColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.9).cgColor
//
//let imageView = UIImageView(image: image).gradientFilter(colors: [startColor, endColor])
