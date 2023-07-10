//
//  DetailMeetingHomeController.swift
//  RF
//
//  Created by 정호진 on 2023/07/10.
//

import Foundation
import UIKit
import Tabman
import SnapKit
import RxSwift

/// 모임 상세보기 '홈' 화면
final class DetailMeetingHomeController: UIViewController{
    private var interestingList: [String] = []
    private var ruleList: [String] = []
    private var meetingIntroductionConstraint: Constraint?
    private var ruleCollectionViewConstraint: Constraint?
    private var ruleCollectionViewHeight: CGFloat = 0
    private var ruleCellWidth: CGFloat = 0
    
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
    
    
    /// MARK: 모임 소개 제목
    private lazy var meetingLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 소개"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    /// MARK: 모임 설명
    private lazy var meetingIntroduction: UILabel = {
        let label = UILabel()
        let font = UIFont.systemFont(ofSize: 14)
        label.font = font
        label.backgroundColor = .clear
        label.numberOfLines = 50
        return label
    }()
    
    /// MARK: 다친의 규칙 제목
    private lazy var ruleLabel: UILabel = {
        let label = UILabel()
        label.text = "다친의 규칙"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    /// MARK: 규칙 표시할 CollectionView
    private lazy var ruleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        return cv
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
        
        contentView.addSubview(meetingLabel)
        contentView.addSubview(meetingIntroduction)
        
        contentView.addSubview(ruleLabel)
        
        contentView.addSubview(ruleCollectionView)
        ruleCollectionView.dataSource = self
        ruleCollectionView.delegate = self
        ruleCollectionView.register(RuleCollectionViewCell.self, forCellWithReuseIdentifier: RuleCollectionViewCell.identifier)
        
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
        
        /// 관심 분야
        interestingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleImg.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/25)
        }

        /// 모임 제목
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(interestingCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        /// 모임 특징
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
        
        
        /// 모임 소개
        meetingLabel.snp.makeConstraints { make in
            make.top.equalTo(infomationStackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        meetingIntroduction.snp.makeConstraints { make in
            make.top.equalTo(meetingLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            meetingIntroductionConstraint = make.height.equalTo(40).priority(250).constraint
        }
        
        /// 규칙
        ruleLabel.snp.makeConstraints { make in
            make.top.equalTo(meetingIntroduction.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(30)
            
        }
        
        ruleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(ruleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom)
            ruleCollectionViewHeight = view.safeAreaLayoutGuide.layoutFrame.height/20
            ruleCollectionViewConstraint = make.height.equalTo(ruleCollectionViewHeight).constraint
        }
        
    }
    
    /// MARK: 테스트용 더미 데이터
    private func dummyData(){
        interestingList.append("스포츠")
        interestingList.append("경기")
        interestingList.append("국가")
        
        let longText = """
        1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!
        같이 이야기도 나누고직접 축구도 같이 해봐요!
        다른 국가의 분들은 어느 구단을 좋아하시나요?
        2해외 축구 팬들 모여라!
        같이 이야기도 나누고직접 축구도 같이 해봐요!
        다른 국가의 분들은 어느 구단을 좋아하시나요?
        3해외 축구 팬들 모여라!
        같이 이야기도 나누고직접 축구도 같이 해봐요!
        다른 국가의 분들은 어느 구단을 좋아하시나요?
        4해외 축구 팬들 모여라!
        같이 이야기도 나누고직접 축구도 같이 해봐요!
        다른 국가의 분들은 어느 구단을 좋아하시나요?
        """
        
        meetingIntroduction.setTextWithLineHeight(text: longText, lineHeight: 25)
        let newHeight = meetingIntroduction.sizeThatFits(meetingIntroduction.attributedText?.size() ?? CGSize(width: 0, height: 0)).height
        meetingIntroductionConstraint?.update(offset: newHeight)
        
        
        ruleList.append("abcdefasdf")
        ruleList.append("abcdefasdfabcdefasdfabcdefasdf")
        ruleList.append("abcdefasdfabcdefasd")
//        ruleList.append("abcdefasdf")
//        ruleList.append("abcdefasdfabcdefasdfabcdefasdf")
        
        
    }
    
}

extension DetailMeetingHomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == interestingCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestingCollectioViewCell.identifier, for: indexPath) as? InterestingCollectioViewCell else {return UICollectionViewCell() }
            cell.inputData(text: interestingList[indexPath.row])
            cell.backgroundColor = UIColor(hexCode: "f5f5f5")
            cell.layer.cornerRadius = 15
            return cell
        }
        else if collectionView == ruleCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RuleCollectionViewCell.identifier, for: indexPath) as? RuleCollectionViewCell else {return UICollectionViewCell() }

            cell.inputData(text: ruleList[indexPath.row])
            cell.backgroundColor = UIColor(hexCode: "f5f5f5")
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
        else if collectionView == ruleCollectionView{
            let rule = ruleList[indexPath.row]
            
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let newSize = (rule as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
            ruleCellWidth += newSize.width
            if ruleCellWidth > collectionView.frame.width{
                print("before \(ruleCollectionViewHeight)")
                ruleCollectionViewHeight += view.safeAreaLayoutGuide.layoutFrame.height/18
                ruleCollectionViewConstraint?.update(offset: ruleCollectionViewHeight)
                ruleCellWidth = 0
                print(ruleCollectionViewHeight)
            }
            return CGSize(width: newSize.width + 30, height: 35)
        }
        else{
            return CGSize(width: 1, height: 1)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == interestingCollectionView || collectionView == ruleCollectionView{
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == interestingCollectionView{
            return interestingList.count
        }
        else if collectionView == ruleCollectionView{
            return ruleList.count
        }
        else{
            return 0
        }
        
    }
}


