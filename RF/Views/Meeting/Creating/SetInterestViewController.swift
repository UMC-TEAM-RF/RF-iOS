//
//  SetInterestViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/11.
//

import UIKit
import SnapKit

class SetInterestViewController: UIViewController {
    
    // MARK: - UI Property
    
    // 네비게이션 바
    private lazy var navigationBar: CreateMeetingNavigationBar = {
        let view = CreateMeetingNavigationBar()
        view.delegate = self
        return view
    }()
    
    // 프로그레스 바
    private lazy var progressBar: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.backgroundColor = UIColor(hexCode: "D1D1D1")
        pv.progress = 0.5
        return pv
    }()
    
    // 메인 라벨
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "대표 관심사를 설정해 주세요"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    // 서브 라벨
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 3개까지 설정 가능합니다."
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var interestCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 20
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.isScrollEnabled = false
        return cv
    }()

    // 다음 버튼
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .systemGray6
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Property
    
    private var selectedCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        addSubviews()
        configureConstraints()
        addTargets()
        configureCollectionView()
    }
    
    // MARK: - addSubviews
    
    private func addSubviews() {
        view.addSubview(navigationBar)
        view.addSubview(progressBar)
        view.addSubview(nextButton)
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        view.addSubview(interestCollectionView)
    }
    
    // MARK: - configureConstraints
    
    private func configureConstraints() {
        // 네비게이션 바
        navigationBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        // 프로그레스 바
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
        
        // 메인 라벨
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        // 서브 라벨
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
        }
        
        interestCollectionView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(35)
            make.horizontalEdges.equalToSuperview().inset(45)
            make.bottom.equalTo(nextButton.snp.top).offset(-30)
        }
        
        // 다음
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(50)
        }
    }
    
    private func configureCollectionView() {
        interestCollectionView.delegate = self
        interestCollectionView.dataSource = self
        interestCollectionView.register(InterestCollectionViewCell.self, forCellWithReuseIdentifier: "InterestCollectionViewCell")
    }
    
    // MARK: - addTargets
    
    private func addTargets() {
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - @objc func
    
    @objc func nextButtonTapped() {
        navigationController?.pushViewController(SetDescriptViewController(), animated: true)
    }
    
}

// MARK: - extension CollectionView

extension SetInterestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (interestCollectionView.frame.width - (20 * 3)) / 3, height: (interestCollectionView.frame.width - (20 * 3)) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Interest.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCollectionViewCell", for: indexPath) as! InterestCollectionViewCell
        cell.setTextLabel(Interest.list[indexPath.item])
        cell.contentView.backgroundColor = .systemGray6
        cell.setCornerRadius()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? InterestCollectionViewCell else { return }
        
        if !cell.isSelectedCell && self.selectedCount == 3 {
            print("초과")
            return
        }
        
        cell.isSelectedCell.toggle()
        
        // 최대 3개 선택할 수 있도록 설정
        if cell.isSelectedCell { // 활성화
            self.selectedCount += 1
            cell.setColor(textColor: .white, backgroundColor: .tintColor)
        } else {  // 비활성화
            self.selectedCount -= 1
            cell.setColor(textColor: .label, backgroundColor: .systemGray6)
        }
    
        // 다음 버튼 활성화 여부
        if self.selectedCount == 0 {
            nextButton.backgroundColor = .systemGray6
            nextButton.setTitleColor(.black, for: .normal)
            nextButton.isEnabled = false
        } else {
            nextButton.backgroundColor = .tintColor
            nextButton.setTitleColor(.white, for: .normal)
            nextButton.isEnabled = true
        }
    }
}


// MARK: - NavigationBarDelegate

extension SetInterestViewController: NavigationBarDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
