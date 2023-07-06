//
//  HomeViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/02.
//

import UIKit
import SnapKit

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
        view.image = UIImage(systemName: "person")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var navigationSearchButton: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "magnifyingglass")
        view.contentMode = .scaleAspectFill
        view.tintColor = .black
        return view
    }()
    
    // 배너
    private let bannerCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.tag = 0
        return cv
    }()
    
    // 친구 목록
    private lazy var friendListView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var friendListLabel: UILabel = {
        let label = UILabel()
        label.text = "알프님과 같은 취향을 가진 친구 목록이에요!"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var friendListCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 5
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        cv.tag = 1
        return cv
    }()
    
    // 모임
    private lazy var meetingListView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var meetingListLabel: UILabel = {
        let label = UILabel()
        label.text = "놓치기 아쉬운 모임들"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var meetingCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 15
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.tag = 2
        cv.isScrollEnabled = false
        return cv
    }()
    
    // 꿀팁 배너
    private lazy var tipsView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    // 관심사
    

    // MARK: - Property
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.isHidden = true
        
        addSubviews()
        configureConstraints()
        configureCollectionView()
     
        
    }
    
    // MARK: - addSubviews
    
    private func addSubviews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        // 컨테이너 뷰
        containerView.addSubview(navigationContainerView)
        containerView.addSubview(bannerCollectionView)
        containerView.addSubview(friendListView)
        containerView.addSubview(meetingListView)
        containerView.addSubview(tipsView)
        
        // 네비게이션 바
        navigationContainerView.addSubview(navigationLogo)
        navigationContainerView.addSubview(navigationSearchButton)
        
        // 친구 목록
        friendListView.addSubview(friendListLabel)
        friendListView.addSubview(friendListCollectionView)
        
        // 모임
        meetingListView.addSubview(meetingListLabel)
        meetingListView.addSubview(meetingCollectionView)
    }
    
    // MARK: - configureConstraints
    
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
            make.top.left.right.equalToSuperview()
            //make.width.equalToSuperview()
            make.height.equalTo(60)
        }
        
        navigationLogo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(12)
        }
        
        navigationSearchButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(18)
        }
        
        // 배너
        bannerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationContainerView.snp.bottom)
            make.left.right.equalToSuperview()
            //make.width.equalToSuperview()
            make.height.equalTo(200)
        }
        
        // 친구 목록
        friendListView.snp.makeConstraints { make in
            make.top.equalTo(bannerCollectionView.snp.bottom).offset(40)
            make.left.right.equalToSuperview()
            //make.width.equalToSuperview()
            make.height.equalTo(185)
        }
        
        friendListLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
        
        friendListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(friendListLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // 모임
        meetingListView.snp.makeConstraints { make in
            make.top.equalTo(friendListView.snp.bottom).offset(40)
            make.left.right.equalToSuperview()
        }
        
        meetingListLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
        
        meetingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(meetingListLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(20)
            
            make.bottom.equalToSuperview()
            
            make.height.equalTo(275)    // 모임 2개 고정
        }
        
        tipsView.snp.makeConstraints { make in
            make.top.equalTo(meetingListView.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(75)
            make.bottom.equalToSuperview().offset(-40) // test용
        }
    }

    private func configureCollectionView() {
        // banner collectionView
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        bannerCollectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCollectionViewCell")
        
        // 친구 목록
        friendListCollectionView.delegate = self
        friendListCollectionView.dataSource = self
        
        friendListCollectionView.register(FriendListCollectionViewCell.self, forCellWithReuseIdentifier: "FriendListCollectionViewCell")
        
        // 모임
        meetingCollectionView.delegate = self
        meetingCollectionView.dataSource = self
        
        meetingCollectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCollectionViewCell")
    }
}

// MARK: - Extension

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: bannerCollectionView.frame.width, height: bannerCollectionView.frame.height)
        case 1:
            return CGSize(width: friendListCollectionView.frame.height * 0.8, height: friendListCollectionView.frame.height)
        case 2:
            return CGSize(width: meetingCollectionView.frame.width, height: 130)
        default:
            return CGSize()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return 2
        case 1:
            return 4
        case 2:
            return 3
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendListCollectionViewCell", for: indexPath) as! FriendListCollectionViewCell
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
            cell.backgroundColor = .yellow
            return cell
        default:
            return UICollectionViewCell()
        }
    }

    
}

