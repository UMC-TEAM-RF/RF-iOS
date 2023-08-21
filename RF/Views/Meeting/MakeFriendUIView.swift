//
//  MakeFriendUIView.swift
//  RF
//
//  Created by 정호진 on 2023/07/06.
//

import Foundation
import UIKit
import RxSwift

/// MARK: '새로운 친구 사귀기 좋은날 아닌가요?' 있는 View
final class MakeFriendUIView: UIView {
    
    /// MARK: 제목 라벨
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 친구 사귀기 좋은 날 아닌가요?"
        //label.font = .boldSystemFont(ofSize: 18)
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    /// MARK: 모임 찾기 버튼
    private lazy var searchMeetingBtn: MakeFreindUIButton = {
        let btn = MakeFreindUIButton()
        btn.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0) /* #f5f5f5 */
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    /// MARK: 모임 생성하기 버튼
    private lazy var createMeetingBtn: MakeFreindUIButton = {
        let btn = MakeFreindUIButton()
        btn.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0) /* #f5f5f5 */
        btn.layer.cornerRadius = 20
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    weak var delegate: SendDataDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    /// MARK: add UI
    private func addSubviews(height: CGFloat){
        addSubview(titleLabel)
        addSubview(searchMeetingBtn)
        addSubview(createMeetingBtn)
        configureConstraints(height: height)
    }
    
    /// MARK: setting AutoLayout
    private func configureConstraints(height: CGFloat){
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(30)
        }
        
        searchMeetingBtn.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(100)
        }
        
        createMeetingBtn.snp.makeConstraints { make in
            make.leading.equalTo(searchMeetingBtn.snp.leading)
            make.top.equalTo(searchMeetingBtn.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(100)
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    /// MARK: 각 버튼들 데이터 입력
    func inputData(height: CGFloat){
        addSubviews(height: height)
        clickedBtns()
        searchMeetingBtn.inputData(title: "모임 찾기 🔍",
                      description1: "나의 진정한 외국인 친구들을 찾아보세요.",
                      description2: "취미 생활도 함께 할 수 있어요!")
        
        createMeetingBtn.inputData(title: "모임 생성하기 🙌",
                      description1: "새로운 모임을 직접 만들어 보세요.",
                      description2: "1인당 최대 5개까지 만들 수 있어요.")
    }
    
    /// MARK: Clicked Buttons
    private func clickedBtns(){
        searchMeetingBtn.rx.tap
            .subscribe(onNext:{
                self.delegate?.sendBooleanData?(true)
            })
            .disposed(by: disposeBag)
        
        createMeetingBtn.rx.tap
            .subscribe(onNext:{
                self.delegate?.sendBooleanData?(false)
            })
            .disposed(by: disposeBag)
    }
    
    
}


