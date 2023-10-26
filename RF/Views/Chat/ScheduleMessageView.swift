//
//  ScheduleMessageView.swift
//  RF
//
//  Created by 이정동 on 10/19/23.
//

import UIKit
import SnapKit

class ScheduleMessageView: UIView {

    private lazy var messageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = StrokeColor.main.color.cgColor
        return view
    }()
    
    private lazy var vStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 15
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "titleLabel"
        view.font = .systemFont(ofSize: 20, weight: .semibold)
        view.textColor = .black
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var divLine: UIView = {
        let view = UIView()
        view.backgroundColor = BackgroundColor.white.color
        return view
    }()
    
    private lazy var dateStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 5
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let view = UILabel()
        view.text = "일정"
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.textColor = .black
        return view
    }()
    
    private lazy var dateValueLabel: UILabel = {
        let view = UILabel()
        view.text = "상세 일정"
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.textColor = .gray
        return view
    }()
    
    private lazy var placeStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 5
        return view
    }()
    
    private lazy var placeLabel: UILabel = {
        let view = UILabel()
        view.text = "장소"
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.textColor = .black
        return view
    }()
    
    private lazy var placeValueLabel: UILabel = {
        let view = UILabel()
        view.text = "세부 장소"
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.textColor = .gray
        view.numberOfLines = 1
        return view
    }()
    
    weak var delegate: MessageTableViewCellDelegate?
    
    var indexPath: IndexPath?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        addSubview(messageView)
        messageView.addSubview(vStack)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(divLine)
        vStack.addArrangedSubview(dateStackView)
        vStack.addArrangedSubview(placeStackView)
        
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(dateValueLabel)
        
        placeStackView.addArrangedSubview(placeLabel)
        placeStackView.addArrangedSubview(placeValueLabel)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        
        messageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        vStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(titleLabel.intrinsicContentSize.height)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.height.equalTo(dateLabel.intrinsicContentSize.height)
        }
        
        dateValueLabel.snp.makeConstraints { make in
            make.height.equalTo(dateValueLabel.intrinsicContentSize.height)
        }
        
        placeLabel.snp.makeConstraints { make in
            make.height.equalTo(placeLabel.intrinsicContentSize.height)
        }
        
        placeValueLabel.snp.makeConstraints { make in
            make.height.equalTo(placeValueLabel.intrinsicContentSize.height)
        }
        
        divLine.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
    }
    
    private func addTargets() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        messageView.addGestureRecognizer(longPress)
        
    }
    
    func updateMessageSchedule(_ message: RealmMessage) {
        guard let schedule = message.schedule else { return }
        
        titleLabel.text = schedule.name
        placeValueLabel.text = schedule.location
        dateValueLabel.text = schedule.dateTime
    }
    
    @objc func longPressed(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            print("Long")
            delegate?.longPressedMessageView?(gesture)
        }
        
    }
}
