//
//  ChatRoomViewController.swift
//  RF
//
//  Created by 이정동 on 2023/08/04.
//

import UIKit
import SnapKit

struct CustomMessage {
    var sender: CustomSender
    var sentDate: Date
    var content: String
}

struct CustomSender {
    var photoUrlString: String?
    var senderId: String
    var displayName: String
}

class ChatRoomViewController: UIViewController {
    
    // 메시지 입력 창
    private lazy var keyboardInputBar: KeyboardInputBar = {
        let bar = KeyboardInputBar()
        bar.delegate = self
        return bar
    }()
    
    // 번역 언어 설정 화면
    private lazy var inputBarTopStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 0
        sv.distribution = .fill
        sv.alignment = .fill
        sv.backgroundColor = .white
        sv.isHidden = true
        return sv
    }()
    
    private lazy var sourceLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle("한국어 ", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .lightGray
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private lazy var targetLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle("영어 ", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .lightGray
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private lazy var swapLanguageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left.arrow.right"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    private lazy var messagesTableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        return tv
    }()
    
    // scrollToBottom 버튼
    private lazy var scrollToBottomButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.tintColor = .white
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.alpha = 0
        button.layer.cornerRadius = 20
        return button
    }()
    
    // 키보드 뒤에 숨겨지는 뷰
    private lazy var bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Property
    
    private var tapGesture = UITapGestureRecognizer()
    
    var editMenuInteraction: UIEditMenuInteraction?
    
    var messages: [CustomMessage] = [
        CustomMessage(sender: CustomSender(senderId: "1", displayName: "JD"), sentDate: Date(), content: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
        CustomMessage(sender: CustomSender(senderId: "1", displayName: "JD"), sentDate: Date(), content: "t has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
        CustomMessage(sender: CustomSender(senderId: "2", displayName: "망고"), sentDate: Date(), content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout"),
        CustomMessage(sender: CustomSender(senderId: "3", displayName: "제이디"), sentDate: Date(), content: "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..."),
        CustomMessage(sender: CustomSender(senderId: "4", displayName: "만자"), sentDate: Date(), content: "Contrary to popular belief, Lorem Ipsum is not simply random text."),
        CustomMessage(sender: CustomSender(senderId: "2", displayName: "망고"), sentDate: Date(), content: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
        CustomMessage(sender: CustomSender(senderId: "2", displayName: "망고"), sentDate: Date(), content: "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested."),
        CustomMessage(sender: CustomSender(senderId: "2", displayName: "망고"), sentDate: Date(), content: "FC BARCELONA EL CLASICO FRENKIE DE JONG PEDRI GAVI SPAIN LA LIGA"),
        CustomMessage(sender: CustomSender(senderId: "4", displayName: "만자"), sentDate: Date(), content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
        CustomMessage(sender: CustomSender(senderId: "3", displayName: "제이디"), sentDate: Date(), content: "테스트"),
        CustomMessage(sender: CustomSender(senderId: "3", displayName: "제이디"), sentDate: Date(), content: "테스트"),
        CustomMessage(sender: CustomSender(senderId: "4", displayName: "만자"), sentDate: Date(), content: "테스트"),
        CustomMessage(sender: CustomSender(senderId: "4", displayName: "만자"), sentDate: Date(), content: "테스트"),
        CustomMessage(sender: CustomSender(senderId: "4", displayName: "만자"), sentDate: Date(), content: "테스트"),
        
    ]
    
    private var isKeyboardShow: Bool = false
    
    private var keyboardRect: CGRect = CGRect()
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setupCustomBackButton()
        updateTitleView(title: "Channel")
        
        
        addSubviews()
        configureConstraints()
        addTargets()
        configureTableView()
        
        editMenuInteraction = UIEditMenuInteraction(delegate: self)
        messagesTableView.addInteraction(editMenuInteraction!)
        
        DispatchQueue.main.async {
            self.scrollToBottom()
        }
    }
    
    // MARK: - viewWillAppear()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - viewWillDisappear()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - addSubviews()
    
    private func addSubviews() {
        view.addSubview(keyboardInputBar)
        view.addSubview(messagesTableView)
        view.addSubview(inputBarTopStackView)
        
        inputBarTopStackView.addArrangedSubview(sourceLanguageButton)
        inputBarTopStackView.addArrangedSubview(swapLanguageButton)
        inputBarTopStackView.addArrangedSubview(targetLanguageButton)
        
        view.addSubview(scrollToBottomButton)
        view.bringSubviewToFront(scrollToBottomButton)
        
        view.addSubview(bottomView)
    }
    
    // MARK: - configureConstraints()
    
    private func configureConstraints() {
        keyboardInputBar.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        inputBarTopStackView.snp.makeConstraints { make in
            make.bottom.equalTo(keyboardInputBar.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0)
        }
        
        swapLanguageButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.1/0.5)
        }
        
        sourceLanguageButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2/0.5)
        }
        
        targetLanguageButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2/0.5)
        }
        
        messagesTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(keyboardInputBar.snp.top)
        }
        
        scrollToBottomButton.snp.makeConstraints { make in
            make.bottom.equalTo(inputBarTopStackView.snp.top).offset(-10)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(40)
        }
        
        bottomView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(0)
        }
    }
    
    // MARK: - addTargets()
    
    private func addTargets() {
        swapLanguageButton.addTarget(self, action: #selector(swapLanguageButtonTapped), for: .touchUpInside)
        
        scrollToBottomButton.addTarget(self, action: #selector(scrollToBottomButtonTapped), for: .touchUpInside)
        
        sourceLanguageButton.addTarget(self, action: #selector(sourceLanguageButtonTapped), for: .touchUpInside)
        
        targetLanguageButton.addTarget(self, action: #selector(targetLanguageButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - configureTableView()
    
    private func configureTableView() {
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        
        messagesTableView.register(MyMessageTableViewCell.self, forCellReuseIdentifier: MyMessageTableViewCell.identifier)
        messagesTableView.register(OtherMessageTableViewCell.self, forCellReuseIdentifier: OtherMessageTableViewCell.identifier)
    }
    
    private func scrollToBottom() {
        messagesTableView.scrollToRow(at: IndexPath(row: messages.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    /// 한 사람이 연속해서 메시지를 보내는지 체크
    /// - Parameter indexPath: indexPath
    /// - Returns: true: 연속, false: 비연속
    func isSenderConsecutiveMessages(row: Int) -> Bool {
        if row != 0 && (messages[row - 1].sender.senderId == messages[row].sender.senderId) { return true }
        else { return false }
    }
    
    // MARK: - @objc func
    
    // 키보드가 나타났다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillShow(_ notification: NSNotification){
        
        // keyboardwillShow가 키보드 열릴 때, 키보드 첫 입력할 때 총 2번 호출되고 있어서 이를 방지하고자 설정
        if isKeyboardShow { return }
        isKeyboardShow = true
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture) // 테이블 뷰에 추가해주기
        
        
        // 키보드의 높이만큼 화면을 올려준다.
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardRect = keyboardRectangle
            
            let safeAreaBottom = self.view.safeAreaInsets.bottom
            
            let diffHeight = keyboardRectangle.height - safeAreaBottom
            
            self.bottomView.snp.updateConstraints { make in
                make.height.equalTo(keyboardRectangle.height - safeAreaBottom)
            }
            
            var newContentOffset = messagesTableView.contentOffset
            newContentOffset.y = max(0, newContentOffset.y + diffHeight)
        
            messagesTableView.contentOffset = newContentOffset

            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ notification: NSNotification){
        
        isKeyboardShow = false
        
        view.removeGestureRecognizer(tapGesture)
        
        if let keyboardFrame:NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            let diffHeight = keyboardRectangle.height - view.safeAreaInsets.bottom
            
            self.bottomView.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
            
            var newContentOffset = messagesTableView.contentOffset
            newContentOffset.y = max(0, newContentOffset.y - diffHeight)
            
            messagesTableView.contentOffset = newContentOffset
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func swapLanguageButtonTapped() {
        let swap = targetLanguageButton.titleLabel?.text
        targetLanguageButton.setTitle(sourceLanguageButton.currentTitle, for: .normal)
        sourceLanguageButton.setTitle(swap, for: .normal)
    }
    
    @objc func scrollToBottomButtonTapped() {
        scrollToBottom()
    }
    
    @objc func sourceLanguageButtonTapped() {
        let vc = PickerViewController(tag: 0, pickerValues: Language.list)
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @objc func targetLanguageButtonTapped() {
        let vc = PickerViewController(tag: 1, pickerValues: Language.list)
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - Ext: TableView

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        if message.sender.senderId == "1" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyMessageTableViewCell.identifier, for: indexPath) as? MyMessageTableViewCell else { return UITableViewCell() }
    
            cell.message = message.content
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherMessageTableViewCell.identifier, for: indexPath) as? OtherMessageTableViewCell else { return UITableViewCell() }

            cell.message = message.content
            cell.displayName = message.sender.displayName
            cell.delegate = self

            if isSenderConsecutiveMessages(row: indexPath.row) { cell.isContinuous = true }
            else { cell.isContinuous = false }

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.bounds.height
        
        // 뱅크 뷰가 나타날 위치를 계산합니다.
        let bankViewY = contentHeight - scrollViewHeight + 50
        
        UIView.animate(withDuration: 0.3) {
            let alpha = (contentOffsetY >= bankViewY - 100) ? 0.0 : 0.8
            self.scrollToBottomButton.alpha = alpha
        }
    }
}

// MARK: - Ext:

extension ChatRoomViewController: UIEditMenuInteractionDelegate {
    func editMenuInteraction(_ interaction: UIEditMenuInteraction,
                             menuFor configuration: UIEditMenuConfiguration,
                             suggestedActions: [UIMenuElement]) -> UIMenu? {
        
        let customMenu = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "번역") { _ in
                print("번역")
            },
            UIAction(title: "답장") { _ in
                print("답장")
            },
            UIAction(title: "찜하기") { _ in
                print("찜하기")
            },
            UIAction(title: "신고") { _ in
                print("신고")
            }
        ])
        return UIMenu(children: customMenu.children) // For Custom Menu Only
    }
}

// MARK: - Ext: KeyboardInputBarDelegate

extension ChatRoomViewController: KeyboardInputBarDelegate {
    
    func didTapPlus() {
        let keyboardInputView = KeyboardInputView(frame: keyboardRect)
        keyboardInputBar.keyboardInputView = keyboardInputView
    }
    
    func didTapSend(_ text: String) {
        
        inputBarTopStackView.isHidden = true
        keyboardInputBar.isTranslated = false
        
        messages.append(CustomMessage(sender: CustomSender(senderId: "1", displayName: "JD"), sentDate: Date(), content: text))
        
        messagesTableView.reloadData()
        
        scrollToBottom()
    }
    
    func didTapTranslate(_ isTranslated: Bool) {
        let height = isTranslated ? 40 : 0
        inputBarTopStackView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
        
        inputBarTopStackView.isHidden = !isTranslated
    }
}

// MARK: - Ext: MessageTableViewCellDelegate

extension ChatRoomViewController: MessageTableViewCellDelegate {
    func messagePressed(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: messagesTableView)
        
        let conf = UIEditMenuConfiguration(identifier: "", sourcePoint: location)
        editMenuInteraction?.presentEditMenu(with: conf)
    }
}


// MARK: - Ext: SendDataDelegate

extension ChatRoomViewController: SendDataDelegate {
    func sendData(tag: Int, data: String) {
        let button = tag == 0 ? sourceLanguageButton : targetLanguageButton
        button.setTitle("\(data) ", for: .normal)
    }
}

