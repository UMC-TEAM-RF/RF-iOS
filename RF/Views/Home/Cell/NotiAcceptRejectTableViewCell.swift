//
//  NotiAcceptRejectTableViewCell.swift
//  RF
//
//  Created by 정호진 on 2023/08/11.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxRelay

final class NotiAcceptRejectTableViewCell: UITableViewCell {
    static let identifier = "NotiAcceptRejectTableViewCell"
    
    /// MARK: 사용자 프로필 이미지
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "LogoImage")?.resize(newWidth: 50,newHeight: 50)
        image.clipsToBounds = true
        return image
    }()
    
    /// MARK: 소속 라벨
    private lazy var joinedGroupLabel: UILabel = {
        let label = UILabel()
        label.text = "소속"
        label.font = .systemFont(ofSize: 14,weight: .semibold)
        return label
    }()
    
    /// MARK: 소속
    private lazy var joinedGroup: UILabel = {
        let label = UILabel()
        label.text = "aa"
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    
    /// MARK: 국가 라벨
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = "국가"
        label.font = .systemFont(ofSize: 14,weight: .semibold)
        return label
    }()
    
    /// MARK: 국가 라벨
    private lazy var country: UILabel = {
        let label = UILabel()
        label.text = "aab"
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    
    /// MARK: MBTI 라벨
    private lazy var MBTILabel: UILabel = {
        let label = UILabel()
        label.text = "MBTI"
        label.font = .systemFont(ofSize: 14,weight: .semibold)
        return label
    }()
    
    /// MARK: MBTI 라벨
    private lazy var MBTI: UILabel = {
        let label = UILabel()
        label.text = "aadd"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    /// MARK: 제목 Stack View
    private lazy var titleStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [joinedGroupLabel, countryLabel, MBTILabel])
        view.distribution = .fillEqually
        view.axis = .vertical
        return view
    }()
    
    /// MARK: 내용 Stack View
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [joinedGroup, country, MBTI])
        view.distribution = .fillEqually
        view.axis = .vertical
        return view
    }()
    
    /// MARK: 거절 버튼
    private lazy var rejectButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("거절", for: .normal)
        btn.backgroundColor = UIColor(hexCode: "F5F5F5")
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    /// MARK: 수락 버튼
    private lazy var acceptButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("수락", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    weak var delegate: ClickedAcceptRejectDelegate?
    var indexPath: BehaviorRelay<IndexPath> = BehaviorRelay<IndexPath>(value: IndexPath())
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        clickedButtons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - addSubviews
    
    private func addSubviews() {
        addSubview(profileImage)
        addSubview(titleStackView)
        addSubview(stackView)
        
        contentView.addSubview(rejectButton)
        contentView.addSubview(acceptButton)
        configureConstraints()
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        profileImage.snp.makeConstraints { make in
            make.centerY.equalTo(titleStackView.snp.centerY)
            make.leading.equalToSuperview().offset(30)
        }
        
        titleStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(profileImage.snp.trailing).offset(30)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.top)
            make.leading.equalTo(titleStackView.snp.trailing).offset(10)
            make.bottom.equalTo(titleStackView.snp.bottom)
        }
        
        rejectButton.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(self.snp.centerX).offset(-10)
        }
        
        acceptButton.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalTo(self.snp.centerX).offset(10)
        }

        setOptions()
    }
    
    // MARK: - Actions
    
    /// MARK: setting more options about UI
    private func setOptions(){
        layoutIfNeeded()
        profileImage.layer.cornerRadius = profileImage.frame.height/2
    }
    
    /// MARK: 버튼 클릭 시
    private func clickedButtons(){
        rejectButton.rx.tap
            .bind { [weak self] in
                self?.delegate?.clickedReject(self?.indexPath.value ?? IndexPath())
            }
            .disposed(by: disposeBag)
        
        acceptButton.rx.tap
            .bind { [weak self] in
                self?.delegate?.clickedAccept(self?.indexPath.value ?? IndexPath())
            }
            .disposed(by: disposeBag)
    }
    
    /// MARK: 데이터 입력
    func inputData(profileIamge: String, joinedGroup: String, country: String, mbti: String){
        self.profileImage.image = UIImage(named: profileIamge)?.resize(newWidth: 50,newHeight: 50)
        self.joinedGroup.text = joinedGroup
        self.country.text = country
        self.MBTI.text = mbti
    }
}

