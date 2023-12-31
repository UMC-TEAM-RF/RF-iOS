//
//  SignInComponent.swift
//  RF
//
//  Created by 박기용 on 2023/07/06.
//
import UIKit


class PasswordTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    //show/hide button
    private lazy var button : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.imageView?.tintColor = .lightGray
        return button
    }()
    
    private func setup() {
        self.isSecureTextEntry = true
        
        rightView = button
        rightViewMode = .always
        button.addTarget(self, action: #selector(showHidePassword(_:)), for: .touchUpInside)
        
        
        self.keyboardType = UIKeyboardType.alphabet
        self.returnKeyType = UIReturnKeyType.done
        self.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        self.autocorrectionType = .no
        
        if #available(iOS 12.0, *) {
            self.textContentType = .oneTimeCode
        }
    }
    
    
    func setColor(_ color : UIColor) {
        self.textColor = color
    }
    func setButtonColor(_ color : UIColor) {
        self.button.imageView?.tintColor = color
    }
    
    @objc private func showHidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isSecureTextEntry = !sender.isSelected
    }
    
}
