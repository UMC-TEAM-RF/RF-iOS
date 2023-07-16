//
//  FilteringViewController.swift
//  RF
//
//  Created by 정호진 on 2023/07/16.
//


import Foundation
import SnapKit
import UIKit
import RxCocoa
import RxSwift

/// MARK: 모임 찾기 필터링 화면
final class FilteringViewController: UIViewController{
    
    /// MARK: 화면 내리는 버튼, 가장 맨위에 았는 버튼
    private lazy var topBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hexCode: "F5F5F5")
        btn.setTitle(MeetingFiltering.topButton, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setImage(UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.semanticContentAttribute = .forceRightToLeft
        return btn
    }()
    
    /// MARK: 모집 중인 모임만 보기
    private lazy var lookOnce: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hexCode: "F5F5F5")
        btn.setTitle(MeetingFiltering.lookOnce, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    /// MARK: 모집 연령대 제목
    private lazy var ageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = MeetingFiltering.ageTitle
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    /// MARK: 연령대 선택하는 CollectionView
    private lazy var ageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        return cv
    }()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
    }
    
    /// MARK: add UI
    private func addSubviews(){
        view.addSubview(topBtn)
        view.addSubview(lookOnce)
        view.addSubview(ageTitleLabel)
        view.addSubview(ageCollectionView)
        
        ageCollectionView.delegate = self
        ageCollectionView.dataSource = self
        ageCollectionView.register(AgeCollectionViewCell.self, forCellWithReuseIdentifier: AgeCollectionViewCell.identifier)
        
        configureConstraints()
    }
    
    /// MARK: setting AutoLayout
    private func configureConstraints(){
        topBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/20)
        }
        
        lookOnce.snp.makeConstraints { make in
            make.top.equalTo(topBtn.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(view.safeAreaLayoutGuide.layoutFrame.width*2/3)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/23)
        }
        
        ageTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(lookOnce.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        ageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(ageTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height/28)
        }
        
        
    }
}


extension FilteringViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ageCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AgeCollectionViewCell.identifier, for: indexPath) as? AgeCollectionViewCell else {return UICollectionViewCell() }
            
            cell.backgroundColor = UIColor(hexCode: "F5F5F5")
            cell.inputData(text: MeetingFiltering.ageList[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ageCollectionView{
            return MeetingFiltering.ageList.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if collectionView == ageCollectionView{
            print("clicked ageCollection \(MeetingFiltering.ageList[indexPath.row])")
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == ageCollectionView{
            return CGSize(width: collectionView.bounds.width/4-10, height: collectionView.bounds.height)
        }
        
        return CGSize()
    }
}
