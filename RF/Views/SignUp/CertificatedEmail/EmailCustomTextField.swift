//
//  EmailCustomTextField.swift
//  RF
//
//  Created by 정호진 on 2023/08/06.
//

import Foundation
import UIKit
import SnapKit

final class EmailCustomTextField: UITextField {
    
    /// MARK: 밑줄
    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    /// MARK: Add UI
    private func addSubViews() {
        addSubview(underLineView)
        
        self.borderStyle = UITextField.BorderStyle.none
        self.keyboardType = UIKeyboardType.default
        self.returnKeyType = UIReturnKeyType.done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        configureConstraints()
    }
    
    /// MARK: Setting AutoLayout
    private func configureConstraints() {
        
        underLineView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
}
