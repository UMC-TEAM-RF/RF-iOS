//
//  SetDetailInfoViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/11.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SetDetailInfoViewController: UIViewController {
    
    // MARK: - UI Property
    
    // 네비게이션 바
    private lazy var navigationBar: CustomNavigationBar = {
        let view = CustomNavigationBar()
        view.titleLabelText = "모임 생성"
        view.delegate = self
        return view
    }()
    
    // 프로그레스 바
    private lazy var progressBar: UIProgressView = {
        let pv = UIProgressView()
        pv.progressViewStyle = .bar
        pv.backgroundColor = UIColor(hexCode: "D1D1D1")
        pv.progress = 1
        return pv
    }()
    
    // 메인 라벨
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "모임의 세부 정보를 입력해 주세요."
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    // 모임 인원 수 설정
    private lazy var personnelStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 5
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    private lazy var personnelTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "모임 인원 수"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var personnelSubLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 6명까지 가능합니다."
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var personnelStepper: PersonnelStepper = {
        let sp = PersonnelStepper()
        sp.minimumCount = 0
        sp.maximumCount = 5
        return sp
    }()
    
    // 한국인 멤버 수
    private lazy var koreanStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 5
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    private lazy var koreanTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "한국인 인원 수"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var koreanSubLabel: UILabel = {
        let label = UILabel()
        label.text = "글로벌한 모임을 위해\n설정해 주세요."
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .lightGray
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var koreanStepper: PersonnelStepper = {
        let sp = PersonnelStepper()
        sp.minimumCount = 0
        sp.maximumCount = 5
        return sp
    }()
    
    // 첫 번째 경계선
    private lazy var firstDivLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // 선호 연령대
    private lazy var ageGroupLabel: UILabel = {
        let label = UILabel()
        label.text = "선호 연령대"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var ageGroupButton: MenuButton = {
        let button = MenuButton()
        button.title = "무관"
        button.tag = 0
        button.delegate = self
        return button
    }()
    
    // 사용 언어
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.text = "선호 연령대"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var languageButton: MenuButton = {
        let button = MenuButton()
        button.title = "프랑스어"
        button.tag = 1
        button.delegate = self
        return button
    }()
    
    // 활동 장소
    private lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.text = "활동 장소"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var placeTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .systemGray6
        tf.layer.cornerRadius = 5
        tf.placeholder = "장소를 입력해 주세요."
        tf.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        tf.addHorizontalPadding(10)
        return tf
    }()
    
    // 두 번째 경계선
    private lazy var secondDivLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // 규칙
    private lazy var ruleButton: UIButton = {
        let button = UIButton()
        button.setTitle("모임의 규칙 ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .lightGray
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return button
    }()
    
    private lazy var ruleCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var ruleCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 12

        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        return cv
    }()
    
    // 다음 버튼
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("모임 생성하기", for: .normal)
        button.backgroundColor = .tintColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Property
    
    private let disposeBag = DisposeBag()
    
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        addSubviews()
        configureConstraints()
        addTargets()
        
        ruleCountLabel.text = "(\(Rule.list.count))"
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(navigationBar)
        view.addSubview(progressBar)
        
        // 메인 라벨
        view.addSubview(mainLabel)
        
        // 모임 인원 수 설정
        view.addSubview(personnelStackView)
        view.addSubview(personnelStepper)
        personnelStackView.addArrangedSubview(personnelTitleLabel)
        personnelStackView.addArrangedSubview(personnelSubLabel)
        
        // 한국인 인원 수 설정
        view.addSubview(koreanStackView)
        view.addSubview(koreanStepper)
        koreanStackView.addArrangedSubview(koreanTitleLabel)
        koreanStackView.addArrangedSubview(koreanSubLabel)
        
        // 첫 번째 경계선
        view.addSubview(firstDivLine)
        
        // 선호 연령대
        view.addSubview(ageGroupLabel)
        view.addSubview(ageGroupButton)
        
        // 사용 언어
        view.addSubview(languageLabel)
        view.addSubview(languageButton)
        
        // 활동 장소
        view.addSubview(placeLabel)
        view.addSubview(placeTextField)
        
        // 두 번째 경계선
        view.addSubview(secondDivLine)
        
        // 모임 규칙
        view.addSubview(ruleButton)
        view.addSubview(ruleCountLabel)
        view.addSubview(ruleCollectionView)
        
        // 생성 버튼
        view.addSubview(createButton)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        // 네비게이션 바
        navigationBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        // 프로그레스 바
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
        
        // 메인 라벨
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(30)
        }
        
        // 모임 인원 수 설정
        personnelStackView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(30)
        }
        
        personnelStepper.snp.makeConstraints { make in
            make.centerY.equalTo(personnelStackView)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(personnelStackView.snp.height).multipliedBy(1.15)
            make.width.equalTo(150)
        }
        
        // 한국인 인원 수 설정
        koreanStackView.snp.makeConstraints { make in
            make.top.equalTo(personnelStackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(30)
        }
        
        koreanStepper.snp.makeConstraints { make in
            make.centerY.equalTo(koreanStackView)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(personnelStepper.snp.height)
            make.width.equalTo(150)
        }
        
        firstDivLine.snp.makeConstraints { make in
            make.top.equalTo(koreanStackView.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        // 선호 연령대
        ageGroupLabel.snp.makeConstraints { make in
            make.top.equalTo(firstDivLine.snp.bottom).offset(30)
            make.height.equalTo(30)
            make.leading.equalToSuperview().inset(30)
        }
        
        ageGroupButton.snp.makeConstraints { make in
            make.centerY.equalTo(ageGroupLabel)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(ageGroupLabel.snp.height).multipliedBy(1.2)
            make.width.equalTo(130)
        }
        
        // 사용 언어
        languageLabel.snp.makeConstraints { make in
            make.top.equalTo(ageGroupLabel.snp.bottom).offset(30)
            make.height.equalTo(30)
            make.leading.equalToSuperview().inset(30)
        }
        
        languageButton.snp.makeConstraints { make in
            make.centerY.equalTo(languageLabel)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(languageLabel.snp.height).multipliedBy(1.2)
            make.width.equalTo(130)
        }
        
        // 활동 장소
        placeLabel.snp.makeConstraints { make in
            make.top.equalTo(languageLabel.snp.bottom).offset(30)
            make.height.equalTo(30)
            make.leading.equalToSuperview().inset(30)
        }
        
        placeTextField.snp.makeConstraints { make in
            make.centerY.equalTo(placeLabel)
            make.trailing.equalToSuperview().inset(30)
            make.width.equalTo(200)
            make.height.equalTo(placeLabel.snp.height).multipliedBy(1.2)
        }
        
        // 두 번째 경계선
        secondDivLine.snp.makeConstraints { make in
            make.top.equalTo(placeLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        // 모임 규칙
        ruleButton.snp.makeConstraints { make in
            make.top.equalTo(secondDivLine.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(30)
        }
        
        ruleCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(ruleButton.snp.trailing).offset(10)
            make.centerY.equalTo(ruleButton.snp.centerY)
        }
        
        ruleCollectionView.snp.makeConstraints { make in
            make.top.equalTo(ruleButton.snp.bottom).offset(23)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.height.equalTo(35)
        }
        
        // 다음
        createButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - addTargets()
    
    private func addTargets() {
        ruleButton.rx.tap
            .subscribe(onNext: {
                self.navigationController?.pushViewController(RuleListViewController(), animated: true)
            })
            .disposed(by: disposeBag)
        
        createButton.rx.tap
            .subscribe(onNext: {
                self.tabBarController?.tabBar.isHidden = false
                self.navigationController?.popToRootViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Ext: NavigationBarDelgate

extension SetDetailInfoViewController: NavigationBarDelegate {
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Ext: CollectionView

extension SetDetailInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let cellSize = CGSize(width: text.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width + 30, height: collectionView.frame.height)
        
        return cellSize
    }
}

extension SetDetailInfoViewController: MenuButtonDelegate {
    func didTapMenuButton(_ tag: Int) {
        let pickerVC = PickerViewController(tag: tag)
        pickerVC.delegate = self
        pickerVC.modalPresentationStyle = .overCurrentContext
        present(pickerVC, animated: true, completion: nil)
    }
}

extension SetDetailInfoViewController: ToolbarDelegate {
    func didTapDoneButton(tag: Int, value: String) {
        let menuButton = tag == 0 ? ageGroupButton : languageButton
        menuButton.title = value
    }
}
