//
//  KeyboardInputView.swift
//  RF
//
//  Created by 이정동 on 2023/08/05.
//

import UIKit

class KeyboardInputView: UIView {
    
    private lazy var optionCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(OptionCollectionViewCell.self, forCellWithReuseIdentifier: OptionCollectionViewCell.identifier)
        cv.backgroundColor = .white
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        addSubview(optionCollectionView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        optionCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(30)
        }
    }

}

// MARK: - Ext: CollectionView

extension KeyboardInputView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCollectionViewCell.identifier, for: indexPath) as? OptionCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (optionCollectionView.frame.width - (15 * 2) - (15 * 3)) / 4.0
        let height = (optionCollectionView.frame.height - (15 * 2) - 15) / 2.0
        return CGSize(width: width, height: height)
    }
}
