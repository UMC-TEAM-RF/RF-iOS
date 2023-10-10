//
//  MyPageMeetingManagingViewController.swift
//  RF
//
//  Created by 용용이 on 2023/10/10.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class MyPageMeetingManagingViewController: UIViewController {
    // MARK: - UI Property
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var meetingCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 15

        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.isScrollEnabled = false
        return cv
    }()
    
    // MARK: - Property
    
    weak var delegate: SendDataDelegate?
    private let disposeBag = DisposeBag()
    
    private var meetingsData : [Meeting]?
    
    // MARK: - init()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        updateTitleView(title: "크루 관리")
        
        addSubviews()
        configureConstraints()
        configureCollectionView()
        
        
        
        
        let service = MeetingService()
        service.getMyMeetingList(page: 0, size: 10)
            .bind { meetings in
            
                dump(meetings)
                self.meetingsData = meetings
                
                DispatchQueue.main.async {
                    self.meetingCollectionView.reloadData()
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(meetingCollectionView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        
        // 스크롤 뷰
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        // 컨테이너 뷰
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        meetingCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
            make.height.equalTo(2335) // 220 * 10 + 15 * 9
        }
    }
    
    /**
     어느 탭의 셀인지 저장하는 함수. 탭이 2개 있으므로 셀도 2개, 그리고 meetingCollectionView도 2개이기 때문에 각 meetingCollectionView이 어느 탭에 소속되어 있는지를 알기 위해 tag를 설정하는 함수이다.
     > 셀 초기화할 때 사용
         
         //다음과 같이 셀 초기화할때 사용한다.
         cell.setTag(indexPath.item)
     - Parameters:
        - tagNumber : 어느 탭에 소속되었는지 알 수 있는 변수 (indexPath.item)
    */
    func setTag(_ tagNumber : Int) {
        self.meetingCollectionView.tag = tagNumber
    }
    
    func setData(_ meetingsData : [Meeting]){
        self.meetingsData = meetingsData
        meetingCollectionView.reloadData()
    }
    
    /**
     CollectionView 초기화 함수
    */
    private func configureCollectionView() {
        
        // 모임
        meetingCollectionView.delegate = self
        meetingCollectionView.dataSource = self

        meetingCollectionView.register(DetailedMeetingCollectionViewCell.self, forCellWithReuseIdentifier: DetailedMeetingCollectionViewCell.identifier)
    }
}



extension MyPageMeetingManagingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: meetingCollectionView.frame.width, height: 220)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meetingsData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailedMeetingCollectionViewCell.identifier, for: indexPath) as! DetailedMeetingCollectionViewCell
        
        guard let meetings = meetingsData else { return UICollectionViewCell() }
        
        cell.meetingData = meetings[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        delegate?.sendMeetingData?(tag: meetingCollectionView.tag, index: indexPath.row)
    }
    
}

