//
//  MyPageReportDetailsTabViewController.swift
//  RF
//
//  Created by 이정동 on 11/9/23.
//

import UIKit

// MARK: - MyPageReportSecondTabViewController
class MyPageReportDetailsViewController: UIViewController {
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "추후 구현 예정"
        label.font = .systemFont(ofSize: 14)
        label.textColor = TextColor.first.color
        return label
    }()
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
