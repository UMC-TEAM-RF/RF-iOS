//
//  HomeViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/02.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 네비게이션 바
    private lazy var navigationContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var navigationLogo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "rf_logo")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var navigationNotiButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "bell")?.resize(newWidth: 25, newHeight: 25), for: .normal)
        view.contentMode = .scaleAspectFill
        view.tintColor = .black
        return view
    }()
    
    // 배너
    private let bannerCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.tag = 0
        cv.isPagingEnabled = true
        return cv
    }()
    
    private lazy var bannerPageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 3
        pc.currentPage = 0
        pc.backgroundStyle = .minimal
        return pc
    }()
    
    // 모임
    private lazy var meetingListView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    
    private lazy var meetingListLabel: UILabel = {
        let label = UILabel()
        label.text = "다양한 친구들과 대화를 나눠보세요!"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var moreMeetingButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return button
    }()
    
    private lazy var meetingCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 15
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.tag = 1
        cv.isScrollEnabled = false
        return cv
    }()
    
    // 꿀팁 배너
    private lazy var tipsView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var tipsImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "tips_icon")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var tipsLabelStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 5
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
    }()
    
    private lazy var tipsTopLabel: UILabel = {
        let label = UILabel()
        label.text = "외국인 친구들과 편하게 얘기하고 싶어?"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var tipsBottomLabel: UILabel = {
        let label = UILabel()
        label.text = "꿀팁 얻으러 가기!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    // 관심사
    private lazy var interestView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var interestLabel: UILabel = {
        let label = UILabel()
        label.text = "관심사 더보기"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var interestCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.tag = 2
        cv.isScrollEnabled = false
        cv.layer.cornerRadius = 10
        cv.backgroundColor = .lightGray
        cv.layer.borderColor = UIColor.lightGray.cgColor
        cv.layer.borderWidth = 1
        return cv
    }()
    

    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    
    private var currentPageIndex = 0
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.isHidden = true
        
        addSubviews()
        configureConstraints()
        configureCollectionView()
     
        bind()
        setAutomaticPaging()
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        // 컨테이너 뷰
        containerView.addSubview(navigationContainerView)
        containerView.addSubview(bannerCollectionView)
        containerView.addSubview(bannerPageControl)
        containerView.addSubview(meetingListView)
        containerView.addSubview(tipsView)
        containerView.addSubview(interestView)
        
        
        // 네비게이션 바
        navigationContainerView.addSubview(navigationLogo)
        navigationContainerView.addSubview(navigationNotiButton)
        
        // 모임
        meetingListView.addSubview(meetingListLabel)
        meetingListView.addSubview(moreMeetingButton)
        meetingListView.addSubview(meetingCollectionView)
        
        // 꿀팁
        tipsView.addSubview(tipsImage)
        tipsView.addSubview(tipsLabelStackView)
        tipsLabelStackView.addArrangedSubview(tipsTopLabel)
        tipsLabelStackView.addArrangedSubview(tipsBottomLabel)
        
        // 관심사
        interestView.addSubview(interestLabel)
        interestView.addSubview(interestCollectionView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        // 네비게이션 바
        navigationContainerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            //make.width.equalToSuperview()
            make.height.equalTo(60)
        }
        
        navigationLogo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(12)
        }
        
        navigationNotiButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(15)
            make.width.equalTo(navigationNotiButton.snp.height).multipliedBy(1)
        }
        
        // 배너
        bannerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationContainerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            //make.width.equalToSuperview()
            make.height.equalTo(200)
        }
        
        bannerPageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(bannerCollectionView.snp.bottom).offset(-10)
        }
        
        // 모임
        meetingListView.snp.makeConstraints { make in
            make.top.equalTo(bannerCollectionView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
        }
        
        meetingListLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        moreMeetingButton.snp.makeConstraints { make in
            make.centerY.equalTo(meetingListLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(20)
        }
        
        meetingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(meetingListLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            
            make.bottom.equalToSuperview()
            
            make.height.equalTo(700)    // 모임 3개 고정 (2개 275, 3개 420) 220*3+40
        }
        
        // 꿀팁
        tipsView.snp.makeConstraints { make in
            make.top.equalTo(meetingListView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(75)
        }
        
        tipsImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(tipsImage.snp.height).multipliedBy(1)
        }
        
        tipsLabelStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(tipsImage.snp.trailing).offset(10)
        }
        
        // 관심사
        interestView.snp.makeConstraints { make in
            make.top.equalTo(tipsView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            
            make.height.equalTo(250)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        interestLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        interestCollectionView.snp.makeConstraints { make in
            make.top.equalTo(interestLabel.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - configureCollectionView()

    private func configureCollectionView() {
        // banner collectionView
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        bannerCollectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        
        // 모임
        meetingCollectionView.delegate = self
        meetingCollectionView.dataSource = self
        
        meetingCollectionView.register(DetailedMeetingCollectionViewCell.self, forCellWithReuseIdentifier: DetailedMeetingCollectionViewCell.identifier)
        
        // 관심사
        interestCollectionView.delegate = self
        interestCollectionView.dataSource = self
        
        interestCollectionView.register(InterestCollectionViewCell.self, forCellWithReuseIdentifier: InterestCollectionViewCell.identifier)
    }
    
    private func bind() {
        navigationNotiButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(NotiMessageViewController(), animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - setAutomaticPaging()
    
    // 상단 배너 자동 스크롤
    private func setAutomaticPaging() {
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    // MARK: - @objc func
    
    @objc func moveToNextIndex() {
        currentPageIndex += 1
        
        if currentPageIndex == 3 { currentPageIndex = 0 }
        bannerPageControl.currentPage = currentPageIndex
        
        bannerCollectionView.scrollToItem(at: IndexPath(item: currentPageIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
}

// MARK: - Ext: CollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: bannerCollectionView.frame.width, height: bannerCollectionView.frame.height)
        case 1:
            return CGSize(width: meetingCollectionView.frame.width, height: 220)
        case 2:
            return CGSize(width: (interestCollectionView.frame.width - 2) / 3, height: (interestCollectionView.frame.height - 2) / 4)
        default:
            return CGSize()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return 3
        case 1:
            return 3
        case 2:
            return Interest.listWithIcon.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
            cell.setBannerImage(UIImage(named: "banner"))
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailedMeetingCollectionViewCell", for: indexPath) as! DetailedMeetingCollectionViewCell
            cell.inputTextData(title: HomeMeetingDummy.title[indexPath.row],
                               description: HomeMeetingDummy.description[indexPath.row],
                               personnel: HomeMeetingDummy.personnel[indexPath.row],
                               tag: HomeMeetingDummy.tagList[indexPath.row],
                               imageName: HomeMeetingDummy.images[indexPath.row])
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCollectionViewCell", for: indexPath) as! InterestCollectionViewCell
            cell.setTextLabel(Interest.listWithIcon[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
