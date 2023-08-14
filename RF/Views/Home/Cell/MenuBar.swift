//
//  MenuBar.swift
//  RF
//
//  Created by 용용이 on 2023/08/14.
//

import UIKit

// TabBar 클래스
//
// texts, numofCells를 이용해서 TabBar 선택 항목 제목과 개수를 조절할 수 있다.
// isSelectedIndex는 현재 선택된 Tab의 index값을 가지고 있다.
class MenuBar: UIView {


    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    
    let texts = ["개인 모임", "단체 모임"]
    let numofCells = 2
    private(set) var isSelectedIndex: Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)


        self.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func selectedCell(at: IndexPath){
        updateUI(at: at)
        isSelectedIndex = at.item
        print(isSelectedIndex)
        for indexPath in collectionView.indexPathsForVisibleItems {
            let cell = collectionView.cellForItem(at: indexPath) as? MenuCell
            if at == indexPath {
                cell?.setColor(textColor: .tintColor, backgroundColor: .systemBackground)
            }
            else{
                cell?.setColor(textColor: .black, backgroundColor: .systemBackground)
            }
        }
    }
    
    private func updateUI(at: IndexPath) {
        let options: UIView.AnimationOptions = [.curveEaseIn]//isSelected ? [.curveEaseIn] : [.curveEaseOut]
        
        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.5,
                       options: options,
                       animations: {
            for indexPath in self.collectionView.indexPathsForVisibleItems {
                let cell = self.collectionView.cellForItem(at: indexPath) as? MenuCell
                cell?.underLine.backgroundColor = (at == indexPath ? .tintColor : .systemGray6)
            }
            (self.superview as? UIStackView)?.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: - Ext: CollectionView

extension MenuBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / CGFloat(numofCells), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numofCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as! MenuCell

        cell.label.text = texts[indexPath.item]
        
        if indexPath.item == 0 { //첫 번째 셀은 Selected 상태로 초기화
            cell.isSelected = true
            cell.setColor(textColor: .tintColor, backgroundColor: .systemBackground)
            cell.underLine.backgroundColor = .tintColor
        }else{ //나머지 셀은 선택되지 않은 상태로 초기화
            cell.isSelected = false
            cell.setColor(textColor: .black, backgroundColor: .systemBackground)
            cell.underLine.backgroundColor = .systemGray6
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView{
            self.selectedCell(at: indexPath)
        }
    }
}
