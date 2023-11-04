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
    
    private lazy var navigationView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 뒤로가기 버튼
    private lazy var backButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "multiply"), for: .normal)
        view.imageView?.tintColor = .gray
        view.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return view
    }()
    
    // 신고 버튼
    private lazy var reportButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "light.beacon.max"), for: .normal)
        view.imageView?.tintColor = .red
        view.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return view
    }()
    
    // 차단 버튼
    private lazy var blockButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "person.slash"), for: .normal)
        view.imageView?.tintColor = .black
        view.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        return view
    }()
    
    // 프로필 이미지
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "LogoImage")
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        view.layer.cornerRadius = view.bounds.width / 2
        return view
    }()
    
    // 사용자 이름
    private lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.text = "KPOP 매니아 | 소융대 🇰🇷"
        label.font = .systemFont(ofSize: 18)
        label.textColor = TextColor.first.color
        return label
    }()
    
    // 한 줄 소개
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

    // 알프 온도 라벨
    private lazy var scoreTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "알프 온도"
        label.font = .systemFont(ofSize: 14)
        label.textColor = TextColor.first.color
        return label
    }()
    
    // 알프 온도 아이콘
    private lazy var scoreImojiView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "smile")?.resize(newWidth: 20)
        return view
    }()
    
    // 알프 온도 메시지
    private lazy var scoreMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "심성이 따뜻하네요."
        label.font = .systemFont(ofSize: 12)
        label.textColor = TextColor.first.color
        return label
    }()
    
    // 알프 온도 값
    private lazy var scoreNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "36.5도"
        label.font = .systemFont(ofSize: 14)
        label.textColor = TextColor.first.color
        return label
    }()
    
    // 알프 온도 바
    private lazy var scoreProgressBar: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.backgroundColor = UIColor(hexCode: "D1D1D1")
        pv.layer.cornerRadius = 3
        pv.progress = 36.5
        
        pv.clipsToBounds = true
        return pv
    }()
    
    private lazy var divLine: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var majorLabel: UILabel = {
        let view = UILabel()
        view.text = "소속"
        view.font = .systemFont(ofSize: 15)
        view.textColor = .gray
        return view
    }()
    
    private lazy var majorValueLabel: UILabel = {
        let view = UILabel()
        view.text = "소프트웨어융합대학 19학번"
        view.font = .systemFont(ofSize: 15)
        view.textColor = .gray
        view.textAlignment = .center
        return view
    }()
    
    private lazy var interestLabel: UILabel = {
        let view = UILabel()
        view.text = "관심사"
        view.font = .systemFont(ofSize: 15)
        view.textColor = .gray
        return view
    }()
    
    private lazy var interestValueLabel: UILabel = {
        let view = UILabel()
        view.text = "음악, K-POP, 아이돌"
        view.font = .systemFont(ofSize: 15)
        view.textColor = .gray
        view.textAlignment = .center
        return view
    }()
    
    private lazy var mbtiLabel: UILabel = {
        let view = UILabel()
        view.text = "MBTI"
        view.font = .systemFont(ofSize: 15)
        view.textColor = .gray
        return view
    }()
    
    private lazy var mbtiValueLabel: UILabel = {
        let view = UILabel()
        view.text = "ESTJ"
        view.font = .systemFont(ofSize: 15)
        view.textColor = .gray
        view.textAlignment = .center
        return view
    }()
    
    // MARK: - 사용자 평가 (현재 사용 X)
    
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
        view.tag = 0
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var goodImage: UIImageView = {
        let view = UIImageView()
        view.tag = 0
        view.image = UIImage(resource: .good)
        view.contentMode = .scaleAspectFit
        view.tintColor = .lightGray
        return view
    }()
    
    private lazy var badImageView: UIView = {
        let view = UIView()
        view.tag = 1
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var badImage: UIImageView = {
        let view = UIImageView()
        view.tag = 1
        view.image = UIImage(resource: .bad)
        view.contentMode = .scaleAspectFit
        view.tintColor = .lightGray
        return view
    }()
    
    private let viewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCustomBackButton()
        
        addSubviews()
        configureConstraints()
        addTargets()
    }
    
    // MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backButtonTitle = ""
        navigationController?.toolbar.isHidden = true
    }
    
    /// MARK: Add UI
    private func addSubviews(){
        view.addSubview(containerView)
        
        containerView.addSubview(navigationView)
        navigationView.addSubview(backButton)
        navigationView.addSubview(reportButton)
        
        containerView.addSubview(profileImageView)
        containerView.addSubview(profileLabel)
        containerView.addSubview(introduceLabel)
        
        containerView.addSubview(scoreTitleLabel)
        containerView.addSubview(scoreImojiView)
        containerView.addSubview(scoreMessageLabel)
        containerView.addSubview(scoreNumberLabel)
        containerView.addSubview(scoreProgressBar)
        
        containerView.addSubview(divLine)
        
        containerView.addSubview(majorLabel)
        containerView.addSubview(majorValueLabel)
        containerView.addSubview(interestLabel)
        containerView.addSubview(interestValueLabel)
        containerView.addSubview(mbtiLabel)
        containerView.addSubview(mbtiValueLabel)
        
//        containerView.addSubview(goodBadTitle)
//        containerView.addSubview(stackView)
//        stackView.addArrangedSubview(goodImageView)
//        stackView.addArrangedSubview(badImageView)
//        goodImageView.addSubview(goodImage)
//        badImageView.addSubview(badImage)
    }
    
    
    private func configureConstraints(){
        
        
        // 컨테이너 뷰
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        
        // 네비게이션 뷰
        navigationView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.horizontalEdges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        reportButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
        
        // 프로필 이미지
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(20)
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
        
        divLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(scoreProgressBar.snp.bottom).offset(25)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        
        majorLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).inset(50)
            make.width.equalTo(50)
            make.top.equalTo(divLine.snp.bottom).offset(25)
        }
        
        majorValueLabel.snp.makeConstraints { make in
            make.leading.equalTo(majorLabel.snp.trailing).offset(60)
            make.trailing.equalToSuperview().inset(50)
            make.top.equalTo(majorLabel.snp.top)
        }
        
        interestLabel.snp.makeConstraints { make in
            make.leading.equalTo(majorLabel.snp.leading)
            make.width.equalTo(50)
            make.top.equalTo(majorLabel.snp.bottom).offset(10)
        }
        
        interestValueLabel.snp.makeConstraints { make in
            make.leading.equalTo(interestLabel.snp.trailing).offset(60)
            make.trailing.equalToSuperview().inset(50)
            make.top.equalTo(interestLabel.snp.top)
        }
        
        mbtiLabel.snp.makeConstraints { make in
            make.leading.equalTo(interestLabel.snp.leading)
            make.width.equalTo(50)
            make.top.equalTo(interestLabel.snp.bottom).offset(10)
        }
        
        mbtiValueLabel.snp.makeConstraints { make in
            make.leading.equalTo(mbtiLabel.snp.trailing).offset(60)
            make.trailing.equalToSuperview().inset(50)
            make.top.equalTo(mbtiLabel.snp.top)
        }
        
//        // 좋아요 싫어요
//        goodBadTitle.snp.makeConstraints { make in
//            make.top.equalTo(scoreProgressBar.snp.bottom).offset(10)
//            make.horizontalEdges.equalToSuperview().inset(20)
//        }
//        
//        stackView.snp.makeConstraints { make in
//            make.top.equalTo(goodBadTitle.snp.bottom).offset(20)
//            make.horizontalEdges.equalToSuperview().inset(50)
//        }
//        
//        goodImage.snp.makeConstraints { make in
//            make.horizontalEdges.equalToSuperview().inset(50)
//            make.verticalEdges.equalToSuperview().inset(10)
//            make.height.equalTo(goodImage.snp.width)
//        }
//        
//        badImage.snp.makeConstraints { make in
//            make.horizontalEdges.equalToSuperview().inset(50)
//            make.verticalEdges.equalToSuperview().inset(10)
//            make.height.equalTo(badImage.snp.width)
//        }
    }
    
    private func addTargets() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        reportButton.addTarget(self, action: #selector(reportButtonTapped), for: .touchUpInside)
        
        goodImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(estimateButtonTapped(_:))))
        badImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(estimateButtonTapped(_:))))
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func reportButtonTapped() {
        let alert = UIAlertController(title: "모임 신고하기", message: "모임을 신고하시겠습니까?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "신고하기", style: .destructive) { _ in
            let alertVC = UIAlertController(title: "신고 접수", message: "신고 접수가 완료되었습니다.", preferredStyle: .alert)
            let done = UIAlertAction(title: "확인", style: .default)
            alertVC.addAction(done)
            self.present(alertVC, animated: true)
        }
        let cancel = UIAlertAction(title: "취소하기", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    @objc func estimateButtonTapped(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            switch view.tag {
            case 0:
                print("0")
            case 1:
                print("1")
            default:
                return
            }
        }
        
    }
}
