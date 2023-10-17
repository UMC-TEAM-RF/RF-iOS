//
//  ChatRoomViewController.swift
//  RF
//
//  Created by 이정동 on 2023/08/04.
//

import UIKit
import SnapKit
import PhotosUI

final class ChatRoomViewController: UIViewController {
    
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
        sv.backgroundColor = ButtonColor.normal.color
        sv.isHidden = true
        return sv
    }()
    
    private lazy var sourceLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle("한국어 ", for: .normal)
        button.setTitleColor(TextColor.secondary.color, for: .normal)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = TextColor.secondary.color
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private lazy var targetLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle("영어 ", for: .normal)
        button.setTitleColor(TextColor.secondary.color, for: .normal)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = TextColor.secondary.color
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private lazy var swapLanguageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left.arrow.right"), for: .normal)
        button.tintColor = TextColor.secondary.color
        return button
    }()
    
    private lazy var messagesTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(MyMessageTableViewCell.self, forCellReuseIdentifier: MyMessageTableViewCell.identifier)
        tv.register(OtherMessageTableViewCell.self, forCellReuseIdentifier: OtherMessageTableViewCell.identifier)
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
    
    private var isKeyboardShow: Bool = false
    
    private var keyboardRect: CGRect = CGRect()
    
    private var loginUser = UserRepository.shared.getUser()
    
    var channel: RealmChannel!
    
    /// 선택한 이미지들
    private var selectedPhotoImages: [UIImage] = []
    var row: Int?
    
    
    // MARK: - deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupCustomBackButton()
        updateTitleView(title: channel.name)
        
        addSubviews()
        configureConstraints()
        addTargets()
        configureNotificationCenter()
        
        DispatchQueue.main.async {
            self.messagesTableView.scrollToRow(at: IndexPath(row: self.row ?? 0, section: 0), at: .bottom, animated: false)
        }
    }
    
    // MARK: - viewWillAppear()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
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
    
    private func configureNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NotificationName.keyboardWillShow , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NotificationName.keyboardWillHide, object: nil)
        
        // 새로운 메시지가 왔을 때 알림
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateChat), name: NotificationName.updateChatRoom, object: nil)
    }
    
    private func scrollToBottom() {
        //        if channel.messages.isEmpty { return }
        //        messagesTableView.scrollToRow(at: IndexPath(row: channel.messages.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    /// 한 사람이 연속해서 메시지를 보내는지 체크
    /// - Parameter indexPath: indexPath
    /// - Returns: true: 연속, false: 비연속
    private func isSenderConsecutiveMessages(row: Int) -> Bool {
        if row <= 0 { return false }
        let currentId = channel.messages[row].speaker?.id
        let beforeId = channel.messages[row - 1].speaker?.id
        
        return currentId == beforeId ? true : false
    }
    
    private func isLastIndexPathVisible() -> Bool {
        // 현재 보이는 indexPath 목록
        guard let visibleIndexPaths = messagesTableView.indexPathsForVisibleRows else {
            return false
        }
        
        // 마지막 섹션을 가져오고 해당 섹션의 마지막 셀의 row 수를 얻는다
        let lastSection = messagesTableView.numberOfSections - 1
        let lastRowInLastSection = messagesTableView.numberOfRows(inSection: lastSection) - 1
        
        // 마지막 indexPath 생성
        let lastIndexPath = IndexPath(row: lastRowInLastSection, section: lastSection)
        
        // 마지막 indexPath가 현재 보이는 셀 중 하나인지 확인
        return visibleIndexPaths.contains(lastIndexPath)
    }
    
    private func isSenderSelf(_ sender: RealmSender?) -> Bool {
        guard let sender else { return false }
        
        return sender.id == self.loginUser.id
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
    
    // MARK: - [추가 고민 필요]
    @objc func updateChat() {
        // 채팅 메시지 업데이트 시 화면 업데이트
        self.row = ChatRepository.shared.readNewMessages(self.channel.id)
        channel = ChatRepository.shared.getChannel(self.channel.id)
        
        // reload 하기 전 내가 현재 마지막 셀에 위치해 있는지 확인
        let isVisible = isLastIndexPathVisible()
        
        messagesTableView.reloadData()
        
        if isVisible { // 마지막 메시지에 위치해 있으면 자동 스크롤
            scrollToBottom()
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
        let vc = PickerViewController(tag: 0, pickerValues: Language.getLanguageList())
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @objc func targetLanguageButtonTapped() {
        let vc = PickerViewController(tag: 1, pickerValues: Language.getLanguageList())
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    /// 사진 앱에서 사진 선택
    private func selectedPhoto() {
        if #available(iOS 14, *){
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 10
            configuration.filter = .any(of: [.images])
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            let nvPicker = UINavigationController(rootViewController: picker)
            nvPicker.modalPresentationStyle = .fullScreen
            present(nvPicker,animated: false)
        }
        else {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    /// MARK: 카메라로 사진 찍기
    private func takePhoto(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    /// MARK: 일정 생성
    private func createCalendar(){
        let createCalendarViewController = CreateCalendarViewController()
        navigationController?.pushViewController(createCalendarViewController, animated: true)
    }
}

// MARK: - Ext: TableView

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = channel.messages[indexPath.row]
        
        if isSenderSelf(message.speaker) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyMessageTableViewCell.identifier, for: indexPath) as? MyMessageTableViewCell else { return UITableViewCell() }
            
            cell.updateChatView(message)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherMessageTableViewCell.identifier, for: indexPath) as? OtherMessageTableViewCell else { return UITableViewCell() }
            
            // MARK: - [수정 필요] userProfileUrl 및 userLangCode 적용
            cell.updateChatView(message: message, userLangCode: "ko", indexPath: indexPath)
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
        
        //        let contentOffsetY = scrollView.contentOffset.y
        //        let contentHeight = scrollView.contentSize.height
        //        let scrollViewHeight = scrollView.bounds.height
        //
        //        // 뱅크 뷰가 나타날 위치를 계산합니다.
        //        let bankViewY = contentHeight - scrollViewHeight + 50
        //
        //        UIView.animate(withDuration: 0.3) {
        //            let alpha = (contentOffsetY >= bankViewY - 100) ? 0.0 : 0.8
        //            self.scrollToBottomButton.alpha = alpha
        //        }
    }
}


// MARK: - Ext: KeyboardInputBarDelegate

extension ChatRoomViewController: KeyboardInputBarDelegate {
    
    func didTapPlus() {
        
        let keyboardInputView = KeyboardInputView(frame: keyboardRect)
        keyboardInputView.delegate = self
        keyboardInputBar.keyboardInputView = keyboardInputView
    }
    
    // MARK: - Message Type에 따른 조건 처리 필요
    func didTapSend(_ text: String, isTranslated: Bool) {
        if isTranslated { translateMessage(text) } // 번역 버튼 클릭인 경우
        else { sendMessage(text) } // 메시지 전송 버튼 클릭인 경우
        
        inputBarTopStackView.isHidden = true
    }
    
    func didTapTranslate(_ isTranslated: Bool) {
        let height = isTranslated ? 40 : 0
        inputBarTopStackView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
        
        inputBarTopStackView.isHidden = !isTranslated
    }
    
    private func translateMessage(_ text: String) {
        // 1. 번역
        let sourceLanguage = sourceLanguageButton.currentTitle?.trimmingCharacters(in: .whitespaces)
        let targetLanguage = targetLanguageButton.currentTitle?.trimmingCharacters(in: .whitespaces)
        
        guard let source = Language.getLanguageCode(sourceLanguage!) else { return }
        guard let target = Language.getLanguageCode(targetLanguage!) else { return }
        
        PapagoService.shared.translateMessage(source: source, target: target, text: text) { result in
            // 2. keyboardInputBar.inputField.text = "번역된 텍스트"
            self.keyboardInputBar.inputFieldText = result
        }
    }
    
    private func sendMessage(_ text: String) {
        // 메시지 전송 전 언어 코드 확인
        PapagoService.shared.detectLanguage(text) { result in
            // 언어 코드 확인 후 메시지 전송
            ChatService.shared.send(
                message: Message(
                    sender: Sender(
                        userId: self.loginUser.id,
                        userName: self.loginUser.nickname,
                        userImageUrl: self.loginUser.profileImageUrl
                    ),
                    type: MessageType.text,
                    content: text,
                    langCode: result,
                    partyName: "",
                    partyId: self.channel.id),
                partyId: self.channel.id
            )
        }
    }
}

// MARK: - Ext: MessageTableViewCellDelegate

extension ChatRoomViewController: MessageTableViewCellDelegate {
    // 메시지 뷰 롱 프레스
    func longPressedMessageView(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: messagesTableView)
        
    }
    
    // 메시지 번역 버튼 클릭
    // 번역 안된 경우, 번역된 메시지를 보여주는 상태, 번역되기 전 메시지를 보여주는 상태
    func convertMessage(_ indexPath: IndexPath) {
        let message = channel.messages[indexPath.row]
        
        if message.translatedContent == nil { // 번역을 한번도 하지 않은 상태
            if !Language.listWithCode.keys.contains(message.langCode!) { return }
            
            let text = channel.messages[indexPath.row].content!
            
            // MARK: - [수정 필요] 로그인 유저의 언어 코드에 맞춤 필요
            PapagoService.shared.translateMessage(source: message.langCode!, target: "ko", text: text) { str in
                
                ChatRepository.shared.addTranslatedContent(message: message, content: str)
                
                DispatchQueue.main.async {
                    self.messagesTableView.reloadRows(at: [indexPath], with: .fade)
                }
            }
        } else {
            ChatRepository.shared.toggleIsTranslated(message: message)
            self.messagesTableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
}


// MARK: - Ext: SendDataDelegate

extension ChatRoomViewController: SendDataDelegate {
    // PickerViewController로 부터 전달받은 데이터
    func sendData(tag: Int, data: String) {
        let button = tag == 0 ? sourceLanguageButton : targetLanguageButton
        button.setTitle("\(data) ", for: .normal)
    }
    
    func sendTagData(tag: Int) {
        switch tag {
        case 0: // 사진 선택
            selectedPhoto()
        case 1: // 카메라
            takePhoto()
        case 2: // 일정
            createCalendar()
        default:
            print("잘못 접근")
        }
    }
}

extension ChatRoomViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectedPhotoImages.removeAll()
            selectedPhotoImages.append(image)
        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Ext: PHPickerViewControllerDelegate

extension ChatRoomViewController: PHPickerViewControllerDelegate {
    
    func getArrayOfBytesFromImage(imageData: Data) -> [NSNumber] {
        // the number of elements:
        let count = imageData.count
        
        // create array of appropriate length:
        var bytes = [UInt8](repeating: 0, count: count)
        
        // copy bytes into array
        imageData.copyBytes(to: &bytes, count: count)
        
        var byteArray: [NSNumber] = []
        
        for i in 0..<count {
            byteArray.append(NSNumber(value: bytes[i]))
        }
        
        return byteArray
    }
    
    /// 사진을 선택완료 했을 때 실행
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        selectedPhotoImages.removeAll()
        dismiss(animated: true)
        
        results.forEach { result in
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                    if let image = image as? UIImage {
                        
                        print(self?.getArrayOfBytesFromImage(imageData: image.pngData() ?? Data()))
                        print("\n")
                        print(image.pngData())
                    }
                    self?.selectedPhotoImages.append(image as? UIImage ?? UIImage())
                }
            }
        }
    }
    
    /// 취소버튼 누른 경우
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
