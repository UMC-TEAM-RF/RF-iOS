//
//  PickerViewController.swift
//  RF
//
//  Created by 이정동 on 2023/07/31.
//

import UIKit
import SnapKit

class PickerViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var toolbar: UIToolbar = {
        let tb = UIToolbar()
        tb.sizeToFit()
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        tb.setItems([flexibleSpace, doneButton], animated: false)
        return tb
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = .white
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    
    // MARK: - Property
    
    var delegate: ToolbarDelegate?
    
    private let tag: Int // 선호 연령대, 사용 언어를 구분하기 위함
    
    private var pickerValues: [String]
    private var selectedValue: String = ""
    
    init(tag: Int) {
        self.tag = tag
        self.pickerValues = tag == 0 ? AgeGroup.list : Language.list
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        
        addSubviews()
        configureConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(toolbar)
        view.addSubview(pickerView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        pickerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(250)
        }
        
        toolbar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(pickerView.snp.top)
            make.height.equalTo(45)
        }
    }

    @objc func doneButtonTapped() {
        delegate?.didTapDoneButton(tag: self.tag, value: self.selectedValue)
        dismiss(animated: true, completion: nil)
    }
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }

    // UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = pickerValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
}
