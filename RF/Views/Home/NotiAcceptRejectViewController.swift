//
//  NotiAcceptRejectViewController.swift
//  RF
//
//  Created by 정호진 on 2023/08/11.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
import SnapKit

final class NotiAcceptRejectViewController: UIViewController {
    
    
    /// MARK: 네비게이션 바 왼쪽 아이템
    private lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: " ", style: .done, target: self, action: nil)
        btn.isEnabled = false
        btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)], for: .disabled)
        return btn
    }()
    
    /// MARK: 알림 라벨
    private lazy var noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "24시간 이내에 수락 혹은 거절 버튼을 눌러주세요!"
        return label
    }()
    
    /// MARK: 해당 모임에 신청한 사람들 리스트
    private lazy var listTableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    var titleRelay: BehaviorRelay<String> = BehaviorRelay(value: "")
    private let viewModel = NotiAcceptRejectViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = .black
        
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
        addSubviews()
        bind()
    }
    
    
    // MARK: - addSubviews
    
    private func addSubviews() {
        view.addSubview(noticeLabel)
        view.addSubview(listTableView)
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(NotiAcceptRejectTableViewCell.self, forCellReuseIdentifier: NotiAcceptRejectTableViewCell.identifier)
        
        configureConstraints()
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        noticeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        listTableView.snp.makeConstraints { make in
            make.top.equalTo(noticeLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    // MARK: - bind
    
    /// MARK:
    private func bind() {
        titleRelay.bind { [weak self] title in
            self?.leftButton.title = title
        }
        .disposed(by: disposeBag)
    }
    
    
}

extension NotiAcceptRejectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotiAcceptRejectTableViewCell.identifier, for: indexPath) as? NotiAcceptRejectTableViewCell else {return UITableViewCell()}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.safeAreaLayoutGuide.layoutFrame.height/4
    }
    
}

import SwiftUI

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif

import SwiftUI
struct VCPreViewNotiAcceptRejectViewController:PreviewProvider {
    static var previews: some View {
        NotiAcceptRejectViewController().toPreview().previewDevice("iPhone 14 Pro")
        // 실행할 ViewController이름 구분해서 잘 지정하기
    }
}
struct VCPreViewNotiAcceptRejectViewController2:PreviewProvider {
    static var previews: some View {
        NotiAcceptRejectViewController().toPreview().previewDevice("iPhone 11")
        // 실행할 ViewController이름 구분해서 잘 지정하기
    }
}
