//
//  ContentView.swift
//  DemoUserNotification20230225
//
//  Created by Xavier on 2/25/23.
//

import SwiftUI
import UserNotifications
struct ContentView: View {
    var body: some View {
        VStack {
            Button("Tap me to activate notification") {
                scheduleNotification(title: "1 new message", subtitle: "The meeting tomorrow is rescheduled...", secondsLater: 5, isRepeating: false)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func scheduleNotification(title: String, subtitle: String, secondsLater: TimeInterval, isRepeating: Bool) {
    //Request Access
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, error in
        if let error {
            print("Notification access not granted.", error.localizedDescription)
        }
    }
    //Define the content
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = subtitle
    content.sound = .default
    
    //Define the trigger
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: secondsLater, repeats: isRepeating)
    
    //Define the request
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    //Add request to notication center of the current app
    UNUserNotificationCenter.current().add(request)
}
