//
//  ViewController.swift
//  LockdownPedometer
//
//  Created by Anna Maria on 24/04/2020.
//  Copyright © 2020 Anna Maria. All rights reserved.
//
//  Application counts steps and sends reminder (local notification) to the user everyday at 20
//  If there is less than 9000 steps registered, user should consider going for a walk if possible
//

import UIKit
import CoreMotion
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    var pedometer = CMPedometer()
    var motionManager = CMMotionManager()
    
    @IBOutlet weak var stepsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerLocalNotification()
        self.scheduleLocalNotification()
        
    }
        
        func registerLocalNotification() {
            let center = UNUserNotificationCenter.current() // ask for permission for app to send notifications
                center.requestAuthorization(options: [.alert, .sound]) {(granted, error) in
            }
        }
    
        func scheduleLocalNotification() {
            let center = UNUserNotificationCenter.current()
            let content = UNMutableNotificationContent()  // notification content
                content.title = "Reminder"
                content.body = "Check your steps!"
                content.sound = .default
                content.badge = NSNumber(value: 1)
        
                var date = DateComponents()
                date.hour = 20
                date.minute = 00
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true) // notification trigger

                let uuidString = UUID().uuidString
                let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)  //create the request

            center.add(request) { (error:Error?) in  //register the request
              if let error = error {
                    print("Notification Error: ", error)
                }
            }
   }
    
    private func startCountingSteps() {
      pedometer.startUpdates(from: Date()) {
          [weak self] pedometerData, error in
          guard let pedometerData = pedometerData, error == nil else { return }

          DispatchQueue.main.async {
              self?.stepsLabel.text = pedometerData.numberOfSteps.stringValue
          }
       }
    }
    private func startUpdating() {
 
      if CMPedometer.isStepCountingAvailable() {
          startCountingSteps()
        
      }
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        startUpdating()
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        pedometer.stopUpdates()
    }
    
}
