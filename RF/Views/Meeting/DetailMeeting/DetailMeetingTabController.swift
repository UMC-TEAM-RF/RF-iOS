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
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "다국적 사람들과 소통해요!", style: .done, target: self, action: nil)
        
        btn.isEnabled = false
        btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20,weight: .bold)], for: .disabled)
        return btn
    }()
    
    /// MARK: 카톡, 메시지, 인스타그램 공유 버튼
    private lazy var firstButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    /// MARK: 카톡, 메시지, 인스타그램 공유 버튼
    private lazy var secondButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        btn.tintColor = .black
        return btn
    }()
   
    private let disposeBag = DisposeBag()
    private var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = false
        clickedButtons()
        
        addSubviews()
    }
    
    /// Add UI
    private func addSubviews(){
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = .black
        
        setRightBarButtons()
        
        let homeController = DetailMeetingHomeController()
        let chatController = DetailMeetingChatController()
        
        viewControllers.append(homeController)
        viewControllers.append(chatController)
        
        self.dataSource = self
        customTabBar()
    }
    
    /// MARK: 네비게이션 바 오른쪽 버튼들
    private func setRightBarButtons(){
        let firstBarButton = UIBarButtonItem(customView: firstButton)
        let secondBarButton = UIBarButtonItem(customView: secondButton)
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0)
        
        firstButton.configuration = configuration
        secondButton.configuration = configuration
        
        navigationItem.rightBarButtonItems = [secondBarButton, firstBarButton]
    }
    
    /// MARK: TabBar Custom
    private func customTabBar(){
        let bar = TMBar.ButtonBar()

        //탭바 레이아웃 설정
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        
                
        //배경색
        bar.backgroundView.style = .clear
        bar.backgroundColor = .systemBackground
                
        //버튼 글시 커스텀
        bar.buttons.customize{ button in
            button.tintColor = UIColor(hexCode: "656565")
            button.selectedTintColor = .black
            button.font = .systemFont(ofSize: 14)
        }
        
        //indicator
        bar.indicator.weight = .custom(value: 1)
        bar.indicator.overscrollBehavior = .bounce
        bar.indicator.tintColor = .black

        addBar(bar, dataSource: self, at:.top)
    }
    
    
    /// MARK: 버튼 클릭 시
    private func clickedButtons(){
        
        firstButton.rx.tap
            .bind {
                print("clicked information button")
            }
            .disposed(by: disposeBag)
        
        secondButton.rx.tap
            .bind {
                print("clicked share button")
            }
            .disposed(by: disposeBag)
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
