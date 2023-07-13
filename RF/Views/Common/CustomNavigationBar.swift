//
//  CreateMeetingNavigationBar.swift
//  RF
//
//  Created by 이정동 on 2023/07/10.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CustomNavigationBar: UIView {

    // MARK: - UI Property
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 생성"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    // MARK: - Property
    
    weak var delegate: NavigationBarDelegate?
    
    var titleLabelText: String? {
        didSet {
            self.titleLabel.text = titleLabelText
        }
    }
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubviews() {
        addSubview(contentView)
        contentView.addSubview(backButton)
        contentView.addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func addTargets() {
        backButton.rx.tap
            .subscribe(onNext: {
                self.delegate?.backButtonTapped()
            })
            .disposed(by: disposeBag)
    }
}


