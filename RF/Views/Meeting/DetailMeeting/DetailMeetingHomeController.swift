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
import RxRelay

/// 모임 상세보기 '홈' 화면
final class DetailMeetingHomeController: UIViewController {
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "다국적 사람들과 소통해요!", style: .done, target: self, action: nil)
        btn.isEnabled = false
        btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: TextColor.first.color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20,weight: .bold)], for: .disabled)
        return btn
    }()
    
    /// MARK: 카톡, 메시지, 인스타그램 공유 버튼
    private lazy var firstButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        btn.tintColor = TextColor.first.color
        return btn
    }()
    
    /// MARK: 카톡, 메시지, 인스타그램 공유 버튼
    private lazy var secondButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        btn.tintColor = TextColor.first.color
        return btn
    }()
    
    /// MARK: Scrollview
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
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
        img.image = nil
        img.layer.cornerRadius = 20
        img.clipsToBounds = true
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
    
    /// MARK: 모집중, 모집 마감 표시
    private lazy var isRecruitingButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        return btn
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
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 멤버 / 정원 내용
    private lazy var memberContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "1"
        label.textColor = TextColor.first.color
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
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 선호 연령대 내용
    private lazy var ageContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = TextColor.first.color
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
        label.textColor = TextColor.first.color
        label.text = "사용 언어"
        return label
    }()
    
    /// MARK: 사용 언어 내용
    private lazy var languageContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = TextColor.first.color
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
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 활동 장소내용
    private lazy var placeContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "1"
        label.textColor = TextColor.first.color
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
        view.backgroundColor = BackgroundColor.white.color
        view.layer.cornerRadius = 10
        return view
    }()
    
    
    /// MARK: 모임 소개 제목
    private lazy var meetingLabel: UILabel = {
        let label = UILabel()
        label.text = "📣 모임 소개"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 모임 설명 감싸고 있는 View
    private lazy var meetingIntroductionRoundUIView: UIView = {
        let view = UIView()
        view.backgroundColor = BackgroundColor.white.color
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    /// MARK: 모임 설명
    private lazy var meetingIntroduction: UILabel = {
        let label = UILabel()
        let font = UIFont.systemFont(ofSize: 14)
        label.font = font
        label.backgroundColor = .clear
        label.textColor = TextColor.first.color
        label.numberOfLines = 50
        return label
    }()
    
    /// MARK: 다친의 규칙 제목
    private lazy var ruleLabel: UILabel = {
        let label = UILabel()
        label.text = "💬 다친의 규칙"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 규칙 표시할 CollectionView
    private lazy var ruleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.isScrollEnabled = true
        return cv
    }()
    
    /// MARK: 가입 멤버 제목
    private lazy var joinMemberLabel: UILabel = {
        let label = UILabel()
        label.text = "👥 가입 멤버"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = TextColor.first.color
        return label
    }()
    
    /// MARK: 가입 멤버 제목
    private lazy var joinMemberNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "4/5"
        label.textColor = ButtonColor.main.color
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
        btn.backgroundColor = ButtonColor.normal.color
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(ButtonColor.main.color, for: .normal)
        return btn
    }()
    
    
    private let disposeBag = DisposeBag()
    private let viewModel = DetailMeetingHomeViewModel()
    var meetingIdRelay: BehaviorRelay<Int?> = BehaviorRelay(value: nil)
    
    // MARK: - init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addSubviews()
        clickedButtons()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    /*
     UI Actions
     */
    
    /// Add UI
    private func addSubviews(){
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = .black
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleImg)
        contentView.addSubview(interestingCollectionView)
        interestingCollectionView.dataSource = self
        interestingCollectionView.delegate = self
        interestingCollectionView.register(InterestingCollectionViewCell.self, forCellWithReuseIdentifier: InterestingCollectionViewCell.identifier)
        
        contentView.addSubview(isRecruitingButton)
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
        
        setRightBarButtons()
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
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(titleImg.snp.width).multipliedBy(0.9/1.6)
        }
        
        /// 관심 분야
        interestingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleImg.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(isRecruitingButton.snp.leading)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/25)
        }
        
        isRecruitingButton.snp.makeConstraints { make in
            make.top.equalTo(interestingCollectionView.snp.top)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(interestingCollectionView.snp.bottom)
            viewModel.recruitingConstraint.accept(make.width.equalTo(1).constraint)
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
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        meetingIntroductionRoundUIView.snp.makeConstraints { make in
            make.top.equalTo(meetingLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            viewModel.meetingIntroductionUIViewConstraint.accept(make.height.equalTo(0).constraint)
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
    
    /// MARK: 네비게이션 바 오른쪽 버튼들
    private func setRightBarButtons(){
        let firstBarButton = UIBarButtonItem(customView: firstButton)
        let secondBarButton = UIBarButtonItem(customView: secondButton)
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0)
        
        firstButton.configuration = configuration
        secondButton.configuration = configuration
        
        navigationItem.rightBarButtonItems = [secondBarButton, firstBarButton]
    }
    
    /// MARK: 모임 주인이 아닌 사람 버튼 클릭 함수
    private func clickedButtons(){
        
        likeBtn.rx.tap
            .subscribe(onNext:{ [weak self] in
                guard let self = self else { return }
                if viewModel.checkOwner.value {
                    print("clicked owner like Button")
                }
                else {
                    print("clicked like Button")
                }
            })
            .disposed(by: disposeBag)
        
        joinBtn.rx.tap
            .subscribe(onNext:{ [weak self] in
                guard let self = self else { return }
                if viewModel.checkOwner.value {
                    print("clicked owner join Button")
                }
                else {
                    print("clicked join Button")
                    let detailMeetingJoinPopUpViewController = DetailMeetingJoinPopUpViewController()
                    detailMeetingJoinPopUpViewController.meetingIdRelay.accept(self.meetingIdRelay.value)
                    detailMeetingJoinPopUpViewController.clicekdButtonSubject
                        .bind { [weak self] in
                            if $0{
                                self?.navigationController?.popToRootViewController(animated: true)
                            }
                        }
                        .disposed(by: disposeBag)
                    present(detailMeetingJoinPopUpViewController, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        firstButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                if viewModel.checkOwner.value {
                    print("owner: 수정하기 ")
                }
                else {
                    let reportViewController = ReportViewController()
                    reportViewController.meetingId.accept(viewModel.meetingInfo.value?.id ?? 0)
                    present(reportViewController, animated: false)
                }
            }
            .disposed(by: disposeBag)
        
        secondButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                if viewModel.checkOwner.value {
                    print("owner1: 수정하기 ")
                }
                else {
                    print("not2 owner")
                }
            }
            .disposed(by: disposeBag)
        
        
    }
    
    /// MARK: 테스트용 더미 데이터
    private func getData(){
        
        viewModel.getData(meetingIntroduction: meetingIntroduction, id: meetingIdRelay.value ?? 0)
        
        viewModel.meetingInfo
            .subscribe(onNext: { [weak self] data in
                guard let self = self else { return }
                if let url = URL(string: data?.imageFilePath ?? ""){
                    titleImg.load(url: url)
                }
                memberContentLabel.text = "\(data?.memberCount ?? 0)"
                ageContentLabel.text = data?.preferAges ?? ""
                languageContentLabel.text = data?.language ?? ""
                placeContentLabel.text = data?.location ?? ""
                joinMemberNumberLabel.text = "\(String(describing: data?.users?.count ?? 0))/\(data?.memberCount ?? 0)"
                isCheckRecruiting(isRecruiting: data?.isRecruiting ?? false)
                interestingCollectionView.reloadData()
                ruleCollectionView.reloadData()
                joinMemberCollectionView.reloadData()
                setLayoutAfterGetData(data: data)
            })
            .disposed(by: disposeBag)
        
        
    }
    
    /// MARK: 모집중인지 확인
    private func isCheckRecruiting(isRecruiting: Bool){
        
        if isRecruiting {
            isRecruitingButton.setTitle("모집 중", for: .normal)
            isRecruitingButton.setTitleColor(BackgroundColor.white.color, for: .normal)
            isRecruitingButton.backgroundColor = ButtonColor.main.color
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let newSize = ((isRecruitingButton.titleLabel?.text ?? "") as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
            viewModel.recruitingConstraint.value?.update(offset: newSize.width+20)
        }
        else {
            isRecruitingButton.setTitle("모집 마감", for: .normal)
            isRecruitingButton.setTitleColor(BackgroundColor.white.color, for: .normal)
            isRecruitingButton.backgroundColor = ButtonColor.main.color
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let newSize = ((isRecruitingButton.titleLabel?.text ?? "") as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
            viewModel.recruitingConstraint.value?.update(offset: newSize.width+20)
        }
        
    }
    
    /// MARK: API 통신후 변화해야하는 UI
    private func setLayoutAfterGetData(data: Meeting?){
        let userId = Int(UserDefaults.standard.string(forKey: "UserId") ?? "")
        if (data?.ownerId ?? 0) == userId {
            likeBtn.setTitle("마감하기", for: .normal)
            joinBtn.setTitle("???", for: .normal)
            firstButton.setImage(UIImage(systemName: "pencil"), for: .normal)
            viewModel.checkOwner.accept(true)
        }else{
            viewModel.checkOwner.accept(false)
        }
        
    }
    
}

extension DetailMeetingHomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == interestingCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestingCollectionViewCell.identifier, for: indexPath) as? InterestingCollectionViewCell else {return UICollectionViewCell() }
            guard let interestingList = viewModel.meetingInfo.value?.interests else { return UICollectionViewCell() }
            
            let data = EnumFile.enumfile.enumList.value
            let text = data.interest?.filter{ $0.key  == interestingList[indexPath.item] }.first
            
            cell.inputData(text: text?.value ?? "")
            cell.backgroundColor =  ButtonColor.main.color
            cell.layer.cornerRadius = 10
            return cell
        }
        else if collectionView == ruleCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RuleCollectionViewCell.identifier, for: indexPath) as? RuleCollectionViewCell else {return UICollectionViewCell() }
            guard let rules = viewModel.meetingInfo.value?.rules else { return UICollectionViewCell() }
            
            let data = EnumFile.enumfile.enumList.value
            let text = data.rule?.filter{ $0.key  == rules[indexPath.item] }.first
            
            cell.inputData(text: text?.value ?? "")
            cell.backgroundColor = BackgroundColor.white.color
            cell.layer.cornerRadius = 15
            
            return cell
        }
        else if collectionView == joinMemberCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JoinMemberCollectionViewCell.identifier, for: indexPath) as? JoinMemberCollectionViewCell else {return UICollectionViewCell() }
            guard let memberList = viewModel.meetingInfo.value?.users else { return UICollectionViewCell() }
            cell.inputData(profileImg: memberList[indexPath.row].profileImageUrl ?? "",
                           name: memberList[indexPath.row].nickname ?? "",
                           nationality: memberList[indexPath.row].country ?? "")
            cell.backgroundColor = .clear
            
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == interestingCollectionView{
            guard let interestingList = viewModel.meetingInfo.value?.interests else { return CGSize()}
            
            let interesting = interestingList[indexPath.row]
            
            let data = EnumFile.enumfile.enumList.value
            let text = data.interest?.filter{ $0.key  == interesting }.first
            
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let newSize = ((text?.value ?? "") as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
            
            return CGSize(width: newSize.width + 10, height: collectionView.bounds.height)
        }
        else if collectionView == ruleCollectionView{
            guard let rule = viewModel.meetingInfo.value?.rules?[indexPath.row] else { return CGSize() }
            
            let data = EnumFile.enumfile.enumList.value
            let text = data.rule?.filter{ $0.key  == rule }.first
            
            let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            let newSize = ((text?.value ?? "") as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])

            return CGSize(width: newSize.width + 20, height: 35)
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
            return viewModel.meetingInfo.value?.interests?.count ?? 0
        }
        else if collectionView == ruleCollectionView{
            return viewModel.meetingInfo.value?.rules?.count ?? 0
        }
        else if collectionView == joinMemberCollectionView{
            return viewModel.meetingInfo.value?.users?.count ?? 0
        }
        else{
            return 0
        }
    }
    
    
    
}


