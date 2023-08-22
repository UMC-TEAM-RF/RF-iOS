//
//  SetInterestViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/11.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SetInterestViewController: UIViewController {
    
    // MARK: - UI Property
    
    // 프로그레스 바
    private lazy var progressBar: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.backgroundColor = ButtonColor.main.color
        pv.progress = 0.5
        return pv
    }()
    
    // 메인 라벨
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "대표 관심사를 설정해 주세요."
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = TextColor.first.color
        return label
    }()
    
    // 서브 라벨
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = "(최대 3개 설정 가능)"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = TextColor.secondary.color
        return label
    }()
    
    private lazy var interestCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 15
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.isScrollEnabled = false
        return cv
    }()

    // 다음 버튼
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = ButtonColor.normal.color
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    private let viewModel = SetInterestViewModel()
    
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        updateTitleView(title: "모임 생성")
        setupCustomBackButton()
        
        addSubviews()
        configureConstraints()
        bind()
        addTargets()
        configureCollectionView()
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(progressBar)
        view.addSubview(nextButton)
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        view.addSubview(interestCollectionView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        
        // 프로그레스 바
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
        
        // 메인 라벨
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(30)
        }
        
        // 서브 라벨
        subLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainLabel.snp.trailing).offset(10)
            make.bottom.equalTo(mainLabel.snp.bottom)
        }
        
        interestCollectionView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(30)
            make.bottom.equalTo(nextButton.snp.top).offset(-30)
        }
        
        // 다음
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - configureCollectionView()
    
    private func configureCollectionView() {
        interestCollectionView.delegate = self
        interestCollectionView.dataSource = self
        interestCollectionView.register(InterestCollectionViewCell.self, forCellWithReuseIdentifier: InterestCollectionViewCell.identifier)
    }
    
    // MARK: - addTargets()
    
    private func addTargets() {
        nextButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.moveToNextPage()
                self?.navigationController?.pushViewController(SetDescriptViewController(), animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    /// MARK:
    private func moveToNextPage() {
        let interests = viewModel.interestingRelay.value.map { EnumFile.enumfile.enumList.value.interest?[$0.row].key ?? "" }
        CreateViewModel.viewModel.interestingRelay.accept(interests)
    }
    
    /// MARK: binding viewModel
    private func bind() {
        viewModel.interestingRelay
            .bind { [weak self] items in
                self?.updateInterestingItems(items)
            }
            .disposed(by: disposeBag)
        
        viewModel.checkSelectedAll
            .bind { [weak self] check in
                if check{
                    self?.nextButton.backgroundColor = ButtonColor.main.color
                    self?.nextButton.setTitleColor(ButtonColor.normal.color, for: .normal)
                    self?.nextButton.isEnabled = true
                }
                else{
                    self?.nextButton.backgroundColor = ButtonColor.normal.color
                    self?.nextButton.setTitleColor(TextColor.first.color, for: .normal)
                    self?.nextButton.isEnabled = false
                }
            }
            .disposed(by: disposeBag)
    }
    
    /// MARK: 선택된 셀 업데이트 하는 함수
    private func updateInterestingItems(_ items: Set<IndexPath>) {
        for indexPath in interestCollectionView.indexPathsForVisibleItems {
            guard let cell = interestCollectionView.cellForItem(at: indexPath) as? InterestCollectionViewCell else { return }
            if items.contains(indexPath) {
                cell.setColor(textColor: ButtonColor.normal.color, backgroundColor: ButtonColor.main.color)
            }
            else{
                cell.setColor(textColor: TextColor.first.color, backgroundColor: ButtonColor.normal.color)
            }
        }
    }
}

// MARK: - Ext: CollectionView

extension SetInterestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (interestCollectionView.frame.width - (15 * 3)) / 4.0, height: (interestCollectionView.frame.width - (15 * 3)) / 4.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EnumFile.enumfile.enumList.value.interest?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestCollectionViewCell.identifier, for: indexPath) as! InterestCollectionViewCell
        
        cell.setTextLabel(EnumFile.enumfile.enumList.value.interest?[indexPath.item].value ?? "")
        cell.setColor(textColor: TextColor.first.color, backgroundColor: ButtonColor.normal.color)
        cell.contentView.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedInterestingItems(at: indexPath)

    }
}
