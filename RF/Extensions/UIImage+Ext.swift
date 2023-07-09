//
//  UIImage+Ext.swift
//  RF
//
//  Created by 이정동 on 2023/07/09.
//

import Foundation
import UIKit

extension UIImage {
    // MARK: 이미지 크기 재배치 하는 함수
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return renderImage
    }
    
    // MARK: 이미지 크기 (강제)재배치 하는 함수
    func resize(newWidth: CGFloat, newHeight: CGFloat) -> UIImage {
        
        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return renderImage
    }
    
}
