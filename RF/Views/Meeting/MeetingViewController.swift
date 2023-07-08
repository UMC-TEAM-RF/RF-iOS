//
//  MeetingViewController.swift
//  RF
//
//  Created by 정호진 on 2023/07/06.
//

import Foundation
import SnapKit
import UIKit
import RxSwift
import RxCocoa

final class MeetingViewController: UIViewController{
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        addSubviews()
        clickedTopBtns()
    }
    
    // MARK: 모임 제목 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "모임"
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    // MARK: 모임 찾기 버튼
    private lazy var searchMeetingBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "magnifyingglass")?.resize(newWidth: 25), for: .normal)
        return btn
    }()
    
    // MARK: 모임 생성 버튼
    private lazy var createMeetingBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus")?.resize(newWidth: 25), for: .normal)
        return btn
    }()
    
    // MARK: 모임 찾기 버튼, 모임 생성 버튼 담는 StackView
    private lazy var btnsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [searchMeetingBtn, createMeetingBtn])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .systemBackground
        stack.spacing = 10
        return stack
    }()
    
    // MARK: 모임 찾기, 모임 생성하기 UIView
    private lazy var makeFriendView: MakeFriendUIView = {
        let view = MakeFriendUIView()
        view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0) /* #f9f9f9 */
        view.layer.cornerRadius = 20
        return view
    }()
    
    // MARK: add UI
    private func addSubviews(){
        view.addSubview(titleLabel)
        view.addSubview(btnsStackView)
        view.addSubview(makeFriendView)
        
        configureConstraints()
        uiActions()
    }
    
    // MARK: setting AutoLayout
    private func configureConstraints(){
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        btnsStackView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        makeFriendView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height*2/5)
        }
    }
    
    // MARK:
    private func uiActions(){
        makeFriendView.inputData(height: view.safeAreaLayoutGuide.layoutFrame.width)
        makeFriendView.delegate = self
    }
    
    // MARK: 모임 찾기, 모임 생성 버튼 눌렀을 때
    private func clickedTopBtns(){
        searchMeetingBtn.rx.tap
            .subscribe(onNext:{
                print("clicked searchMeetingBtn")
            })
            .disposed(by: disposeBag)
        
        createMeetingBtn.rx.tap
            .subscribe(onNext:{
                print("clicked createMeetingBtn")
            })
            .disposed(by: disposeBag)
    }
    
    
    
}

extension MeetingViewController: ClickedBtns{
    /// true -> 모임 찾기 버튼
    /// false -> 모임 생성하기
    func clickedBtns(check: Bool) {
        if check{
            print("clicked searchMeeting")
        }
        else{
            print("clicked createMeeting")
        }
    }
    
}


// 파일 옮기기
extension UIImage {
    // MARK: 이미지 크기 재배치 하는 함수
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return renderImage
    }
    
    // MARK: 이미지 크기 (강제)재배치 하는 함수
    func resize(newWidth: CGFloat, newHeight: CGFloat) -> UIImage {
        
        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return renderImage
    }
    
}

