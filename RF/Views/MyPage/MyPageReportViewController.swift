//
//  MyPageReportViewController.swift
//  RF
//
//  Created by 용용이 on 2023/10/10.
//

import Foundation
import UIKit
import SnapKit
import Tabman
import Pageboy

class MyPageReportViewController: TabmanViewController {

    private var viewControllers: Array<UIViewController> = []
    let TabbarTitle : [String] = ["신고 접수", "신고 내역"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers.append(MyPageReportApplyViewController())
        viewControllers.append(MyPageReportSecondTabViewController())
        
        self.dataSource = self

        // Create bar
        let bar = TMBar.ButtonBar()
        bar.layout.contentMode = .fit
        bar.layout.transitionStyle = .snap // Customize

        // Add to view
        addBar(bar, dataSource: self, at: .top)
    }

}
extension MyPageReportViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = self.TabbarTitle[index]
        // ↑↑ 이미지는 이따가 탭바 형식으로 보여줄 때 사용할 것이니 "이미지가 왜 있지?" 하지말고 넘어가주세요.
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}




// MARK: - MyPageReportSecondTabViewController
class MyPageReportSecondTabViewController: UIViewController {
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "추후 구현 예정"
        label.font = .systemFont(ofSize: 14)
        label.textColor = TextColor.first.color
        return label
    }()
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
