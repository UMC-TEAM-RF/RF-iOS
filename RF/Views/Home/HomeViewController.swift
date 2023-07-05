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
        scrollView.backgroundColor = .yellow
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
    
    private lazy var friendListCollectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
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
    
    

    // MARK: - Property
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.isHidden = true
        
        addSubviews()
        configureConstraints()
        configureCollectionView()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        // 컨테이너 뷰
        containerView.addSubview(navigationContainerView)
        containerView.addSubview(bannerCollectionView)
        containerView.addSubview(friendListView)
        containerView.addSubview(meetingListView)
        
        // 네비게이션 바
        navigationContainerView.addSubview(navigationLogo)
        navigationContainerView.addSubview(navigationSearchButton)
        
        // 친구 목록
        friendListView.addSubview(friendListLabel)
        friendListView.addSubview(friendListCollectionView)
        
        // 모임
        meetingListView.addSubview(meetingListLabel)
    }
    
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
            
            make.bottom.equalToSuperview() // test용
        }
        
        meetingListLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(20)
            
            make.bottom.equalToSuperview()
        }
        

    }

    private func configureCollectionView() {
        // banner collectionView
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        bannerCollectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCollectionViewCell")
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bannerCollectionView.frame.width, height: bannerCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            print("Banner")
            return 2
        case 1:
            print("모임")
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
            print("모임")
            return UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }
    
    
}
