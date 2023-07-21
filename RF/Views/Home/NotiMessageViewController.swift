//
//  NotiMessageViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/21.
//

import UIKit
import SnapKit

class NotiMessageViewController: UIViewController {

    // MARK: - UI Property
    
    private lazy var navigationBar: CustomNavigationBar = {
        let bar = CustomNavigationBar()
        bar.delegate = self
        bar.buttonText = "알림"
        return bar
    }()
    
    // MARK: - Property
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        addSubviews()
        configureConstraints()
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(navigationBar)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        navigationBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
    }

}

extension NotiMessageViewController: NavigationBarDelegate {
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
