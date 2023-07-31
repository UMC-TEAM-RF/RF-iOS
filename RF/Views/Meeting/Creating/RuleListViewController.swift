//
//  RuleListViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/19.
//

import UIKit
import SnapKit

final class RuleListViewController: UIViewController {
    
    // MARK: - UI Property
    
    // 네비게이션 바
    private lazy var navigationBar: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.delegate = self
        view.titleLabelText = "모임 규칙"
        return view
    }()
    
    // 메인 라벨
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 5개 설정 가능합니다!"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    // 규칙 리스트
    private lazy var ruleCollectionView: UICollectionView = {
        let flowLayout = LeftAlignedCollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 15
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.isScrollEnabled = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        return cv
    }()

    // 다음 버튼
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.backgroundColor = .tintColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Property
    
    private var selectedCount = 0
    
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        addSubviews()
        configureConstraints()
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(navigationBar)
        view.addSubview(topLabel)
        view.addSubview(ruleCollectionView)
        view.addSubview(confirmButton)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        // 네비게이션 바
        navigationBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        // 메인 라벨
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(30)
        }
        
        // 규칙 리스트
        ruleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(25)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.bottom.equalTo(confirmButton.snp.top).offset(-25)
        }
        
        // 확인 버튼
        confirmButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(50)
        }
    }
}

// MARK: - Ext: NavigationBarDelegate

extension RuleListViewController: NavigationBarDelegate {
    func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Ext: CollectionView

extension RuleListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Rule.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { return UICollectionViewCell() }
        cell.setupTagLabel(Rule.list[indexPath.item])
        cell.setCellBackgroundColor(.systemGray6)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = Rule.list[indexPath.item]
        return CGSize(width: text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 30, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagCollectionViewCell else { return }
        
        if !cell.isSelectedCell && self.selectedCount == 5 {
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
    }
}


