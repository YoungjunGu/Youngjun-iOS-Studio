import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - 여기 options에 원하는 option넣기.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert], completionHandler: { (didAllow, error) in
            
        })
        UNUserNotificationCenter.current().delegate = self
    }
    
    @IBAction func buttonPressed(_ sender: UIButton){
        
        // 알림 콘텐츠 객체
        // 속성을 수정 가능한 mutable 객체로 생성
        let notiContents = UNMutableNotificationContent()
        notiContents.badge = 1
        notiContents.title = "로컬 알림 메시지"
        notiContents.subtitle = "앱을 다시 실행시켜보세요. 많은 메시지들이 도착했습니다."
        notiContents.body = "읽지 않는 메시지들이 9241개 있습니다."
        notiContents.sound = UNNotificationSound.default
        notiContents.userInfo = ["name": "구영준"]
        
        // notification 에 이미지 삽입
        let imageName = "applelogo"
        guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") else {
            print("image 데이터가 없습니다")
            return
        }
        let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
        
        notiContents.attachments = [attachment]
        
        // 알림 발송 조건 객체
        // 발송 시간과 반복 조건 설정
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // 알림 요청 객체
        // 매개변수로 알림 콘텐츠 객체와 알림 발송 조건 객체를 넘겨주는 것을 확인 가능
        let request = UNNotificationRequest(identifier: "wakeup", content: notiContents, trigger: trigger)
        
        // 노티피케이션 Center에 추가
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
}
extension ViewController : UNUserNotificationCenterDelegate{
    //To display notifications when app is running  inforeground
    
    //앱이 foreground에 있을 때. 즉 앱안에 있어도 push알림을 받게 해준다.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        let settingsViewController = UIViewController()
        settingsViewController.view.backgroundColor = .gray
        self.present(settingsViewController, animated: true, completion: nil)
        
    }
    
    
}
