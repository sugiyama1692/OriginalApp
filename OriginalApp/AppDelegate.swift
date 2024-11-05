//
//  AppDelegate.swift
//  OriginalApp
//
//  Created by mba2408.starlight kyoei.engine on 2024/10/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore    // 追加
import FirebaseFirestore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()    // 追加
        
        // 匿名認証(下記のメソッドがエラーなく終了すれば、認証完了する)
        Auth.auth().signInAnonymously() { (authResult, error) in
            if error != nil {
                print("Auth Error :\(error!.localizedDescription)")
            }

             // 認証情報の取得
         guard let user = authResult?.user else { return }
         let isAnonymous = user.isAnonymous  // true
         let uid = user.uid
         let newUserDocRef = Firestore.firestore().collection(Const.UsersPath).document(uid)
         let newUser = [
            "created_at": FieldValue.serverTimestamp(),
            "is_anonymous": isAnonymous,
            ] as [String : Any]
         newUserDocRef.setData(newUser)

            return
        }

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


}

