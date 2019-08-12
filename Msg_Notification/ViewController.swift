//
//  ViewController.swift
//  Msg_Notification
//
//  Created by YUNA KO on 08/08/2019.
//  Copyright © 2019 YUNAKO. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet var msg: UITextField!
    @IBOutlet var datepicker: UIDatePicker!
    @IBAction func save(_ sender: Any) {
        //알림 설정내용을 확인
        let setting = UIApplication.shared.currentUserNotificationSettings
        
        guard setting?.types != .none else{
            let alert = UIAlertController(title:"알림등록", message:"알림이 허용되어 있지 않습니다.",preferredStyle : .alert)
            let ok = UIAlertAction(title:"확인", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: false)
            return
        }
        
        if #available(iOS 10, *){
            //UserNotifications 프레임워크를 사용한 로컬 알림
            //알림 콘텐츠 강의
            let nContent = UNMutableNotificationContent()
            nContent.body = (self.msg.text)!
            nContent.title = "미리 알림"
            nContent.sound = UNNotificationSound.default
            
            //발송 시각을 '지금으로 부터 *초 형식'으로 변환
            let time = self.datepicker.date.timeIntervalSinceNow
            //발송 조건 정의
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
            
            //발송 요청 객체 정의
            let request = UNNotificationRequest(identifier: "alarm", content: nContent, trigger: trigger)
            
            //노티피케이션 센터에 추가
            UNUserNotificationCenter.current().add(request){
                (_) in
                
                //발송 완료 안내 메시지 창
                let date = self.datepicker.date.addingTimeInterval(9*60*60)
                let message = "알림이 등록되었습니다. 등록된 알림은 \(date)에 발송됩니다."
                
                let alert = UIAlertController(title: "알림등록", message: message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                alert.addAction(ok)
                
                self.present(alert, animated: false)
            }

        }else{
        }
        
        
    }
}

