//
//  MyPageEditingProfileViewController.swift
//  RF
//
//  Created by 용용이 on 2023/10/16.
//

import UIKit

class MyPageEditingProfileViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var userListTableView: UITableView = {
        let tv = UITableView(frame: CGRect(), style: .insetGrouped)
        tv.delegate = self
        tv.dataSource = self
        tv.register(LanguageTableViewCell.self, forCellReuseIdentifier: LanguageTableViewCell.identifier)
        tv.register(MyPageBlockUserListViewCell.self, forCellReuseIdentifier: MyPageBlockUserListViewCell.identifier)
        tv.register(ProfileSettingTableViewCell.self, forCellReuseIdentifier: ProfileSettingTableViewCell.identifier)
        tv.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tv.backgroundColor = .white
        return tv
    }()
    var sectionHeader = ["관심 나라", "관심 언어", ""]
    
    var interestedNationList = ["필리핀", "중국"]
    var interestedLanguageList = ["필리핀어", "중국어"]
    
    
    var settingTitle = ["관심사", "라이프 스타일", "MBTI"]
    
    var interestData = ["SPORT", "SPORT_GAME"]
    var lifeStyleData = ["MORNING_HUMAN"]
    var mbtiData = ["ESTJ"]
    
    
    
    // MARK: - Property
    private var isUpdateUser: Bool = false
    private var isLocatedCurrentView: Bool = false
    
    // MARK: - viewDidLoad()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        updateTitleView(title: "프로필 수정")
        setupCustomBackButton()
        
        addSubviews()
        configureConstraints()
        
        updateUser()
//        NotificationCenter.default.addObserver(self, selector: #selector(updateChat), name: NotificationName.updateChatList, object: nil)
    }
    
    // MARK: - viewWillAppear()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        isLocatedCurrentView = true
        
        if isUpdateUser {
            updateUserList()
            isUpdateUser = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        isLocatedCurrentView = false
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(userListTableView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        userListTableView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func updateUserList() {
        SingletonChannel.shared.sortByLatest()
        self.userListTableView.reloadData()
    }
    
    // MARK: - @objc func
    
    @objc func updateUser() {
        if isLocatedCurrentView {
            updateUserList()
        } else {
            isUpdateUser = true
        }
    }
}

// MARK: - Ext: TableView

extension MyPageEditingProfileViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return interestedNationList.count + 1
        case 1:
            return interestedLanguageList.count + 1
        case 2:
            return settingTitle.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.identifier, for: indexPath) as? LanguageTableViewCell else { return UITableViewCell() }
            
            cell.backgroundColor = StrokeColor.main.color
            
            if indexPath.item == interestedNationList.count{
                cell.updateColor(ButtonColor.main.color)
                cell.updateTitle("나라 추가")
            }else{
                cell.updateTitle(interestedNationList[indexPath.item])
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.identifier, for: indexPath) as? LanguageTableViewCell else { return UITableViewCell() }
            
            cell.backgroundColor = StrokeColor.main.color
            
            if indexPath.item == interestedLanguageList.count{
                cell.updateColor(ButtonColor.main.color)
                cell.updateTitle("언어 추가")
            }else{
                cell.updateTitle(interestedLanguageList[indexPath.item])
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingTableViewCell.identifier, for: indexPath) as? ProfileSettingTableViewCell else { return UITableViewCell() }
            
            cell.updateTitle(settingTitle[indexPath.item])
            switch indexPath.item{
            case 0: // interests
                cell.personalInterests = self.interestData
            case 1: // lifestyle
                cell.personalLifeStyles = self.lifeStyleData
            case 2: // mbti
                cell.personalMBTIs = self.mbtiData
            default:
                break
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 30
        case 1:
            return 30
        case 2:
            return 80
        default:
            return 0
        }
    }
    
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        // 오른쪽에 만들기
//
//        let alert = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
//            print("알림 여부 클릭")
//            success(true)
//        }
//        alert.backgroundColor = .lightGray
//        alert.image = UIImage(systemName: "bell.fill")
//
//        let exit = UIContextualAction(style: .normal, title: nil) { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
//            print("나가기 클릭")
//            success(true)
//        }
//        exit.backgroundColor = .systemRed
//        exit.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
//
//        //actions배열 인덱스 0이 오른쪽에 붙어서 나옴
//        let configure = UISwipeActionsConfiguration(actions: [exit, alert])
//        configure.performsFirstActionWithFullSwipe = false
//
//        return configure
//    }
    
    
}
