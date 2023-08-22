//
//  SetInterestsViewController.swift
//  RF
//
//  Created by 용용이 on 2023/07/21.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

/// 관심사 설정하는 화면
final class PersonalInterestsViewController: UIViewController {
    
    // MARK: - UI Property
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "관심사 설정", style: .done, target: self, action: nil)
        btn.isEnabled = false
        btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: TextColor.first.color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)], for: .disabled)
        return btn
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    // 프로그레스 바
    private lazy var progressBar: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.backgroundColor = UIColor(hexCode: "D1D1D1")
        pv.progress = 0.9
        return pv
    }()
    
    // 메인 라벨
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "관심사를 설정해 주세요!"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = TextColor.first.color
        return label
    }()
    
    // 서브 라벨
    private lazy var interestLabel: UILabel = {
        let label = UILabel()
        label.text = "취미 & 관심사"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = TextColor.first.color
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
    
    // 라이프스타일 라벨
    private lazy var lifeStyleLabel: UILabel = {
        let label = UILabel()
        label.text = "라이프스타일"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = TextColor.first.color
        return label
    }()
    
    private lazy var lifeStyleCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 20
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.isScrollEnabled = false
        return cv
    }()
    
    // 라이프스타일 라벨
    private lazy var mbtiLabel: UILabel = {
        let label = UILabel()
        label.text = "MBTI"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = TextColor.first.color
        return label
    }()
    
    private lazy var mbtiCollectionView: UICollectionView = {
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
        button.backgroundColor = ButtonColor.normal.color
        button.setTitleColor(TextColor.first.color, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    private let viewModel = PersonalInterestsViewModel()
    
    
    // MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = TextColor.first.color
        view.backgroundColor = .white
        
        addSubviews()
        configureConstraints()
        addTargets()
        configureCollectionView()
        bind()
    }
    
    // MARK: - addSubviews
    
    private func addSubviews() {
        view.addSubview(progressBar)
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        containerView.addSubview(nextButton)
        containerView.addSubview(mainLabel)
        containerView.addSubview(interestLabel)
        containerView.addSubview(interestCollectionView)
        containerView.addSubview(lifeStyleLabel)
        containerView.addSubview(lifeStyleCollectionView)
        containerView.addSubview(mbtiLabel)
        containerView.addSubview(mbtiCollectionView)
    }
    
    // MARK: - configureConstraints
    
    private func configureConstraints() {
        
        // 프로그레스 바
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        
        // 스크롤 뷰
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(5)
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        // 컨테이너 뷰
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        
        // 메인 라벨
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        // 취미 관심사 라벨 & 컬렉션뷰
        interestLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        interestCollectionView.snp.makeConstraints { make in
            make.top.equalTo(interestLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height*0.4)
        }
        
        // 라이프스타일 라벨 & 컬렉션뷰
        lifeStyleLabel.snp.makeConstraints { make in
            make.top.equalTo(interestCollectionView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        lifeStyleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lifeStyleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(140)
        }
        
        // MBTI 라벨 & 컬렉션뷰
        mbtiLabel.snp.makeConstraints { make in
            make.top.equalTo(lifeStyleCollectionView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        mbtiCollectionView.snp.makeConstraints { make in
            make.top.equalTo(mbtiLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height*0.4)
        }
        
        // 다음
        nextButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.top.equalTo(mbtiCollectionView.snp.bottom).offset(30)
            make.bottom.equalToSuperview() // 이것이 중요함
            make.height.equalTo(50)
        }
    }
    
    private func configureCollectionView() {
        interestCollectionView.delegate = self
        interestCollectionView.dataSource = self
        interestCollectionView.register(InterestSmallCollectionViewCell.self, forCellWithReuseIdentifier: InterestSmallCollectionViewCell.identifier)
        lifeStyleCollectionView.delegate = self
        lifeStyleCollectionView.dataSource = self
        lifeStyleCollectionView.register(lifestyleCollectionViewCell.self, forCellWithReuseIdentifier: lifestyleCollectionViewCell.identifier)
        mbtiCollectionView.delegate = self
        mbtiCollectionView.dataSource = self
        mbtiCollectionView.register(InterestSmallCollectionViewCell.self, forCellWithReuseIdentifier: InterestSmallCollectionViewCell.identifier)
    }
    
    // MARK: - addTargets
    
    private func addTargets() {
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.checkSelected()
                    .bind(onNext: { check in
                        if check{
                            self?.moveNextPage()
                        }
                        else{
                            self?.showAlert(text: "모두 선택해주세요!")
                        }
                    })
                    .disposed(by: self?.disposeBag ?? DisposeBag())
                
            })
            .disposed(by: disposeBag)
    }
    
    /// MARK: binding ViewModel
    private func bind(){
        viewModel.lifeStyleRelay
            .bind { [weak self] item in
                self?.updateLifeStyleItem(item)
            }
            .disposed(by: disposeBag)
        
        viewModel.interestingRelay
            .bind { [weak self] items in
                self?.updateInterestingItems(items)
            }
            .disposed(by: disposeBag)
        
        viewModel.mbtiRelay
            .bind {[weak self] items in
                self?.updateMBTIItems(items)
            }
            .disposed(by: disposeBag)
        
        viewModel.checkSelectedForButtonColor()
            .subscribe(onNext:{ [weak self] check in
                if check{
                    self?.nextButton.setTitleColor(BackgroundColor.white.color, for: .normal)
                    self?.nextButton.backgroundColor = ButtonColor.main.color
                }
                else{
                    self?.nextButton.setTitleColor(TextColor.first.color, for: .normal)
                    self?.nextButton.backgroundColor = ButtonColor.normal.color
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - Update View
    
    
    /// MARK:  라이프 스타일 선택 시 업데이트 하는 함수
    private func updateLifeStyleItem(_ item: IndexPath){
        for indexPath in lifeStyleCollectionView.indexPathsForVisibleItems {
            let cell = lifeStyleCollectionView.cellForItem(at: indexPath) as? lifestyleCollectionViewCell
            if item == indexPath {
                cell?.setColor(textColor: BackgroundColor.white.color, backgroundColor: ButtonColor.main.color)
            }
            else{
                cell?.setColor(textColor: TextColor.secondary.color, backgroundColor: BackgroundColor.white.color)
            }
        }
    }
    
    /// MARK: 선택된 셀 업데이트 하는 함수
    private func updateInterestingItems(_ items: Set<IndexPath>) {
        for indexPath in interestCollectionView.indexPathsForVisibleItems {
            let cell = interestCollectionView.cellForItem(at: indexPath) as? InterestSmallCollectionViewCell
            if items.contains(indexPath) {
                cell?.setColor(textColor: BackgroundColor.white.color, backgroundColor: ButtonColor.main.color)
            }
            else{
                cell?.setColor(textColor: TextColor.secondary.color, backgroundColor: BackgroundColor.white.color)
            }
        }
    }
    
    /// MARK: 선택된 셀 업데이트 하는 함수
    private func updateMBTIItems(_ item: IndexPath) {
        for indexPath in mbtiCollectionView.indexPathsForVisibleItems {
            let cell = mbtiCollectionView.cellForItem(at: indexPath) as? InterestSmallCollectionViewCell
            if item == indexPath {
                cell?.setColor(textColor: BackgroundColor.white.color, backgroundColor: ButtonColor.main.color)
            }
            else{
                cell?.setColor(textColor: TextColor.secondary.color, backgroundColor: BackgroundColor.white.color)
            }
        }
    }
    
    // MARK: - Functions
    
    /// MARK: 다음 화면으로 이동
    private func moveNextPage(){
        
        SignUpDataViewModel.viewModel.lifeStyleRelay.accept(EnumFile.enumfile.enumList.value.lifeStyle?[viewModel.lifeStyleRelay.value.row].key ?? "")
        SignUpDataViewModel.viewModel.mbtiRelay.accept(Mbti.list[viewModel.mbtiRelay.value.row])
        viewModel.convertInterestingValue()
            .bind { list in
                SignUpDataViewModel.viewModel.interestingRelay.accept(list)
            }
            .disposed(by: disposeBag)
        
        SignUpDataViewModel.viewModel.totalSignUp()
            .subscribe(onNext:{ [weak self] check in
                if check{
                    self?.navigationController?.popToRootViewController(animated: false)
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    
    /// MARK:  다 선택이 안된 경우 실행
    private func showAlert(text: String){
        let sheet = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default)
        
        sheet.addAction(success)
        self.present(sheet,animated: true)
    }
    
}

// MARK: - extension CollectionView

extension PersonalInterestsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == interestCollectionView {
            return CGSize(width: (interestCollectionView.frame.width / 5),
                          height: (interestCollectionView.frame.height / 5))
        } else if collectionView == lifeStyleCollectionView {
            return CGSize(width: lifeStyleCollectionView.frame.width / 2 - 30,
                          height: lifeStyleCollectionView.frame.height)
        } else if collectionView == mbtiCollectionView {
            return CGSize(width: (mbtiCollectionView.frame.width / 5),
                          height: (mbtiCollectionView.frame.height / 5))
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == interestCollectionView{
            return EnumFile.enumfile.enumList.value.interest?.count ?? 0
        }else if collectionView == lifeStyleCollectionView{
            return EnumFile.enumfile.enumList.value.lifeStyle?.count ?? 0
        }else if collectionView == mbtiCollectionView{
            return Mbti.list.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == interestCollectionView{
            let interest = EnumFile.enumfile.enumList.value.interest?[indexPath.item]
            guard let cell = interestCollectionView.dequeueReusableCell(withReuseIdentifier: InterestSmallCollectionViewCell.identifier,
                                                                        for: indexPath) as? InterestSmallCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setTextLabel( interest?.value ?? "" )
            cell.contentView.backgroundColor = BackgroundColor.white.color
            
            
            cell.setColor(textColor: TextColor.secondary.color, backgroundColor: BackgroundColor.white.color)
            
            cell.setCornerRadius()
            return cell
            
        } else if collectionView == lifeStyleCollectionView {
            let lifestyle = EnumFile.enumfile.enumList.value.lifeStyle?[indexPath.item]
            guard let cell = lifeStyleCollectionView.dequeueReusableCell(withReuseIdentifier: lifestyleCollectionViewCell.identifier, for: indexPath) as? lifestyleCollectionViewCell else {return UICollectionViewCell()}
            
            cell.setImage( lifestyle?.key ?? "" )
            cell.setTextLabel( lifestyle?.value ?? "" )
            cell.contentView.backgroundColor = BackgroundColor.white.color
            cell.setColor(textColor: TextColor.secondary.color, backgroundColor: BackgroundColor.white.color)
            cell.setCornerRadius()
            return cell
            
        } else if collectionView == mbtiCollectionView {
            let str : String = Mbti.list[indexPath.item]
            guard let cell = mbtiCollectionView.dequeueReusableCell(withReuseIdentifier: InterestSmallCollectionViewCell.identifier,
                                                                    for: indexPath) as? InterestSmallCollectionViewCell else { return UICollectionViewCell() }
            
            cell.setTextLabel( str )
            cell.contentView.backgroundColor = BackgroundColor.white.color
            cell.setColor(textColor: TextColor.secondary.color, backgroundColor: BackgroundColor.white.color)
            cell.setCornerRadius()
            return cell
            
        }
        return UICollectionViewCell()
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == lifeStyleCollectionView{
            viewModel.selectedLifeStyleItem(at: indexPath)
        }
        else if collectionView == interestCollectionView{
            viewModel.selectedInterestingItems(at: indexPath)
        }
        else if collectionView == mbtiCollectionView{
            viewModel.selectedMBTIItems(at: indexPath)
        }
    }
}
