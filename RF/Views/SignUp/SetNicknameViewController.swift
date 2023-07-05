//
//  SetNicknameViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/03.
//

import UIKit

class SetNicknameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //닉네임 문구
        let Nickname_label = UILabel(frame: CGRect(x: 30, y: 95, width: 240, height: 24))
        Nickname_label.text = "닉네임을 설정해주세요."
        let Sub_label = UILabel(frame: CGRect(x: 30, y: 140, width: 232, height: 15))
        Sub_label.text = "닉네임은 알프 이용 시 나타나게 되요."
        // 왼쪽 정렬 설정
        Nickname_label.textAlignment = .left
        Sub_label.textAlignment = .left
        //Sub_label_글씨체 정보
        let Sub_label_FontDescriptor = UIFont.systemFont(ofSize: 15, weight: .regular).fontDescriptor
        let Sub_label_Font = UIFont(descriptor: Sub_label_FontDescriptor, size: 15)
        Sub_label.font = Sub_label_Font
        // Nickname_label_글씨체 정보
        let Nickname_label_FontDescriptor = UIFont.systemFont(ofSize: 24, weight: .bold).fontDescriptor
        let Nickname_label_Font = UIFont(descriptor: Nickname_label_FontDescriptor, size: 24)
        Nickname_label.font = Nickname_label_Font
        //sub_label color
        Sub_label.textColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1.0)
        
        //입력창
        let textField = UITextField(frame: CGRect(x: 30, y: 194, width: 269, height: 55))
        textField.borderStyle = .roundedRect
        textField.borderStyle = .none
        textField.placeholder = "   닉네임을 입력해주세요" // 입력창에 나타날 플레이스홀더 텍스트 설정
        //sub_label color
        textField.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        //sub_label color
        textField.textColor = UIColor(red: 129/255, green: 129/255, blue: 129/255, alpha: 1.0)
        textField.layer.cornerRadius = 5
        
        let NoEdit_label = UILabel(frame: CGRect(x: 53, y: 727, width: 274, height: 14))
        NoEdit_label.text = "이후 변경할 수 없으니 정확히 선택해 주세요."
        NoEdit_label.textAlignment = .center
        let NoEdit_label_FontDescriptor = UIFont.systemFont(ofSize: 15, weight: .regular).fontDescriptor
        let NoEdit_label_Font = UIFont(descriptor: NoEdit_label_FontDescriptor, size: 15)
        NoEdit_label.font = NoEdit_label_Font
        NoEdit_label.textColor = UIColor(red: 162/255, green: 161/255, blue: 161/255, alpha: 1.0)
        
        let check_button = UIButton(type: .system)
        let check_button_text = UIColor(red: 60/255, green: 58/255, blue: 58/255, alpha: 1.0)
        check_button.frame = CGRect(x: 30, y: 750, width: 330, height: 47)
        check_button.setTitle("다음", for: .normal)
        check_button.setTitleColor(check_button_text, for: .normal)
        check_button.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        check_button.layer.cornerRadius = 5
               
        self.view.addSubview(Nickname_label)
        self.view.addSubview(Sub_label)
        self.view.addSubview(NoEdit_label)
        self.view.addSubview(textField)
        self.view.addSubview(check_button)
        
        view.backgroundColor = .systemBackground
    }
}
