//
//  AppDelegate.swift
//  RF
//
//  Created by 이정동 on 2023/07/02.
//

import UIKit
import UserNotifications
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 앱이 시작될 때마다 푸시 알림 등록을 시도
        registerForPushNotifications()
        
        // Realm Schema Version 설정
        configureSchemaVersion(5)
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // 알림을 위해 서버에 디바이스 토큰 등록
    // registerForRemoteNotifications()가 성공할 때마다 iOS에서 호출
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        UserDefaults.standard.setValue(token, forKey: "deviceToken")
        print("Device Token: \(token)")
    }
    
    // 디바이스 토큰 등록 실패 처리
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func registerForPushNotifications() {
        // 1 - UNUserNotificationCenter는 푸시 알림을 포함하여 앱의 모든 알림 관련 활동을 처리합니다.
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current()
        // 2 - 알림을 표시하기 위한 승인을 요청합니다. 전달된 옵션은 앱에서 사용하려는 알림 유형을 나타냅니다. 여기에서 알림(alert), 소리(sound) 및 배지(badge)를 요청합니다.
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                // 3 - 완료 핸들러는 인증이 성공했는지 여부를 나타내는 Bool을 수신합니다. 인증 결과를 표시합니다.
                print("Permission granted: \(granted)")
                
                guard granted else { return }
                self.getNotificationSettings()
            }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            //print("Notification settings: \(settings)")
            
            // 사용자가 알림 권한을 부여했는지 확인
            guard settings.authorizationStatus == .authorized else { return }
            
            DispatchQueue.main.async {
                // (사용자가 권한을 부여했다면) Apple 푸시 알림 서비스에 등록을 시작
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    private func configureSchemaVersion(_ ver: UInt64) {
        let config = Realm.Configuration(schemaVersion: ver)
        Realm.Configuration.defaultConfiguration = config
        let _ = try! Realm()
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // foreground 상태일 때에도 알림 배너가 나오도록 설정
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(#function)
        let userInfo = notification.request.content.userInfo
        completionHandler([])
    }
    
    // 푸시 알림 배너 클릭했을 시 실행
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        navigateToSpecificScreen(userInfo)
        completionHandler()
    }
    
    // 특정 화면으로 이동하도록 설정
    func navigateToSpecificScreen(_ userInfo: [AnyHashable: Any]) {
        // 푸시 알림에 포함된 채팅방 정보를 가져옵니다.
//        if let chatRoomId = userInfo["chatRoomId"] as? String {
//            // AppDelegate가 UITabBarController를 참조할 수 있도록 합니다.
//            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
//                  let tabBarController = window.rootViewController as? TabBarController else {
//                return
//            }
//            
//            // 탭의 인덱스를 선택
//            tabBarController.selectedIndex = 2 // 커뮤니티 탭 생기기 전까지 2, 생긴 후 : 3
//            
//            if let navController = tabBarController.selectedViewController as? UINavigationController {
//                // 기존 뷰 컨트롤러를 모두 제거하고 ChatListVC로 이동합니다.
//                navController.popToRootViewController(animated: false)
//                
//                // 새 채팅방 화면 인스턴스를 만듭니다.
//                let chatRoomVC = ChatRoomViewController()
//                
//                let index = SingletonChannel.shared.readNewMessage(1)
//                
//                // 채팅방 화면에 chatRoomId 값을 전달합니다 (이름은 적절하게 변경할 수 있습니다).
//                chatRoomVC.channel = SingletonChannel.shared.list[0]
//                chatRoomVC.row = index
//                
//                
//                // 채팅방으로 이동하는 로직 작성
//                navController.pushViewController(chatRoomVC, animated: true)
//            }
//        }
    }
    
}
