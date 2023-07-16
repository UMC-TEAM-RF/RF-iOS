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

final class FilteringViewController: UIViewController{
    
    /// MARK:
    private lazy var topBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(hexCode: "F5F5F5")
        btn.setTitle("나와 잘맞는 모임을 검색해보세요 ", for: .normal)
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
        btn.setTitle("모집 중인 모임만 보기", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    /// MARK:
    private lazy var ageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "모집 연령대"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    /// MARK:
    private lazy var ageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return cv
    }()
    
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
        
    }
}
