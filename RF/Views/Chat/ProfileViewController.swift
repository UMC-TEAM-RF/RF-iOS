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
    
    //스크롤 기능, 현재 비활성화(아예 안 쓴다면 제거바람)
//    private lazy var scrollView: UIScrollView = {
//        let view = UIScrollView()
//        return view
//    }()
    
    
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
    
    // 좋아요 싫어요 버튼
    private lazy var goodBadCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 5
        flowLayout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.isScrollEnabled = false
        return cv
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
        
        
        updateTitleView(title: "마이페이지")
        setupCustomBackButton()
        
        getData()
        addSubviews()
        configureConstraints()
        configureCollectionView()
        bind()
        
        
            //데이터 가져올 때 쓰는 코드
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
        
//        view.addSubview(scrollView)
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
        containerView.addSubview(goodBadCollectionView)
        
    }
    
    
    private func configureConstraints(){
        
        //스크롤 뷰 사용시 주석 해제할 부분, 현재는 비활성화. 아예 스크롤 기능이 삭제되는게 확실하면 삭제바람
//        // 스크롤 뷰
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide).inset(5)
//        }
//        // 컨테이너 뷰
//        containerView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView.contentLayoutGuide)
//            make.width.equalTo(scrollView.frameLayoutGuide)
//        }
        
        // 컨테이너 뷰
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(5)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(5)
//            make.edges.equalTo(scrollView.contentLayoutGuide)
//            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
        }
        
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
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
        
        goodBadTitle.snp.makeConstraints { make in
            make.top.equalTo(scoreProgressBar.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        
        goodBadCollectionView.snp.makeConstraints { make in
            make.top.equalTo(goodBadTitle.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(140)
        }
        
        
        
        
    }
    
    
    private func configureCollectionView() {
        goodBadCollectionView.delegate = self
        goodBadCollectionView.dataSource = self
        goodBadCollectionView.register(GoodBadCollectionViewCell.self, forCellWithReuseIdentifier: GoodBadCollectionViewCell.identifier)
    }
    
    /// MARK: ViewModel에서 데이터 얻는 함수
    private func getData(){
        viewModel.getData()
        
        if let img = URL(string: viewModel.userRelay.value[0].profileImageUrl ?? "") {
            profileImageView.load(url: img)
            profileImageView.updateConstraints()
        }
        introduceLabel.text = viewModel.userRelay.value[0].introduce
        profileLabel.text = "\(viewModel.userRelay.value[0].nickname ?? "") | 소융대 🇰🇷"
    }
    /// MARK: binding ViewModel
    private func bind(){
        viewModel.goodBadRelay
            .bind { [weak self] items in
                self?.updateGoodBadItem(items)
            }
            .disposed(by: disposeBag)
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
    
    
    // MARK: - Update View
    
    /// MARK:  라이프 스타일 선택 시 업데이트 하는 함수
    private func updateGoodBadItem(_ item: IndexPath){
        for indexPath in goodBadCollectionView.indexPathsForVisibleItems {
            let cell = goodBadCollectionView.cellForItem(at: indexPath) as? GoodBadCollectionViewCell
            if item == indexPath {
                cell?.setColor(tintColor: BackgroundColor.white.color, backgroundColor: ButtonColor.main.color)
            }
            else{
                cell?.setColor(tintColor: TextColor.secondary.color, backgroundColor: BackgroundColor.white.color)
            }
        }
    }
    
}



extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         if collectionView == goodBadCollectionView {
            return CGSize(width: goodBadCollectionView.frame.width / 2 - 10,
                          height: goodBadCollectionView.frame.height)
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == goodBadCollectionView{
            return 2
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == goodBadCollectionView {
            guard let cell = goodBadCollectionView.dequeueReusableCell(withReuseIdentifier: GoodBadCollectionViewCell.identifier, for: indexPath) as? GoodBadCollectionViewCell else {return UICollectionViewCell()}
            
            cell.setImage(self.goodBadImageName[indexPath.item], size : 34)
            cell.contentView.backgroundColor = BackgroundColor.white.color
            cell.setColor(tintColor: TextColor.secondary.color, backgroundColor: BackgroundColor.white.color)
            cell.setCornerRadius()
            return cell
            
        }
        return UICollectionViewCell()
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == goodBadCollectionView{
            viewModel.selectedgoodBadItem(at: indexPath)
        }
    }
}


final class GoodBadCollectionViewCell: UICollectionViewCell {
    static let identifier = "goodBadCollectionViewCell"
    
    // 로고 이미지
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addSubviews() {
        contentView.addSubview(imageView)
    }
    
    private func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    func setImage(_ named: String, size: CGFloat) {
        self.imageView.image = UIImage(named: named)?.resize(newWidth: size)
        layoutIfNeeded()
    }
    
    func setCornerRadius() {
        layoutIfNeeded()
        contentView.layer.cornerRadius = contentView.frame.height / 6
    }
    
    func setColor(tintColor: UIColor, backgroundColor: UIColor) {
        self.imageView.tintColor = tintColor
        self.contentView.backgroundColor = backgroundColor
        layoutIfNeeded()
    }
}
