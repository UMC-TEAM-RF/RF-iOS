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
    
    // MARK: 네비게이션 바
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
        view.tintColor = TextColor.first.color
        return view
    }()
    
    // MARK: 배너
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
    
    
    // MARK: 모임
    
    private lazy var meetingListView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    
    private lazy var meetingListLabel: UILabel = {
        let label = UILabel()
        label.text = "다양한 친구들과 대화를 나눠보세요!"
        //label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.font = UIFont(name: Font.bold, size: 18)
        label.textColor = TextColor.first.color
        return label
    }()
    
    private lazy var moreMeetingButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(TextColor.secondary.color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return button
    }()
    
    private let tabBarTitles = ["개인 모임", "단체 모임"]
    private let tabBarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.tag = 3
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    private let pageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.tag = 4
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()

    private let highlightBackView: UIView = {
        let view = UIView()
        view.backgroundColor = StrokeColor.main.color
        return view
    }()
    private let highlightView: UIView = {
        let view = UIView()
        view.backgroundColor = ButtonColor.main.color
        return view
    }()
    
    
    // MARK: 꿀팁 배너
    private lazy var tipsView: UIView = {
        let view = UIView()
        view.backgroundColor = ButtonColor.normal.color
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
        label.textColor = TextColor.first.color
        return label
    }()
    
    private lazy var tipsBottomLabel: UILabel = {
        let label = UILabel()
        label.text = "꿀팁 얻으러 가기!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = TextColor.secondary.color
        return label
    }()
    
    // MARK: 관심사
    private lazy var interestView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var interestLabel: UILabel = {
        let label = UILabel()
        label.text = "관심사 더보기"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = TextColor.first.color
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
        cv.backgroundColor = StrokeColor.main.color
        cv.layer.borderColor = StrokeColor.main.color.cgColor
        cv.layer.borderWidth = 1
        return cv
    }()
    
    

    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    
    private var currentPageIndex = 0
    
    private var personalMeetings : [Meeting] = []
    private var groupMeetings: [Meeting] = []
    private var completedRequest = 0
    
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
        
        requestMeetingList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(navigationContainerView)
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        // 컨테이너 뷰
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
        meetingListView.addSubview(tabBarCollectionView)
        meetingListView.addSubview(pageCollectionView)
        meetingListView.addSubview(highlightBackView)
        meetingListView.addSubview(highlightView)
        
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
        
        // 네비게이션 바
        navigationContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
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
        
        // 스크롤 뷰
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationContainerView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        // 배너
        bannerCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            //make.width.equalToSuperview()
            make.height.equalTo(bannerCollectionView.snp.width).multipliedBy(0.9/1.6)
        }
        
        bannerPageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(bannerCollectionView.snp.bottom).offset(-10)
        }
        
        // 모임
        meetingListView.snp.makeConstraints { make in
            make.top.equalTo(bannerCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        
        tabBarCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(30)
        }
        
        highlightBackView.snp.makeConstraints { make in
            make.top.equalTo(tabBarCollectionView.snp.bottom).offset(0)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(3)
        }
        
        highlightView.snp.makeConstraints { make in
            make.top.equalTo(tabBarCollectionView.snp.bottom).offset(0)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0)
        }
        
        meetingListLabel.snp.makeConstraints { make in
            make.top.equalTo(tabBarCollectionView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
        }
        
        moreMeetingButton.snp.makeConstraints { make in
            make.centerY.equalTo(meetingListLabel.snp.centerY)
            make.trailing.equalToSuperview()
        }
        
        pageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(meetingListLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(700)    // 모임 3개 고정 (2개 275, 3개 420) 220*3+40
            make.bottom.equalToSuperview()
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
        
        // 관심사
        interestCollectionView.delegate = self
        interestCollectionView.dataSource = self
        
        interestCollectionView.register(InterestCollectionViewCell.self, forCellWithReuseIdentifier: InterestCollectionViewCell.identifier)
        
        //tabBar
        tabBarCollectionView.delegate = self
        tabBarCollectionView.dataSource = self
        
        tabBarCollectionView.register(TabBarCollectionViewCell.self, forCellWithReuseIdentifier: TabBarCollectionViewCell.identifier)
        let firstIndex = IndexPath(item: 0, section: 0)
        tabBarCollectionView.selectItem(at: firstIndex, animated: false, scrollPosition: .right)
        
        //pageCollectionView
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        
        pageCollectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: PageCollectionViewCell.identifier)
        pageCollectionView.selectItem(at: firstIndex, animated: false, scrollPosition: .right)
    }
    
    private func bind() {
        navigationNotiButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(NotiMessageViewController(), animated: true)
            })
            .disposed(by: disposeBag)
        
        moreMeetingButton.rx.tap
            .subscribe(onNext: {
                NotificationCenter.default.post(name: NotificationName.updateSelectedIndex, object: nil)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - setAutomaticPaging()
    
    // 상단 배너 자동 스크롤
    private func setAutomaticPaging() {
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    /// 모임 리스트 불러오기(추천)
    private func requestMeetingList() {
        MeetingService.shared.requestRecommandPartyList("Personal") { meetings in
            self.personalMeetings = meetings!
            
            if(self.completedRequest == 1){
                self.completedRequest = 0
                DispatchQueue.main.async {
                    self.pageCollectionView.reloadData()
                }
            }else{
                self.completedRequest = 1
            }
        }
        MeetingService.shared.requestRecommandPartyList("Group") { meetings in
            self.groupMeetings = meetings!
            
            if(self.completedRequest == 1){
                self.completedRequest = 0
                DispatchQueue.main.async {
                    self.pageCollectionView.reloadData()
                }
            }else{
                self.completedRequest = 1
            }
        }
    }
    
    // MARK: - @objc func
    
    @objc func moveToNextIndex() {
        currentPageIndex += 1
        
        if currentPageIndex == 3 { currentPageIndex = 0 }
        bannerPageControl.currentPage = currentPageIndex
        
        bannerCollectionView.scrollToItem(at: IndexPath(item: currentPageIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
}

//collection tag
// 0 : bannerCollectionView
// 2 : interestCollectionView
// 3 : tapBarCollectionView
// 4 : pageCollectionView


// MARK: - Ext: CollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: bannerCollectionView.frame.width, height: bannerCollectionView.frame.height)
        case 2:
            return CGSize(width: (interestCollectionView.frame.width - 2) / 3, height: (interestCollectionView.frame.height - 2) / 4)
        case 3:
            return CGSize(width: (tabBarCollectionView.frame.width) / 2, height: (tabBarCollectionView.frame.height))
        case 4:
            return CGSize(width: pageCollectionView.frame.width, height: pageCollectionView.frame.height)
        default:
            return CGSize()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return 3
        case 2:
            return Interest.listWithIcon.count
        case 3:
            return 2
        case 4:
            return 2
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
            cell.setBannerImage(UIImage(named: "banner"))
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestCollectionViewCell.identifier, for: indexPath) as! InterestCollectionViewCell
            
            cell.setTextLabel(Interest.listWithIcon[indexPath.item])
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarCollectionViewCell.identifier, for: indexPath) as! TabBarCollectionViewCell
            
            cell.setTextLabel(tabBarTitles[indexPath.item])
            return cell
        case 4:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCollectionViewCell.identifier, for: indexPath) as! PageCollectionViewCell
            cell.delegate = self
            cell.setTag(indexPath.item)
            if(indexPath.item == 0){ // 첫 번째 셀은 개인 모임
                cell.setData(personalMeetings)
            }else if(indexPath.item == 1){// 두 번째 셀은 단체 모임
                cell.setData(groupMeetings)
            }
            
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        switch collectionView.tag {
        case 3:
            //set underline bar
            if(indexPath.item == 0){
                self.highlightView.snp.remakeConstraints { (make) -> Void in
                    make.top.equalTo(tabBarCollectionView.snp.bottom).offset(0)
                    make.horizontalEdges.equalTo(cell.snp.horizontalEdges)
                    make.height.equalTo(3)
                }
                self.view.layoutIfNeeded()
            }
        default:
            return
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 3:
            guard let cell = tabBarCollectionView.cellForItem(at: indexPath) as? TabBarCollectionViewCell else { return }

            self.highlightView.snp.remakeConstraints { (make) -> Void in
                make.top.equalTo(tabBarCollectionView.snp.bottom).offset(0)
                make.horizontalEdges.equalTo(cell.snp.horizontalEdges)
                make.height.equalTo(3)
            }
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.view.layoutIfNeeded()
            })
            pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        default:
            return
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = self.pageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        if scrollView == pageCollectionView {
            let cellWidthIncludingSpacing = pageCollectionView.frame.width + layout.minimumLineSpacing
            let offset = targetContentOffset.pointee
            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
            let roundedIndex = round(index)
            let indexPath = IndexPath(item: Int(roundedIndex), section: 0)
            
            targetContentOffset.pointee = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left,
                                                  y: scrollView.contentInset.top)
            // topTapItem Select
            tabBarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
            // collectionView didSelectedItemAt delegate
            collectionView(tabBarCollectionView, didSelectItemAt: indexPath)
            // topTapMenu Scroll
            tabBarCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }
}

extension HomeViewController: SendDataDelegate {
    func sendMeetingData(tag: Int, index: Int) {
        let meetings = (tag == 0 ? self.personalMeetings : self.groupMeetings)
        let meeting = meetings[index]
        
        let vc = DetailMeetingHomeController()
        vc.meetingIdRelay.accept(meeting.id)
        navigationItem.backButtonTitle = " "
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
