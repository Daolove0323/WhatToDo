//import Foundation
import UserNotifications
import RealmSwift

struct Notification {
    var id: String
    var title: String
//    var time: Date
}

class LocalNotificationManager: ObservableObject {
    var notifications = [Notification]()
    
    func requestPermission() -> Void {
    
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                if granted == true && error == nil {
                    // permission
                }
        }
    }
    
    func addNotification(id: ObjectId, title: String) -> Void {
        notifications.append(Notification(id: id.stringValue, title: title))
    }
    
    func schedule(_ time: Date) -> Void {
          UNUserNotificationCenter.current().getNotificationSettings { settings in
              switch settings.authorizationStatus {
              case .notDetermined:
                  self.requestPermission()
              case .authorized, .provisional:
                  self.scheduleNotifications(time)
              default:
                  break
            }
        }
        
    }
    
    func scheduleNotifications(_ time: Date) -> Void {
        
            let date = time
            let calendar = Calendar.current
        let components = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: date as Date)
        
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
          
            content.sound = UNNotificationSound.default
            content.subtitle = "Subtitle 입니다"
            content.body = "Body 입니다"
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Scheduling notification with id: \(notification.id)")
            }
        }
    }

    func setNotification(_ id: ObjectId, _ title: String, _ time: Date) -> Void {
        requestPermission()
        addNotification(id: id, title: title)
        schedule(time)
    }

    func removeNotification(_ id: ObjectId) -> Void {
//        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [id.stringValue])
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.stringValue])

    }
}

