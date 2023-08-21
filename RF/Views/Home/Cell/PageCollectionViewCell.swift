//
//  PageCollectionViewCell.swift
//  RF
//
//  Created by 용용이 on 2023/08/20.
//

import UIKit


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
    
    func setTag(_ tagNumber : Int) {
        self.meetingCollectionView.tag = tagNumber
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailedMeetingCollectionViewCell.identifier, for: indexPath) as! DetailedMeetingCollectionViewCell
            cell.inputTextData(title: HomeMeetingDummy.title[indexPath.row],
                               description: HomeMeetingDummy.description[indexPath.row],
                               personnel: HomeMeetingDummy.personnel[indexPath.row],
                               tag: HomeMeetingDummy.tagList[indexPath.row],
                               imageName: HomeMeetingDummy.images[indexPath.row])
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailedMeetingCollectionViewCell.identifier, for: indexPath) as! DetailedMeetingCollectionViewCell
            cell.inputTextData(title: HomeMeetingDummy.title[indexPath.row],
                               description: HomeMeetingDummy.description[indexPath.row],
                               personnel: HomeMeetingDummy.multiPersonnel[indexPath.row],
                               tag: HomeMeetingDummy.tagList[indexPath.row],
                               imageName: HomeMeetingDummy.multiImages[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

