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
final class DetailMeetingHomeController: UIViewController {
    
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
        label.text = "👋 내일 같이 땀 흘려 볼까요?"
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
    
    /// MARK: 멤버 정원, 선호 연령대, 사용 언어, 활동 장소 묶는 UIView
    private lazy var infomationUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "F5F5F5")
        view.layer.cornerRadius = 10
        return view
    }()
    
    
    /// MARK: 모임 소개 제목
    private lazy var meetingLabel: UILabel = {
        let label = UILabel()
        label.text = "📣 모임 소개"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    /// MARK: 모임 설명 감싸고 있는 View
    private lazy var meetingIntroductionRoundUIView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "F5F5F5")
        view.layer.cornerRadius = 10
        return view
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
        label.text = "💬 다친의 규칙"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    /// MARK: 규칙 표시할 CollectionView
    private lazy var ruleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = true
        return cv
    }()
    
    /// MARK: 가입 멤버 제목
    private lazy var joinMemberLabel: UILabel = {
        let label = UILabel()
        label.text = "👥 가입 멤버"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    /// MARK: 가입 멤버 제목
    private lazy var joinMemberNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "4/5"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    /// MARK: 가입 멤버 CollectionView
    private lazy var joinMemberCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        return cv
    }()
    
    /// MARK: 찜하기 버튼
    private lazy var likeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("찜하기", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        btn.backgroundColor = UIColor(hexCode: "FAFAFA")
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    /// MARK: 가입하기 버튼
    private lazy var joinBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("가입하기", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        btn.backgroundColor = UIColor(hexCode: "F1F1F1")
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(.systemBlue, for: .normal)
        return btn
    }()
    
    
    private let disposeBag = DisposeBag()
    private var interestingList: [String] = []
    private var memberList: [Member] = []
    private var ruleList: [String] = []
    private var meetingIntroductionUIViewConstraint: Constraint?
    private var ruleCollectionViewConstraint: Constraint?
    private var ruleCollectionViewHeight: CGFloat = 0
    private var ruleCellWidth: CGFloat = 0
    
    // MARK: - init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        addSubviews()
        dummyData()
        clickedBtns()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    /*
     UI Actions
     */
    
    /// Add UI
    private func addSubviews(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleImg)
        contentView.addSubview(interestingCollectionView)
        interestingCollectionView.dataSource = self
        interestingCollectionView.delegate = self
        interestingCollectionView.register(InterestingCollectionViewCell.self, forCellWithReuseIdentifier: InterestingCollectionViewCell.identifier)
        
        contentView.addSubview(titleLabel)
        
        memberUIView.addSubview(memberTitleLabel)
        memberUIView.addSubview(memberContentLabel)
        
        ageUIView.addSubview(ageTitleLabel)
        ageUIView.addSubview(ageContentLabel)
        
        languageUIView.addSubview(languageTitleLabel)
        languageUIView.addSubview(languageContentLabel)
        
        placeUIView.addSubview(placeTitleLabel)
        placeUIView.addSubview(placeContentLabel)
        
        contentView.addSubview(infomationUIView)
        infomationUIView.addSubview(memberUIView)
        infomationUIView.addSubview(ageUIView)
        infomationUIView.addSubview(languageUIView)
        infomationUIView.addSubview(placeUIView)
        
        contentView.addSubview(meetingLabel)
        contentView.addSubview(meetingIntroductionRoundUIView)
        meetingIntroductionRoundUIView.addSubview(meetingIntroduction)
        
        contentView.addSubview(ruleLabel)
        
        contentView.addSubview(ruleCollectionView)
        ruleCollectionView.dataSource = self
        ruleCollectionView.delegate = self
        ruleCollectionView.register(RuleCollectionViewCell.self, forCellWithReuseIdentifier: RuleCollectionViewCell.identifier)
        
        contentView.addSubview(joinMemberLabel)
        contentView.addSubview(joinMemberNumberLabel)
        contentView.addSubview(joinMemberCollectionView)
        joinMemberCollectionView.dataSource = self
        joinMemberCollectionView.delegate = self
        joinMemberCollectionView.register(JoinMemberCollectionViewCell.self, forCellWithReuseIdentifier: JoinMemberCollectionViewCell.identifier)
        
        view.addSubview(likeBtn)
        view.addSubview(joinBtn)
        
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
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(titleImg.snp.width).multipliedBy(0.9/1.6)
        }
        
        /// 관심 분야
        interestingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleImg.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/25)
        }

        /// 모임 제목
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(interestingCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        /// 모임 특징
        infomationUIView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/7)
        }
        
        // MARK: 멤버 정원 UI
        memberUIView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        memberTitleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        memberContentLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        // MARK: 선호 연령대 UI
        ageUIView.snp.makeConstraints { make in
            make.top.equalTo(memberUIView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        ageTitleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        ageContentLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        // MARK: 선호 연령대
        languageUIView.snp.makeConstraints { make in
            make.top.equalTo(ageUIView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        languageTitleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        languageContentLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        // MARK: 장소
        placeUIView.snp.makeConstraints { make in
            make.top.equalTo(languageUIView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        placeTitleLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        placeContentLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        
        /// 모임 소개
        meetingLabel.snp.makeConstraints { make in
            make.top.equalTo(infomationUIView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        meetingIntroduction.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        meetingIntroductionRoundUIView.snp.makeConstraints { make in
            make.top.equalTo(meetingLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            meetingIntroductionUIViewConstraint = make.height.equalTo(40).priority(250).constraint
        }
        
        /// 규칙
        ruleLabel.snp.makeConstraints { make in
            make.top.equalTo(meetingIntroductionRoundUIView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(30)
            
        }
        
        ruleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(ruleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/14)
        }
        
        /// 가입 멤버
        joinMemberLabel.snp.makeConstraints { make in
            make.top.equalTo(ruleCollectionView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(30)
        }
        
        joinMemberNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(joinMemberLabel.snp.centerY)
            make.leading.equalTo(joinMemberLabel.snp.trailing).offset(10)
        }
        
        joinMemberCollectionView.snp.makeConstraints { make in
            make.top.equalTo(joinMemberLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/10)
            make.bottom.equalToSuperview().offset(-view.safeAreaLayoutGuide.layoutFrame.height/10)
        }
        
        likeBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.width.equalTo(view.safeAreaLayoutGuide.layoutFrame.width/2)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/18)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        joinBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.width.equalTo(view.safeAreaLayoutGuide.layoutFrame.width/2)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/18)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    /// MARK: 버튼 클릭 함수
    private func clickedBtns(){
        likeBtn.rx.tap
            .subscribe(onNext:{
                print("clicked like Button")
            })
            .disposed(by: disposeBag)
        
        joinBtn.rx.tap
            .subscribe(onNext:{ [weak self] in
                print("clicked join Button")
                let detailMeetingJoinPopUpViewController = DetailMeetingJoinPopUpViewController()
                self?.present(detailMeetingJoinPopUpViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    /// MARK: 테스트용 더미 데이터
    private func dummyData(){
        interestingList.append("스포츠")
        interestingList.append("경기")
        interestingList.append("국가")
        
        let longText = """
        1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!1해외 축구 팬들 모여라!해외 축구 팬들 모여라!
                👍👍👍👍👍👍👍👍
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
        meetingIntroductionUIViewConstraint?.update(offset: newHeight)
        
        ruleList.append("abcdefasdfabcdefasdfabcdefasdf")
        ruleList.append("abcdefasdfabcdefasdfabcdefasdf")
        ruleList.append("abcdefasdf")
        ruleList.append("abcdefasdfabcdefasd")
        ruleList.append("abcdefasdf")
        
        
        
        memberList.append(Member(imgPath: "", name: "aa1", nationality: "bb1"))
        memberList.append(Member(imgPath: "", name: "aa2", nationality: "bb2"))
        memberList.append(Member(imgPath: "", name: "aa3", nationality: "bb3"))
        memberList.append(Member(imgPath: "", name: "aa4", nationality: "bb4"))
        memberList.append(Member(imgPath: "", name: "aa5", nationality: "bb5"))
        
    }
    
}

extension DetailMeetingHomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == interestingCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestingCollectionViewCell.identifier, for: indexPath) as? InterestingCollectionViewCell else {return UICollectionViewCell() }
            cell.inputData(text: interestingList[indexPath.row])
            cell.backgroundColor = UIColor(hexCode: "006FF2")
            cell.layer.cornerRadius = 10
            return cell
        }
        else if collectionView == ruleCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RuleCollectionViewCell.identifier, for: indexPath) as? RuleCollectionViewCell else {return UICollectionViewCell() }
            
            cell.inputData(text: ruleList[indexPath.row])
            cell.backgroundColor = UIColor(hexCode: "f5f5f5")
            cell.layer.cornerRadius = 15
            
            return cell
        }
        else if collectionView == joinMemberCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JoinMemberCollectionViewCell.identifier, for: indexPath) as? JoinMemberCollectionViewCell else {return UICollectionViewCell() }
            
            cell.inputData(profileImg: memberList[indexPath.row].imgPath ?? "",
                           name: memberList[indexPath.row].name ?? "",
                           nationality: memberList[indexPath.row].nationality ?? "")
            cell.backgroundColor = .systemBackground
            
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == interestingCollectionView{
            let interesting = interestingList[indexPath.row]
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let newSize = (interesting as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
            
            return CGSize(width: newSize.width + 10, height: collectionView.bounds.height)
        }
        else if collectionView == ruleCollectionView{
            let rule = ruleList[indexPath.row]
            
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let newSize = (rule as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])

            return CGSize(width: newSize.width, height: 35)
        }
        else if collectionView == joinMemberCollectionView{
            return CGSize(width: collectionView.bounds.width/6, height: collectionView.bounds.height)
        }
        else{
            return CGSize(width: 1, height: 1)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == interestingCollectionView{
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        else if collectionView == ruleCollectionView{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        else if collectionView == joinMemberCollectionView{
            return memberList.count
        }
        else{
            return 0
        }
    }
    
    
    
}


