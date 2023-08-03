//
//  RuleListViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/19.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class RuleListViewController: UIViewController {
    
    // MARK: - UI Property
    
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
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
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
    
    var selectedRules: [String]
    
    private var selectedCount = 0
    
    private var isSelectedRule = Array(repeating: false, count: Rule.list.count)
    
    private let disposeBag = DisposeBag()
    
    weak var delegate: SendDataDelegate?
    
    init(rules: [String]) {
        self.selectedRules = rules
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        updateTitleView(title: "규칙 목록")
        setupCustomBackButton()

        addSubviews()
        configureConstraints()
        addTargets()
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(topLabel)
        view.addSubview(ruleCollectionView)
        view.addSubview(confirmButton)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        
        // 메인 라벨
        topLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
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
    
    private func addTargets() {
        confirmButton.rx.tap
            .subscribe(onNext: {
                let rules = self.isSelectedRule.enumerated().filter({ $0.element }).map({ Rule.list[$0.offset] })
                self.delegate?.sendStringArrayData?(rules)
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
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
        
        if selectedRules.contains(Rule.list[indexPath.item]) {
            cell.isSelectedCell = true
            isSelectedRule[indexPath.item] = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let text = Rule.list[indexPath.item]
        //return CGSize(width: text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 30, height: 40)
        return CGSize(width: ruleCollectionView.frame.width * 0.8, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagCollectionViewCell else { return }
        
        // 최대 5개 선택할 수 있도록 설정
        if !cell.isSelectedCell && self.selectedCount == 5 {
            print("초과")
            return
        }
        
        cell.isSelectedCell.toggle()
        isSelectedRule[indexPath.item].toggle()
        
        
        if cell.isSelectedCell { self.selectedCount += 1 } // 활성화
        else { self.selectedCount -= 1 } // 비활성화
    }
}


