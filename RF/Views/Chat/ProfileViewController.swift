//
//  ProfileViewController.swift
//  RF
//
//  Created by 용용이 on 10/27/23.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ProfileViewController: UIViewController {
    
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
    
    
    // 신고 버튼
    private lazy var reportButton: UIButton = {
        let button = UIButton()
        button.setTitle("신고하기", for: .normal)
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = UIColor.init(hexCode: "#F5F5F5")
        button.layer.cornerRadius = 8
        return button
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
    
    /// MARK: Title
    private lazy var goodBadTitle: UILabel = {
        let label = UILabel()
        label.text = "사용자를 평가해주세요!"
        label.font = .systemFont(ofSize: 14)
        label.textColor = TextColor.first.color
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 20
        return view
    }()
    
    private lazy var goodImageView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var goodImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .good)
        view.contentMode = .scaleAspectFit
        view.tintColor = .lightGray
        return view
    }()
    
    private lazy var badImageView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var badImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .bad)
        view.contentMode = .scaleAspectFit
        view.tintColor = .lightGray
        return view
    }()
    
    
    //이거 마이페이지랑 문구 중복되는데 변수로 빼서 저장해봐야 할 것 같아요
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
    
    let menuList: [String] = ["프로필 관리", "크루 관리", "일정 관리", "친구 관리"]
    let menuDescription: [String] = ["내 프로필을 확인하고 수정할 수 있어요!", "내가 개설한 크루의 목록과 크루 멤버들을 관리해요!", "나의 모임 일정을 한 눈에 확인하러 가요!", "차단한 친구를 관리해요!"]
    let goodBadImageName: [String] = ["good","bad"]
    
    
    private let viewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCustomBackButton()
        
        getData()
        addSubviews()
        configureConstraints()
        bind()
        
    }
    
    // MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backButtonTitle = ""
        navigationController?.toolbar.isHidden = true
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        view.addSubview(containerView)
        
        containerView.addSubview(profileImageView)
        containerView.addSubview(profileLabel)
        containerView.addSubview(introduceLabel)
        
        containerView.addSubview(scoreTitleLabel)
        containerView.addSubview(scoreImojiView)
        containerView.addSubview(scoreMessageLabel)
        containerView.addSubview(scoreNumberLabel)
        containerView.addSubview(scoreProgressBar)
        
        containerView.addSubview(goodBadTitle)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(goodImageView)
        stackView.addArrangedSubview(badImageView)
        goodImageView.addSubview(goodImage)
        badImageView.addSubview(badImage)
    }
    
    
    private func configureConstraints(){
        
        
        // 컨테이너 뷰
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        
        // 프로필 이미지
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
        }
        
        // 프로필 라벨
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        // 소개
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(introduceLabel.intrinsicContentSize.height + 10)
        }
        
        // 알프 온도
        scoreTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
        }
        
        // 온도 이모지
        scoreImojiView.snp.makeConstraints { make in
            make.top.equalTo(scoreTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(scoreTitleLabel.snp.leading)
        }
        
        // 온도 메시지
        scoreMessageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(scoreImojiView.snp.centerY)
            make.leading.equalTo(scoreImojiView.snp.trailing).offset(10)
        }
        
        // 온도 숫자
        scoreNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(scoreImojiView.snp.centerY)
            make.trailing.equalToSuperview().inset(30)
        }
        
        // 온도 프로그래스 바
        scoreProgressBar.snp.makeConstraints { make in
            make.top.equalTo(scoreMessageLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(6)
        }
        
        // 좋아요 실어요
        goodBadTitle.snp.makeConstraints { make in
            make.top.equalTo(scoreProgressBar.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(goodBadTitle.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(50)
        }
        
        goodImage.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(50)
            make.verticalEdges.equalToSuperview().inset(10)
            make.height.equalTo(goodImage.snp.width)
        }
        
        badImage.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(50)
            make.verticalEdges.equalToSuperview().inset(10)
            make.height.equalTo(badImage.snp.width)
        }
    }
    
    /// MARK: ViewModel에서 데이터 얻는 함수
    private func getData() {
        viewModel.getData()
        
        if let img = URL(string: viewModel.userRelay.value[0].profileImageUrl ?? "") {
            profileImageView.load(url: img)
        }
        introduceLabel.text = viewModel.userRelay.value[0].introduce
        profileLabel.text = "\(viewModel.userRelay.value[0].nickname ?? "") | 소융대 🇰🇷"
    }
    
    /// MARK: binding ViewModel
    private func bind(){
//        viewModel.goodBadRelay
//            .bind { [weak self] items in
//                self?.updateGoodBadItem(items)
//            }
//            .disposed(by: disposeBag)
//        
//        viewModel.checkSelectedForButtonColor()
//            .subscribe(onNext:{ [weak self] check in
//                if check{
//                    self?.nextButton.setTitleColor(BackgroundColor.white.color, for: .normal)
//                    self?.nextButton.backgroundColor = ButtonColor.main.color
//                }
//                else{
//                    self?.nextButton.setTitleColor(TextColor.first.color, for: .normal)
//                    self?.nextButton.backgroundColor = ButtonColor.normal.color
//                }
//            })
//            .disposed(by: disposeBag)
    }
    
}
