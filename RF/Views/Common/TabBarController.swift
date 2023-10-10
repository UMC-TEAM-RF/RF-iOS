//
//  TabBarController.swift
//  RF
//
//  Created by 이정동 on 2023/07/02.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private let viewModel = ScheduleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        getData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configureTabBar() {
        
        delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTabBarIcon), name: NotificationName.updateTabBarIcon, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedIndex), name: NotificationName.updateSelectedIndex, object: nil)
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: MeetingViewController())
        //let vc3 = UINavigationController(rootViewController: UIViewController())
        let vc4 = UINavigationController(rootViewController: ChatListViewController())
        let vc5 = UINavigationController(rootViewController: MyPageViewController())
        
        vc1.navigationItem.largeTitleDisplayMode = .never
        
        vc1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        vc2.tabBarItem = UITabBarItem(title: "모임", image: UIImage(named: "meeting"), selectedImage: UIImage(named: "meeting"))
        //vc3.tabBarItem = UITabBarItem(title: "커뮤니티", image: UIImage(named: "post"), selectedImage: UIImage(named: "post"))
        vc4.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(named: "chat"), selectedImage: UIImage(named: "chat"))
        //프로필 이미지 없는 경우 다음 코드 사용
//        vc5.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person.circle.fill"), selectedImage: UIImage(systemName: "person.circle.fill"))
        
        vc5.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "LogoImage"), selectedImage: UIImage(named: "LogoImage"))
        //viewmodel과 연결할 때 이 주석안의 코드 사용 예정
//        vc5.tabBarItem = UITabBarItem(title: "마이페이지", image: SignUpDataViewModel.viewModel.introduceSelfRelay.value, selectedImage: SignUpDataViewModel.viewModel.introduceSelfRelay.value)
        
        self.tabBar.tintColor = .systemBlue
        self.tabBar.backgroundColor = .white
        
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
        
        //self.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: false)
        self.setViewControllers([vc1, vc2, vc4, vc5], animated: false)
    }
    
    @objc func updateTabBarIcon() {
//        if selectedIndex != 3, let items = tabBar.items, items.indices.contains(3) {
//            items[3].image = UIImage(named: "newChat")
//        }
        if selectedIndex != 2, let items = tabBar.items, items.indices.contains(2) {
            items[2].image = UIImage(named: "newChat")
        }
    }
    
    @objc func updateSelectedIndex() {
        selectedIndex = 1
    }
    
    
    /// MARK: ViewModel에서 데이터 얻는 함수
    private func getData(){
        viewModel.getData()
    }
    
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        if let tabBarItems = tabBar.items, selectedIndex == 3 {
//            tabBarItems[3].image = UIImage(named: "chat")
//        }
        
        // 커뮤니티 탭 있기 전까지 사용
        if let tabBarItems = tabBar.items, selectedIndex == 2 {
            tabBarItems[2].image = UIImage(named: "chat")
        }
    }
}
