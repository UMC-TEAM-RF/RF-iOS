//
//  PageCollectionViewCell.swift
//  RF
//
//  Created by 용용이 on 2023/08/20.
//

import UIKit


/**
 TabBar의 각 항목에 딸린 화면을 담당하는 셀이다. 개인모임 화면 셀, 단체모임 화면 셀 등을 관리하는 클래스다.
 > 내부적으로 meetingCollectionView를 포함하고 있으며, 해당 뷰의 셀로 DetailedMeetingCollectionViewCell를 사용하고 있다. DetailedMeetingCollectionViewCell의 셀 높이를 220으로 설정하고 있으며 셀 개수는 3으로 정의하므로 상위 클래스에서 PageCollectionViewCell의 크기를 결정할 때 셀의 크기를 220*3 + 15*2 = 690 이상으로 설정해줘야 한다.
 */
class PageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Property
    
    
    private lazy var meetingCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 15

        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.isScrollEnabled = false
        return cv
    }()
    
    // MARK: - Property
    
    static let identifier = "PageCollectionViewCell"
    
    private var meetingsData : [Meeting]?
    
    // MARK: - init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureConstraints()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        contentView.addSubview(meetingCollectionView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        meetingCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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



extension PageCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: meetingCollectionView.frame.width, height: 220)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    //각 태그(개인 모임:0, 단체 모임:1)마다 보여줄 모임 리스트 데이터소스를 설정한다.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailedMeetingCollectionViewCell.identifier, for: indexPath) as! DetailedMeetingCollectionViewCell
            
            guard let meetings = meetingsData else { return UICollectionViewCell() }
            
            cell.meetingData = meetings[indexPath.item]
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailedMeetingCollectionViewCell.identifier, for: indexPath) as! DetailedMeetingCollectionViewCell
            
            guard let meetings = meetingsData else { return UICollectionViewCell() }
            
            cell.meetingData = meetings[indexPath.item]
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

