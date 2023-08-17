//
//  GradientView.swift
//  RF
//
//  Created by 용용이 on 2023/08/17.
//

import UIKit

class GradientView: UIView {
    var bgdPictureFilter : [CGColor] = []
    var bgdLocations : [NSNumber] = []
    
    func addFilter(color : CGColor, locationY : NSNumber){
        bgdPictureFilter.append(color)
        bgdLocations.append(locationY)
    }
    func clearFilter(){
        bgdPictureFilter = []
        bgdLocations = []
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = bgdPictureFilter
        (layer as! CAGradientLayer).locations = bgdLocations
    }
}
