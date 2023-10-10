//
//  MeetingViewController.swift
//  RF
//
//  Created by 용용이 on 2023/07/27.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class MyPageViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    /// MARK: 프로필 이미지
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "LogoImage")
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        view.layer.cornerRadius = view.bounds.width / 2
        return view
    }()
    
    
    /// MARK: 프로파일 수정 버튼
    private lazy var profileEditButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "pencil")?.resize(newWidth: 14), for: .normal)
        btn.tintColor = TextColor.first.color
        return btn
    }()
    
    
    /// MARK: 이름 레이블
    private lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.text = "KPOP 매니아 | 소융대 🇰🇷"
        label.font = .systemFont(ofSize: 18)
        label.textColor = TextColor.first.color
        return label
    }()
    
    
    /// MARK: 한 줄 소개
    private lazy var introduceLabel: UILabel = {
        let label = UILabel()
        label.text = "행복한 하루를 보내고 싶어요! (한 줄 소개)"
        label.font = .systemFont(ofSize: 12)
        label.textColor = TextColor.secondary.color
        label.textAlignment = .center
        label.layer.borderWidth = 0.5
        label.layer.cornerRadius = 4.5
        label.layer.borderColor = TextColor.secondary.color.cgColor
        return label
    }()

    /// MARK: 알프 온도 Title
    private lazy var scoreTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "알프 점수"
        label.font = .systemFont(ofSize: 14)
        label.textColor = TextColor.first.color
        return label
    }()
    /// MARK: 알프 온도 아이콘
    private lazy var scoreImojiView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "smile")?.resize(newWidth: 20)
        return view
    }()
    /// MARK: 알프 온도 Message
    private lazy var scoreMessageLabel: UILabel = {
        let label = UILabel()
        label.text = scoreMessage
        label.font = .systemFont(ofSize: 12)
        label.textColor = TextColor.first.color
        return label
    }()
    /// MARK: 알프 온도 Message
    private lazy var scoreNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "\(score)점"
        label.font = .systemFont(ofSize: 14)
        label.textColor = TextColor.first.color
        return label
    }()
    /// MARK: 알프 점수 프로그레스 바
    /// 최저 : 0도, 최고 : 100도(maxScore 변수)
    private lazy var scoreProgressBar: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.backgroundColor = UIColor(hexCode: "D1D1D1")
        if score <= 0 {
            pv.progress = 0
        }else{
            pv.progress = Float((score / maxScore))
        }
        pv.layer.cornerRadius = 3
        pv.clipsToBounds = true
        return pv
    }()
    
    private lazy var firstDivLine: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor.init(hexCode: "#DFDFDF")
        return box
    }()
    
    
    
    private let menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.tag = 0
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private lazy var secondDivLine: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor.init(hexCode: "#DFDFDF")
        return box
    }()
    
    private lazy var bottomButtonsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "문의 및 공지"
        label.font = .systemFont(ofSize: 14)
        label.textColor = TextColor.first.color
        return label
    }()
    
    private lazy var customerCenterButton: UIButton = {
        let button = UIButton()
        button.setTitle("고객 센터", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    private lazy var announcementButton: UIButton = {
        let button = UIButton()
        button.setTitle("공지사항", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    private lazy var withdrawButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원 탈퇴", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    private lazy var aboutButton: UIButton = {
        let button = UIButton()
        button.setTitle("현재 버전 12.7.1", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    
    private var scoreMessageList = ["심성이 따뜻하네요","활동적이고 따뜻함이 느껴져요", "뜨거운 열정과 심성을 가진 알프레드님🔥","모두가 인정한 열정맨! 플러스 친절함까지?"]
    private var score = 37.2
    private let maxScore = 100.0
    private var scoreMessage : String {
        get{
            if(score > 36.5 && score <= 40){
                return scoreMessageList[0]
            }
            else if(score > 40 && score <= 50){
                return scoreMessageList[1]
            }
            else if(score > 50 && score <= 60){
                return scoreMessageList[2]
            }
            else if(score > 60 && score <= 100){
                return scoreMessageList[3]
            }else{
                return "점수가 범위를 벗어났습니다. 관리자에게 문의하세요."
            }
                
        }
    }
//    
//    private var meetingTipMessageList = ["이번 달의 모임 횟수는 미미하네요! 모임을 즐겨 보세요!", "모임을 즐겨하시네요! 알프를 통해 더 많이 활용해보세요 :-)", "모임 매니아시군요! 진정한 인싸는 바로 OO님!"]
//    private let meetingperMonth = 3
//    private var meetingTipMessage : String {
//        get{
//            if(meetingperMonth >= 0 && meetingperMonth < 5){
//                return meetingTipMessageList[0]
//            }else if(meetingperMonth >= 5 && meetingperMonth < 10){
//                return meetingTipMessageList[1]
//            }else{
//                return meetingTipMessageList[2]
//            }
//                
//        }
//    }
    
    let menuList: [String] = ["프로필 관리", "크루 관리", "일정 관리", "친구 관리"]
    let menuDescription: [String] = ["내 프로필을 확인하고 수정할 수 있어요!", "내가 개설한 크루의 목록과 크루 멤버들을 관리해요!", "나의 모임 일정을 한 눈에 확인하러 가요!", "차단한 친구를 관리해요!"]
    
    
    private let viewModel = ScheduleViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        updateTitleView(title: "마이페이지")
        setupCustomBackButton()
        
        getData()
        addSubviews()
        configureConstraints()
        configureCollectionView()
        bind()
        
        //addBarButton
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingButtonTapped))
        let reportButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(settingButtonTapped))
        
        navigationItem.rightBarButtonItems = [settingButton, reportButton]
        
        
        
        
        
//        let service = MeetingService()
//        service.requestRecommandPartyList("Personal") { meetings in
//
//            dump(meetings)
//            self.personalMeetings = meetings!
//
//            if(self.completedRequest == 1){
//                self.completedRequest = 0
//                DispatchQueue.main.async {
//                    self.pageCollectionView.reloadData()
//                }
//            }else{
//                self.completedRequest = 1
//            }
//        }
        
    }
    
    // MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backButtonTitle = ""
        navigationController?.toolbar.isHidden = true
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(profileImageView)
        containerView.addSubview(profileEditButton)
        containerView.addSubview(profileLabel)
        containerView.addSubview(introduceLabel)
        
        
        containerView.addSubview(scoreTitleLabel)
        containerView.addSubview(scoreImojiView)
        containerView.addSubview(scoreMessageLabel)
        containerView.addSubview(scoreNumberLabel)
        containerView.addSubview(scoreProgressBar)
        
        containerView.addSubview(firstDivLine)
        
        
        containerView.addSubview(menuCollectionView)
        
        containerView.addSubview(secondDivLine)
        containerView.addSubview(bottomButtonsTitleLabel)
        containerView.addSubview(customerCenterButton)
        containerView.addSubview(announcementButton)
        containerView.addSubview(withdrawButton)
        containerView.addSubview(aboutButton)
        
    }
    
    
    private func configureConstraints(){
        
        // 스크롤 뷰
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        // 컨테이너 뷰
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
        }
        
        profileEditButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(profileEditButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            
            make.width.equalTo(introduceLabel.intrinsicContentSize.width + 10)
            make.height.equalTo(introduceLabel.intrinsicContentSize.height + 10)

        }
        
        
        scoreTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
        }
        scoreImojiView.snp.makeConstraints { make in
            make.top.equalTo(scoreTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(scoreTitleLabel.snp.leading)
        }
        scoreMessageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(scoreImojiView.snp.centerY)
            make.leading.equalTo(scoreImojiView.snp.trailing).offset(10)
        }
        scoreNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(scoreImojiView.snp.centerY)
            make.trailing.equalToSuperview().inset(30)
        }
        scoreProgressBar.snp.makeConstraints { make in
            make.top.equalTo(scoreMessageLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(6)
        }
        
        firstDivLine.snp.makeConstraints { make in
            make.top.equalTo(scoreProgressBar.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        menuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(firstDivLine.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(400)
        }
        
        
        secondDivLine.snp.makeConstraints { make in
            make.top.equalTo(menuCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        bottomButtonsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(secondDivLine.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        customerCenterButton.snp.makeConstraints { make in
            make.top.equalTo(bottomButtonsTitleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(30)
        }
        
        announcementButton.snp.makeConstraints { make in
            make.top.equalTo(bottomButtonsTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(containerView.snp.centerX).offset(20)
        }
        
        withdrawButton.snp.makeConstraints { make in
            make.top.equalTo(customerCenterButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(20)
        }
        
        aboutButton.snp.makeConstraints { make in
            make.top.equalTo(customerCenterButton.snp.bottom).offset(20)
            make.leading.equalTo(containerView.snp.centerX).offset(20)
        }
        
        
        
        
        
        
    }
    
    private func configureCollectionView() {
        // menu collectionView
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        menuCollectionView.register(menuCollectionViewCell.self, forCellWithReuseIdentifier: menuCollectionViewCell.identifier)
    }
    /// MARK: ViewModel에서 데이터 얻는 함수
    private func getData(){
        viewModel.getData()
        
        if let img = URL(string: SignUpDataViewModel.viewModel.profileImageUrlRelay.value) {
            profileImageView.load(url: img)
            profileImageView.updateConstraints()
        }
        introduceLabel.text = SignUpDataViewModel.viewModel.introduceSelfRelay.value
        profileLabel.text = "\(SignUpDataViewModel.viewModel.nickNameRelay.value) | 소융대 🇰🇷"
    }
    
    private func bind() {
        customerCenterButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(MyPageCustomerCenterViewController(), animated: true)
            })
            .disposed(by: disposeBag)
        
        announcementButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(MyPageAnnouncementViewController(), animated: true)
            })
            .disposed(by: disposeBag)
        
        withdrawButton.rx.tap
            .subscribe(onNext: {
                
                let alertController = UIAlertController(title: "주의", message: "회원 탈퇴 시, 사용자의 채팅 내역, 크루 내역 등 모든 정보는 사라집니다. 탈퇴 후 다시 가입을 원할 시에는 3일이 지나야 합니다. 그래도 회원 탈퇴를 진행하시겠습니까?", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
                    self.withdraw()
                }
                let no = UIAlertAction(title: "취소", style: .cancel) { _ in
                }
                
                alertController.addAction(ok)
                alertController.addAction(no)
                
                self.present(alertController, animated: true)
                
//                self.navigationController?.pushViewController(NotiMessageViewController(), animated: true)
            })
            .disposed(by: disposeBag)
    
        aboutButton.rx.tap
            .subscribe(onNext: {
                
            })
            .disposed(by: disposeBag)
        
    }
    private func withdraw(){
        
        let alertController = UIAlertController(title: "확인", message: "회원 탈퇴 되었습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(SignInViewController())
        }
        
        alertController.addAction(ok)
        
        self.present(alertController, animated: true)
    }
    
    @objc func settingButtonTapped() {
        self.navigationController?.pushViewController(ProfileSettingViewController(), animated: true)
    }
    
    @objc func reportButtonTapped() {
        
    }
    
    private func menuCollectionViewClicked(at: Int){
        
        switch at {
        case 0:
            return
        case 1:
            self.navigationController?.pushViewController(MyPageMeetingManagingViewController(), animated: true)
            return
        case 2:
            self.navigationController?.pushViewController(MyPageMeetingDateViewController(), animated: true)
            return
        case 3:
            self.navigationController?.pushViewController(MyPageBlockUserListViewController(), animated: true)
            return
        default:
            return
        }
    }
    
}


// MARK: - Ext: CollectionView

extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Size for one cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height) / 4 - 10)
        
    }
    
    //number of the cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    //initial setting of the cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCollectionViewCell.identifier, for: indexPath) as! menuCollectionViewCell
        
        cell.varTitleLabel = menuList[indexPath.item]
        cell.varDescriptLabel = menuDescription[indexPath.item]
        
        return cell
    }
    
    //code when the cell is clicked
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let _ = collectionView.cellForItem(at: indexPath) as? menuCollectionViewCell else { return }
        
        //Some code
        self.menuCollectionViewClicked(at: indexPath.item)
    }
    
}
