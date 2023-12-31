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

class PersonnelStepper: UIControl {
    
    // MARK: - UI Property
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 0.5
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.backgroundColor = StrokeColor.main.color
        sv.layer.cornerRadius = 10
        sv.clipsToBounds = true
        return sv
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.tag = -1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.backgroundColor = ButtonColor.normal.color
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.tag = -1
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.backgroundColor = ButtonColor.normal.color
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = TextColor.first.color
        label.textAlignment = .center
        label.backgroundColor = ButtonColor.normal.color
        return label
    }()
    
    // MARK: - Property
    
    private var currentValue: Int = 0
    
    var minimumCount: Int = 0 {
        didSet {
            currentValue = minimumCount
            countLabel.text = "\(currentValue)"
        }
    }
    var maximumCount: Int = 5
    
    
    
    var value: Int {
        get {
            return currentValue
        }
    }
    
    private let disposeBag = DisposeBag()
    var selectedMembercount: BehaviorSubject<Int> = BehaviorSubject(value: 0)
    
    // MARK: - init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(minusButton)
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(plusButton)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - addTargets()

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
        selectedMembercount.onNext(currentCount + value)
        currentValue = currentCount + value
        sendActions(for: .valueChanged)
    }
}
