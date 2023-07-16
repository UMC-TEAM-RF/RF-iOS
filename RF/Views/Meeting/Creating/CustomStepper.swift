//
//  CustomStepper.swift
//  RF
//
//  Created by 이정동 on 2023/07/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CustomStepper: UIControl {
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 1
        sv.distribution = .fillEqually
        sv.alignment = .fill
        return sv
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.tag = -1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.tag = -1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    var minimumCount: Int = 0
    var maximumCount: Int = 5
    
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
        addSubview(stackView)
        stackView.addArrangedSubview(minusButton)
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(plusButton)
    }
    
    private func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func addTargets() {
        
        minusButton.rx.tap
            .subscribe(onNext: {
                self.updateCountLabel(-1)
            })
            .disposed(by: disposeBag)
        
        plusButton.rx.tap
            .subscribe(onNext: {
                self.updateCountLabel(1)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateCountLabel(_ value: Int) {
        guard let currentCount = Int(countLabel.text ?? "0") else { return }
        guard (minimumCount...maximumCount) ~= currentCount + value else { return }
        
        countLabel.text = "\(currentCount + value)"
        sendActions(for: .valueChanged)
    }
}
