//
//  CheckBox.swift
//  RF
//
//  Created by 박기용 on 2023/07/06.
//

import UIKit

class UICheckBox: UIButton {
    var isChecked : Bool! = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.setImage(UIImage(systemName: "square"), for: .normal)
        self.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        self.imageView?.tintColor = .darkGray
        self.addTarget(self, action: #selector(showHidePassword(_:)), for: .touchUpInside)
    }
    
    @objc private func showHidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}

