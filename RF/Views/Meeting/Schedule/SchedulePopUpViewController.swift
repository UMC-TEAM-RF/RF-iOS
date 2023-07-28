//
//  SchedulePopUpViewController.swift
//  RF
//
//  Created by 정호진 on 2023/07/28.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

/// MARK: 일정을 눌렀을 때 뜨는 팝업 창
final class SchedulePopUpViewController: DimmedViewController{
    
    /// MARK: Pop up 창 base view
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - init
    
    init() {
        super.init(durationTime: 0.3, alpha: 0.25)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        view.addSubview(baseView)
        
        configureConstraints()
    }
    
    /// MARK: Setting AutoLayout
    private func configureConstraints(){
        baseView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/3)
        }
    }
    
    
}
