//
//  settingTableViewCell.swift
//  RF
//
//  Created by 용용이 on 2023/10/16.
//

import UIKit


class settingTableViewCell: UITableViewCell {
    
    // MARK: - UI Property
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = TextColor.first.color
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    /// MARK: 날짜 바꾸는 버튼
    private lazy var editButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "chevron.right")?.resize(newWidth: 14), for: .normal)
        return btn
    }()
    
    // MARK: - Property
    
    static let identifier = "settingTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        configureConstraints()
        
        
//        let view = UIView()
//        view.backgroundColor = StrokeColor.sub.color
//        self.selectedBackgroundView = view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        addSubview(label)
        addSubview(editButton)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(editButton.snp.leading).offset(20)
        }
        editButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    func updateTitle(_ txt: String) {
        label.text = txt
    }
    func updateColor(_ color: UIColor) {
        label.textColor = color
    }
}
