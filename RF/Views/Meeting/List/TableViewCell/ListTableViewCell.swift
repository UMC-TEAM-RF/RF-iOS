//
//  ListTableViewCell.swift
//  RF
//
//  Created by 정호진 on 2023/07/24.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

final class ListTableViewCell: UITableViewCell{
    static let identifier = "ListTableViewCell"
    
    /// MARK: 프로필 들어갈 View
    private lazy var profileUIView: GroupProfileView = {
        let view = GroupProfileView()
        view.backgroundColor = .clear
        return view
    }()
    
    /// MARK: 모임 이름
    private lazy var meetingTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexCode: "3C3A3A")
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    /// MARK: 소속된 학교 이름
    private lazy var universityLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexCode: "818181")
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    /// MARK: 대학, 국가 아이콘을 넣을 view
    private lazy var organizationView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    /// MARK: 소속된 국가 아이콘
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexCode: "818181")
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    /// MARK: 대학이름과 국기 구별하는 View
    private lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "818181")
        return view
    }()
    
    /// MARK: 찜하기 버튼
    private lazy var likeButton: UIButton = {
        let btn = UIButton()
        btn.isEnabled = false
        return btn
    }()
    
    /// MARK: Label 담는 StackView
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [meetingTitleLabel,organizationView])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let viewModel = ListCellViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - functions
    
    /// MARK: add UI
    private func addSubviews(){
        addSubview(profileUIView)
        addSubview(stackView)
        
        organizationView.addSubview(universityLabel)
        organizationView.addSubview(separateView)
        organizationView.addSubview(countryLabel)
        contentView.addSubview(likeButton)
        
        configureConstraints()
    }
    
    /// MARK: setting AutoLayout
    private func configureConstraints(){
        profileUIView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalToSuperview().dividedBy(5)
            make.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileUIView.snp.centerY)
            make.leading.equalTo(profileUIView.snp.trailing).offset(10)
        }
        
        universityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        separateView.snp.makeConstraints { make in
            make.top.equalTo(universityLabel.snp.top)
            make.bottom.equalTo(universityLabel.snp.bottom)
            make.leading.equalTo(universityLabel.snp.trailing).offset(3)
            make.width.equalTo(1)
        }
        
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(universityLabel.snp.top)
            make.bottom.equalTo(universityLabel.snp.bottom)
            make.leading.equalTo(separateView.snp.trailing).offset(3)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    /// MARK: binding function
    private func bind(){
        likeButton.rx.tap
            .bind { [weak self] _ in
                self?.viewModel.checkLike.accept(false)
                self?.likeButton.isHidden = true
            }.disposed(by: disposeBag)
        
        
        viewModel.checkLike
            .bind(onNext: { [weak self] check in
                if check{
                    self?.likeButton.isEnabled = true
                    self?.likeButton.setImage(UIImage(systemName: "heart.fill")?.resize(newWidth: 25), for: .normal)
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    /// MARK: remove layout
    func removeCellLayout(){
        profileUIView.removeFromSuperview()
    }
    
    /// 모임 목록 데이터 넣는 함수
    /// - Parameters:
    ///   - meetingName: 모임 이름
    ///   - university: 학교 이름
    ///   - country: 도시 이름
    func inputData(imageList: [String]?, meetingName: String?, university: String?, country: String?, like: Bool?){
        addSubviews()
        
        guard let imageList = imageList,
              let meetingName = meetingName,
              let university = university,
              let country = country,
              let like = like else { return }
        
        meetingTitleLabel.text = meetingName
        universityLabel.text = university
        countryLabel.text = country
        viewModel.checkLike.accept(like)
        
        profileUIView.updateProfileImages(with: imageList)
        bind()
    }
    
}
