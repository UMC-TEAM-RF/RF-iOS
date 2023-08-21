//
//  GradientView.swift
//  RF
//
//  Created by 용용이 on 2023/08/17.
//

import UIKit


/**
 그라데이션 필터 뷰
 > DetailedMeetingCollectionViewCell에 쓰인다. 정의 후 addFilter 함수를 통해 Y위치에 특정 색깔 필터를 지정할 수 있다.
 
     //사용 예시
     private lazy var backgroundMaskedView: GradientView = {
         let view = GradientView()
         view.addFilter( color: UIColor.black.withAlphaComponent(0.06).cgColor, locationY: 0.0)
         view.addFilter( color: UIColor.black.withAlphaComponent(0.36).cgColor, locationY: 0.6)
         view.addFilter( color: UIColor.black.withAlphaComponent(0.72).cgColor, locationY: 1)
         return view
     }()
 */
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
