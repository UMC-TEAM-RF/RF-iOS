//
//  EmailRequestViewController.swift
//  RF
//
//  Created by 이정동 on 11/9/23.
//

import UIKit

class EmailRequestViewController: UIViewController {

    class MyPageEmailRequestViewController: UIViewController {
        
        // MARK: - viewDidLoad()
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            
            updateTitleView(title: "이메일 문의")
            setupCustomBackButton()
        }
    }

}
