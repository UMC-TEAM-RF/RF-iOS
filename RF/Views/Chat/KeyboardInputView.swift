//
//  KeyboardInputView.swift
//  RF
//
//  Created by 이정동 on 2023/08/05.
//

import UIKit

final class KeyboardInputView: UIView {
    
    private lazy var optionCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(OptionCollectionViewCell.self, forCellWithReuseIdentifier: OptionCollectionViewCell.identifier)
        cv.backgroundColor = ButtonColor.normal.color
        return cv
    }()
    
    var delegate: SendDataDelegate?
    
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
            make.bottom.equalToSuperview()
        }
    }

}


// MARK: - Ext: CollectionView

extension KeyboardInputView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCollectionViewCell.identifier, for: indexPath) as? OptionCollectionViewCell else { return UICollectionViewCell() }
        cell.configureOptionUI(ChatMenuOption(rawValue: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (optionCollectionView.frame.width - (30 * 2) - (15 * 3)) / 4.0
        let height = (optionCollectionView.frame.height - (30 * 2) - 15) / 2.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case ChatMenuOption.album.rawValue:
            delegate?.sendTagData?(tag: ChatMenuOption.album.rawValue)
        case ChatMenuOption.camera.rawValue:
            delegate?.sendTagData?(tag: ChatMenuOption.camera.rawValue)
        case ChatMenuOption.schedule.rawValue:
            delegate?.sendTagData?(tag: ChatMenuOption.schedule.rawValue)
        case ChatMenuOption.topic.rawValue:
            delegate?.sendTagData?(tag: ChatMenuOption.topic.rawValue)
        default:
            print("index out of range")
        }
    }
}

