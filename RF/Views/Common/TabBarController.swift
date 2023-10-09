//
//  TabBarController.swift
//  RF
//
//  Created by 이정동 on 2023/07/02.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        updateChatBadgeValue()
        ChatService.shared.connect()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configureTabBar() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTabBarIcon), name: NotificationName.updateTabBarIcon, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedIndex), name: NotificationName.updateSelectedIndex, object: nil)
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: MeetingViewController())
        let vc3 = UINavigationController(rootViewController: ChatListViewController())
        let vc4 = UINavigationController(rootViewController: MyPageViewController())
        
        vc1.navigationItem.largeTitleDisplayMode = .never
        
        vc1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        vc2.tabBarItem = UITabBarItem(title: "모임", image: UIImage(named: "meeting"), selectedImage: UIImage(named: "meeting"))
        vc3.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(named: "chat"), selectedImage: UIImage(named: "chat"))
        vc4.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person.circle.fill"), selectedImage: UIImage(systemName: "person.circle.fill"))
        
        self.tabBar.tintColor = .systemBlue
        self.tabBar.backgroundColor = .white
        
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
        
        self.setViewControllers([vc1, vc2, vc3, vc4], animated: false)
    }
    
    private func updateChatBadgeValue() {
        let count = ChatRepository.shared.getNewMessageCount()
        if selectedIndex != 2, count > 0 {
            tabBar.items![2].badgeValue = "\(count)"
        }
    }
    
    @objc func updateTabBarIcon() {
        updateChatBadgeValue()
    }
    
    @objc func updateSelectedIndex() {
        selectedIndex = 1
    }
    
}
