//
//  GradientView.swift
//  RF
//
//  Created by 용용이 on 2023/08/17.
//

import UIKit


class GradientView: UIView {
    //Background Picture Filter
    let bgdPictureFilter = [UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1).cgColor,UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6).cgColor,UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor]
    let bgdLocations : [NSNumber] = [0.0, 0.4, 1]

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = bgdPictureFilter
        (layer as! CAGradientLayer).locations = bgdLocations
    }
}
