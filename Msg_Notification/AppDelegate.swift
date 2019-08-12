//
//  AppDelegate.swift
//  Msg_Notification
//
//  Created by YUNA KO on 08/08/2019.
//  Copyright © 2019 YUNAKO. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?

    //앱이 처음 실행될 때 호출되는 메소드, 론치 스크린이 표시되고있는 동안 호출
    //-> 알림 설정에 대한 사용자 동의를 받을 때, 대부분 이부분에서 코드를 작성하여 동의를 받음
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //경고창, 배지, 사운드를 사용하는 알림 환경 정보를 생성하고 이를 애플리케이션에 저장
        let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound],
                                                 categories: nil)
        application.registerUserNotificationSettings(setting
        )
 
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        if #available(iOS 10.0, *){
            //새 방식의 로컬 알림 구현 코드가 들어갈 예정
            let setting = application.currentUserNotificationSettings
            guard setting?.types != .none else{
                print("Can't Schedule")
                return
            }
            let nContent = UNMutableNotificationContent()
            
            nContent.badge = 1
            nContent.body = "어서어서 들어오세요!"
            nContent.title = "로컬알림 메시지"
            nContent.subtitle = "서브타이틀"
            nContent.sound = UNNotificationSound.default
            
            
            //알림 발송 조건 객체
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            //알림 요청 객체
            let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
            
            //노티피케이션 센터에 추가
            UNUserNotificationCenter.current().add(request)
        }else{
            //알림 설정 확인
            let setting = application.currentUserNotificationSettings
            
            //알림 설정이 되어 있지 않다면 로컬 알림을 보내도 받을 수 없으므로 종료함
            guard setting?.types != .none else{
                print("Can't Schedule")
                return
            }
            //로컬 알람 인스턴스 생성
            let noti = UILocalNotification()
            
            noti.fireDate = Date(timeIntervalSinceNow: 10) //10초 후 발송
            noti.timeZone = TimeZone.autoupdatingCurrent //현 위치에 따라 타임존 설정
            noti.alertBody = "얼른 다시 접속하세요!!" //표시될 메시지
            noti.alertAction = "학습하기" //잠금 상태일 때 표시될 액션
            noti.applicationIconBadgeNumber = 1 //앱 아이콘 모서리에 표시될 배지
            noti.soundName = UILocalNotificationDefaultSoundName // 로컬 알람 도착시 사운드
            noti.userInfo = ["name":"홍길동"] //로컬 알람 실행시 함께 전달하고 싶은 값, 화면에는 표시 안됨
            
            //생성된 알람 객체를 스케줄러에 등록
            application.scheduleLocalNotification(noti)
            
        }
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

