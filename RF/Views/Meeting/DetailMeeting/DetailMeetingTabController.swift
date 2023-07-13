//
//  DetailMeetingTabController.swift
//  RF
//
//  Created by 정호진 on 2023/07/10.
//

import Foundation
import UIKit
import Tabman
import Pageboy
import RxSwift


final class DetailMeetingTabController: TabmanViewController {
    
    /// MARK: 카톡, 메시지, 인스타그램 공유 버튼
    private lazy var linkIconBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = UIImage(systemName: "popcorn.fill")
        btn.tintColor = .black
        return btn
    }()
   
    private var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "다국적 사람들과 소통해요!"
        
        addSubviews()
    }
    
    /// Add UI
    private func addSubviews(){
        navigationItem.rightBarButtonItem = linkIconBtn
        let homeController = DetailMeetingHomeController()
        let chatController = DetailMeetingChatController()
        
        viewControllers.append(homeController)
        viewControllers.append(chatController)
        
        self.dataSource = self
        customTabBar()
    }
    
    /// MARK: TabBar Custom
    private func customTabBar(){
        let bar = TMBar.ButtonBar()

        //탭바 레이아웃 설정
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .intrinsic
        bar.layout.interButtonSpacing = view.bounds.width/2
                
        //배경색
        bar.backgroundView.style = .clear
        bar.backgroundColor = .systemBackground
                
        //버튼 글시 커스텀
        bar.buttons.customize{ button in
            button.tintColor = UIColor(red: 101/255, green: 101/255, blue: 101/255, alpha: 1.0) /* #656565 */
            button.selectedTintColor = .black
            button.font = .systemFont(ofSize: 14)
        }
        //indicator
        bar.indicator.weight = .custom(value: 1)
        bar.indicator.overscrollBehavior = .bounce
        bar.indicator.tintColor = .black

        addBar(bar, dataSource: self, at:.top)
    }
    
    
}

extension DetailMeetingTabController: PageboyViewControllerDataSource, TMBarDataSource{
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        
        switch index {
        case 0:
            return TMBarItem(title: "홈")
        case 1:
            return TMBarItem(title: "채팅")
        default:
            return TMBarItem(title: "wrong")
        }
        
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? { return nil }
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int { return viewControllers.count }
    
}
