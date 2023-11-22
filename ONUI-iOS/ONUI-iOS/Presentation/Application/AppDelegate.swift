import Firebase
import GoogleSignIn
import Combine
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // 앱이 켜졌을때
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let config = GIDConfiguration(clientID: "797489065606-app51ou4l1ngvs2d9j0ikkom79fuateb.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.configuration = config
        
        // Use Firebase library to configure APIs
        // 파이어베이스 설정
        FirebaseApp.configure()
        
        // 원격 알림 등록
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
        
        // 메세징 델리겟
        Messaging.messaging().delegate = self
        
        
        // 푸시 포그라운드 설정
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    // fcm 토큰이 등록 되었을 때
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        print(deviceTokenString)
        Messaging.messaging().apnsToken = deviceToken
        var bag = Set<AnyCancellable>()
        let sendDeviceTokenUseCase = DI.container.resolve(SendDeviceTokenUseCase.self)!
        sendDeviceTokenUseCase.execute(token: deviceTokenString).sink(receiveCompletion: { _ in }, receiveValue: { _ in }).store(in: &bag)
    }
    
}

extension AppDelegate : MessagingDelegate {
    
    // fcm 등록 토큰을 받았을 때
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("AppDelegate - 파베 토큰을 받았다.")
        print("AppDelegate - Firebase registration token: \(String(describing: fcmToken))")
        messaging.token { token, error in
            print(token, error)
        }
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // 푸시메세지가 앱이 켜져 있을때 나올때
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        print("willPresent: userInfo: ", userInfo)
        
        completionHandler([.banner, .sound, .badge])
    }
    
    // 푸시메세지를 받았을 때
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("didReceive: userInfo: ", userInfo)
        completionHandler()
    }
    
}
