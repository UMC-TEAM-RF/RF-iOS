//
//  FAQViewController.swift
//  RF
//
//  Created by 이정동 on 11/9/23.
//

import Foundation
import UIKit

class FAQViewController: UIViewController {
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        updateTitleView(title: "자주 묻는 질문")
        setupCustomBackButton()
    }
}
