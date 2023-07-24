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

class PersonalInterestsViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    private func setNavigationTitle()
    {
        navigationItem.title = ""
        view.backgroundColor = .systemBackground
    }
    
    // 프로그레스 바
    private lazy var progressBar: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.backgroundColor = UIColor(hexCode: "D1D1D1")
        pv.progress = 0.8
        return pv
    }()
    
    // 메인 라벨
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "\("알프")님의\n관심사를 설정해 주세요!"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    // 서브 라벨
    private lazy var interestLabel: UILabel = {
        let label = UILabel()
        label.text = "취미 & 관심사"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
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
        button.backgroundColor = .systemGray6
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    
    private var selectedCount: [Int] = [0, 0, 0]
    private var selectedCountMax: [Int] = [3, -1, 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationTitle()
        
        addSubviews()
        configureConstraints()
        addTargets()
        configureCollectionView()
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
            make.top.equalToSuperview().offset(45)
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
            make.height.equalTo(200)
        }
        
        // 취미 관심사 라벨 & 컬렉션뷰
        lifeStyleLabel.snp.makeConstraints { make in
            make.top.equalTo(interestCollectionView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        lifeStyleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lifeStyleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(400)
        }
        
        // 취미 관심사 라벨 & 컬렉션뷰
        mbtiLabel.snp.makeConstraints { make in
            make.top.equalTo(lifeStyleCollectionView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        mbtiCollectionView.snp.makeConstraints { make in
            make.top.equalTo(mbtiLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(200)
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
        interestCollectionView.register(InterestSmallCollectionViewCell.self, forCellWithReuseIdentifier: "InterestSmallCollectionViewCell")
        lifeStyleCollectionView.delegate = self
        lifeStyleCollectionView.dataSource = self
        lifeStyleCollectionView.register(InterestSmallCollectionViewCell.self, forCellWithReuseIdentifier: "LifeStyleCollectionViewCell")
        mbtiCollectionView.delegate = self
        mbtiCollectionView.dataSource = self
        mbtiCollectionView.register(InterestSmallCollectionViewCell.self, forCellWithReuseIdentifier: "MbtiCollectionViewCell")
    }
    
    // MARK: - addTargets
    
    private func addTargets() {
        nextButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(SetDescriptViewController(), animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - extension CollectionView

extension PersonalInterestsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == interestCollectionView{
            return CGSize(width: (interestCollectionView.frame.width - (20 * 2)) / 3, height: (interestCollectionView.frame.height - (20 * 3)) / 4)
        }else if collectionView == lifeStyleCollectionView{
            return CGSize(width: lifeStyleCollectionView.frame.width, height: (lifeStyleCollectionView.frame.height - (20 * 5)) / 6)
        }else if collectionView == mbtiCollectionView{
            return CGSize(width: (mbtiCollectionView.frame.width - (20 * 3)) / 4, height: (mbtiCollectionView.frame.height - (20 * 3)) / 4)
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == interestCollectionView{
            return Interest.list.count
        }else if collectionView == lifeStyleCollectionView{
            return LifeStyle.list.count
        }else if collectionView == mbtiCollectionView{
            return Mbti.list.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == interestCollectionView{
            
            var str : String = Interest.list[indexPath.item]
            str.removeFirst()
            str.removeFirst()
            
            let cell = interestCollectionView.dequeueReusableCell(withReuseIdentifier: "InterestSmallCollectionViewCell", for: indexPath) as! InterestSmallCollectionViewCell
            
            cell.setTextLabel( str )
            cell.contentView.backgroundColor = .systemGray6
            cell.setCornerRadius()
            return cell
            
        }else if collectionView == lifeStyleCollectionView{
            
            let str : String = LifeStyle.list[indexPath.item]
            
            let cell = lifeStyleCollectionView.dequeueReusableCell(withReuseIdentifier: "LifeStyleCollectionViewCell", for: indexPath) as! InterestSmallCollectionViewCell
            
            cell.setTextLabel( str )
            cell.contentView.backgroundColor = .systemGray6
            cell.setCornerRadius()
            return cell
            
        }else if collectionView == mbtiCollectionView{
            let str : String = Mbti.list[indexPath.item]
            let cell = mbtiCollectionView.dequeueReusableCell(withReuseIdentifier: "MbtiCollectionViewCell", for: indexPath) as! InterestSmallCollectionViewCell
            
            cell.setTextLabel( str )
            cell.contentView.backgroundColor = .systemGray6
            cell.setCornerRadius()
            return cell
            
        }
        return UICollectionViewCell()
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? InterestSmallCollectionViewCell else { return }
        
        var cellindex = -1
        
        if collectionView == interestCollectionView{
            cellindex = 0
        }else if collectionView == lifeStyleCollectionView{
            cellindex = 1
        }else if collectionView == mbtiCollectionView{
            cellindex = 2
        }
        
        
        if !cell.isSelectedCell && self.selectedCount[cellindex] == selectedCountMax[cellindex] {
            print("초과")
            return
        }
        
        cell.isSelectedCell.toggle()
        
//        // 최대 3개 선택할 수 있도록 설정
        if cell.isSelectedCell { // 활성화
            self.selectedCount[cellindex] += 1
            cell.setColor(textColor: .white, backgroundColor: .tintColor)
        } else {  // 비활성화
            self.selectedCount[cellindex] -= 1
            cell.setColor(textColor: .label, backgroundColor: .systemGray6)
        }
    
        // 다음 버튼 활성화 여부
        if self.selectedCount[0]*self.selectedCount[1]*self.selectedCount[2] == 0{
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
