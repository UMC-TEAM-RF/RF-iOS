//
//  ListViewController.swift
//  RF
//
//  Created by 정호진 on 2023/07/24.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class ListViewController: UIViewController{
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "모임 목록", style: .done, target: self, action: nil)
        btn.isEnabled = false
        btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .disabled)
        return btn
    }()
    
    
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    // MARK: View will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = .black
    }
    
    
    
}
