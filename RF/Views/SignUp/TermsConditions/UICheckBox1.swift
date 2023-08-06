//
//  UICheckBox1.swift
//  RF
//
//  Created by 정호진 on 2023/08/04.
//

import Foundation
import UIKit
import RxSwift

final class UICheckBox1: UIButton {
    private let disposeBag = DisposeBag()
    private var offimage: UIImage?
    private var onimage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setTitle(title : String) {
        self.setTitle("  " + title, for: .normal)
    }
    
    func setFont(size : CGFloat, weight : UIFont.Weight = .regular) {
        self.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.offimage = offimage?.resize(newWidth: size*0.8, newHeight: size*0.8)
        self.onimage = onimage?.resize(newWidth: size*0.8, newHeight: size*0.8)
        self.setImage(offimage, for: .normal)
        self.setImage(onimage, for: .selected)
    }
    
    func setWeight(weight : UIFont.Weight) {
        self.titleLabel?.font = UIFont.systemFont(ofSize: self.titleLabel?.font.pointSize ?? 15, weight: weight)
    }
    
    func setSelectedColor(color : UIColor) {
        self.onimage = self.onimage?.withTintColor(color)
        self.setImage(onimage, for: .selected)
        self.setTitleColor(color, for: .selected)
    }
    
    func setNormalColor(color : UIColor) {
        self.offimage = self.offimage?.withTintColor(color)
        self.setImage(offimage, for: .normal)
        self.setTitleColor(color, for: .normal)
    }
    
    private func setup() {
        self.offimage = UIImage(systemName: "checkmark")?
            .resize(newWidth: 12, newHeight: 12)
            .withTintColor(.lightGray)
        self.onimage = UIImage(systemName: "checkmark")?
            .resize(newWidth: 12, newHeight: 12)
            .withTintColor(.black)
        
        self.setTitle("  ", for: .normal)
        self.setTitleColor(.lightGray, for: .normal)
        self.setTitleColor(.black, for: .selected)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        self.setImage(offimage, for: .normal)
        self.setImage(onimage, for: .selected)
        
        self.rx.tap.subscribe(onNext: {
            self.isSelected = !self.isSelected
            guard let _ = self.buttonClicked else { return }
            self.buttonClicked!()
        })
        .disposed(by: disposeBag)
    }
    
    private var buttonClicked : (() -> Void)?
    
    func setEventFunction(function : (() -> Void)?){
        buttonClicked = function
    }
}


