//
//  CreateMeetingNameViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/10.
//

import UIKit
import SnapKit

class CreateMeetingNameViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var navigationBar: CreateMeetingNavigationBar = {
        let view = CreateMeetingNavigationBar()
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
        
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
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
    }

}

// MARK: - NavigationBarDelegate

extension CreateMeetingNameViewController: NavigationBarDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
