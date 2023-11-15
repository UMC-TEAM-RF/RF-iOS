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
    private lazy var scoreNumberLabel: UILabel = {
        let label = UILabel()
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
    
    private lazy var bottomStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 30
        return view
    }()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.borderColor = StrokeColor.main.color.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var withdrawButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원탈퇴", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.borderColor = StrokeColor.main.color.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let viewModel = ScheduleViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        updateTitleView(title: "마이페이지")
        
        getData()
        addSubviews()
        configureConstraints()
        configureCollectionView()
        bind()
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
        containerView.addSubview(scoreNumberLabel)
        containerView.addSubview(scoreProgressBar)
        
        containerView.addSubview(firstDivLine)
        containerView.addSubview(menuCollectionView)
        
        containerView.addSubview(secondDivLine)
        containerView.addSubview(bottomStackView)
        
        bottomStackView.addArrangedSubview(signOutButton)
        bottomStackView.addArrangedSubview(withdrawButton)
        
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
            make.height.equalTo(introduceLabel.intrinsicContentSize.height + 10)

        }
        
        scoreTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
        }
        scoreImojiView.snp.makeConstraints { make in
            make.centerY.equalTo(scoreTitleLabel.snp.centerY)
            make.leading.equalTo(scoreTitleLabel.snp.trailing).offset(3)
        }
        scoreNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(scoreImojiView.snp.centerY)
            make.trailing.equalToSuperview().inset(30)
        }
        scoreProgressBar.snp.makeConstraints { make in
            make.top.equalTo(scoreImojiView.snp.bottom).offset(10)
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
            make.height.equalTo(300)
        }
        
        
        secondDivLine.snp.makeConstraints { make in
            make.top.equalTo(menuCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(secondDivLine.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        signOutButton.snp.makeConstraints { make in
            make.height.equalTo(signOutButton.intrinsicContentSize.height + 10)
        }
        
    }
    
    private func configureCollectionView() {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        menuCollectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
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
        
        scoreProgressBar.progress = 36.5 / 100
        scoreNumberLabel.text = "36.5도"
    }
    
    private func bind() {
        
        signOutButton.rx.tap
            .subscribe(onNext: {
                let alertController = UIAlertController(title: "로그아웃", message: "로그아웃을 하시겠습니까?", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
                    print("Logout")
                }
                let no = UIAlertAction(title: "취소", style: .cancel) { _ in
                }
                
                alertController.addAction(ok)
                alertController.addAction(no)
                
                self.present(alertController, animated: true)
            })
            .disposed(by: disposeBag)
        
        withdrawButton.rx.tap
            .subscribe(onNext: {
                
                let alertController = UIAlertController(title: "회원 탈퇴 시 주의", message: "회원 탈퇴 시, 사용자의 채팅 내역, 크루 내역 등 모든 정보는 사라집니다. 탈퇴 후 다시 가입을 원할 시에는 3일이 지나야 합니다. 그래도 회원 탈퇴를 진행하시겠습니까?", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
                    self.withdraw()
                }
                let no = UIAlertAction(title: "취소", style: .cancel) { _ in
                }
                
                alertController.addAction(ok)
                alertController.addAction(no)
                
                self.present(alertController, animated: true)
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
    
    private func menuCollectionViewClicked(at: Int){
        
        switch at {
        case 0:
            self.navigationController?.pushViewController(MyPageEditingProfileViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(MyPageBlockUserListViewController(), animated: true)
        case 2:
            self.navigationController?.pushViewController(CustomerCenterViewController(), animated: true)
        default:
            return
        }
    }
}


// MARK: - Ext: CollectionView

extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Size for one cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: (collectionView.frame.height) / 3 - 10)
        
    }
    
    //number of the cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MyPageMenu.list.count
    }
    
    //initial setting of the cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
        
        let menu = MyPageMenu.list[indexPath.item]
        cell.updateLabel(menu)
        
        return cell
    }
    
    //code when the cell is clicked
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let _ = collectionView.cellForItem(at: indexPath) as? MenuCollectionViewCell else { return }
        
        //Some code
        self.menuCollectionViewClicked(at: indexPath.item)
    }
    
}
