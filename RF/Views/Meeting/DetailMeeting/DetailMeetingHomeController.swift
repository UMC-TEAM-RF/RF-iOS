//
//  DetailMeetingHomeController.swift
//  RF
//
//  Created by 정호진 on 2023/07/10.
//

import Foundation
import UIKit
import Tabman
import RxSwift

/// 모임 상세보기 '홈' 화면
final class DetailMeetingHomeController: UIViewController{
    private var interestingList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        addSubviews()
        dummyData()
    }
    
    /*
     UI Code
     */
    
    /// MARK: Scrollview
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .systemBackground
        return scroll
    }()
    
    /// MARK: ContentView
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    /// MARK: 대표이미지
    private lazy var titleImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "LogoImage")?.resize(newWidth: 100)
        return img
    }()
    
    /// MARK: 관심사 표시할 CollectionView
    private lazy var interestingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        return cv
    }()
    
    /// MARK: 모임 이름
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내일 같이 땀 흘려 볼까요?"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    /// MARK: 멤버 / 정원 제목
    private lazy var memberTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "멤버 / 정원"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    /// MARK: 멤버 / 정원 내용
    private lazy var memberContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "1"
        return label
    }()
    
    /// MARK: 멤버 / 정원 StackView
    private lazy var memberUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    /// MARK: 선호 연령대 제목
    private lazy var ageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "선호 연령대"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    /// MARK: 선호 연령대 내용
    private lazy var ageContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "1"
        return label
    }()
    
    /// MARK: 선호 연령대 StackView
    private lazy var ageUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    /// MARK: 사용 언어 제목
    private lazy var languageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "사용 언어"
        return label
    }()
    
    /// MARK: 사용 언어 내용
    private lazy var languageContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "1"
        return label
    }()
    
    /// MARK: 사용 언어 Custom UIView
    private lazy var languageUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    /// MARK: 활동 장소 제목
    private lazy var placeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "활동 장소"
        return label
    }()
    
    /// MARK: 활동 장소내용
    private lazy var placeContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "1"
        return label
    }()
    
    /// MARK: 활동 장소StackView
    private lazy var placeUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    /// MARK: 멤버 정원, 선호 연령대, 사용 언어, 활동 장소 묶는 StackView
    private lazy var infomationStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [memberUIView, ageUIView, languageUIView, placeUIView])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    /*
     UI Actions
     */
    
    /// Add UI
    private func addSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleImg)
        contentView.addSubview(interestingCollectionView)
        contentView.addSubview(titleLabel)
        
        memberUIView.addSubview(memberTitleLabel)
        memberUIView.addSubview(memberContentLabel)
        
        ageUIView.addSubview(ageTitleLabel)
        ageUIView.addSubview(ageContentLabel)
        
        languageUIView.addSubview(languageTitleLabel)
        languageUIView.addSubview(languageContentLabel)
        
        placeUIView.addSubview(placeTitleLabel)
        placeUIView.addSubview(placeContentLabel)
        
        contentView.addSubview(infomationStackView)
        interestingCollectionView.dataSource = self
        interestingCollectionView.delegate = self
        interestingCollectionView.register(InterestingCollectioViewCell.self, forCellWithReuseIdentifier: InterestingCollectioViewCell.identifier)
        
        
        configureCollectionView()
    }
    
    /// Set AutoLayout
    private func configureCollectionView() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        titleImg.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/5)
        }
        
        interestingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleImg.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/25)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(interestingCollectionView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().offset(30)
        }
        
        infomationStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height*1/10)
        }
        
        /// Information StackView 내부
        memberTitleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        memberContentLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(memberTitleLabel.snp.trailing).offset(20)
        }
        
        ageTitleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        ageContentLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(ageTitleLabel.snp.trailing).offset(20)
        }
        
        languageTitleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        languageContentLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(languageTitleLabel.snp.trailing).offset(20)
        }
        
        placeTitleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        placeContentLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(placeTitleLabel.snp.trailing).offset(20)
        }
        
        
    }
    
    /// MARK: 테스트용 더미 데이터
    private func dummyData(){
        interestingList.append("스포츠")
        interestingList.append("경기")
        interestingList.append("국가")
        
    }
    
}

extension DetailMeetingHomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == interestingCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestingCollectioViewCell.identifier, for: indexPath) as? InterestingCollectioViewCell else {return UICollectionViewCell() }
            cell.inputData(text: interestingList[indexPath.row])
            cell.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0) /* #f5f5f5 */
            cell.layer.cornerRadius = 15
            return cell
        }
        else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestingCollectioViewCell.identifier, for: indexPath) as? InterestingCollectioViewCell else {return UICollectionViewCell() }
            
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == interestingCollectionView{
            return CGSize(width: collectionView.bounds.width/4, height: collectionView.bounds.height*4/5)
        }
        else{
            return CGSize(width: 1, height: 1)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == interestingCollectionView{
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return interestingList.count }
}
