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

        // Do any additional setup after loading the view.
        configureTabBar()
    }
    
    private func configureTabBar() {
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: MeetingViewController())
        let vc3 = UINavigationController(rootViewController: HomeViewController())
        let vc4 = UINavigationController(rootViewController: HomeViewController())
        let vc5 = UINavigationController(rootViewController: HomeViewController())
        
        vc1.navigationItem.largeTitleDisplayMode = .never
        
        vc1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), selectedImage: UIImage(systemName: "house.fill"))
        vc2.tabBarItem = UITabBarItem(title: "모임", image: UIImage(systemName: "person.3.fill"), selectedImage: UIImage(systemName: "person.3.fill"))
        vc3.tabBarItem = UITabBarItem(title: "커뮤니티", image: UIImage(systemName: "note.text"), selectedImage: UIImage(systemName: "note.text"))
        vc4.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(systemName: "message.fill"), selectedImage: UIImage(systemName: "message.fill"))
        vc5.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person.circle.fill"), selectedImage: UIImage(systemName: "person.circle.fill"))
        
        self.tabBar.tintColor = .systemBlue
        
        self.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: false)
    }

}
