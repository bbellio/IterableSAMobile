//
//  IterableService.swift
//  IterableSAChallenge
//
//  Created by Bethany Bellio on 6/19/21.
//

import UIKit
import IterableSDK

class IterableService {
    
    static let shared = IterableService()
    
    internal var environmentSettings: [String: Any] {
        guard let settings = Bundle.main.infoDictionary?["Iterable"] as? [String: Any] else {
            fatalError("Iterable settings bundle not found - check the respective Info.plist for the target")
        }
        return settings
    }
    
    var apiKey: String {
        guard let apiKey = environmentSettings["api_key"] as? String else {
            fatalError("Iterable api_key not found - check .xcconfig file")
        }
        return apiKey
    }
    
    func initialize(with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let config = IterableConfig()
        IterableAPI.initialize(apiKey: apiKey, launchOptions: launchOptions, config: config)
    }
    
    func identifyUser(with email: String) {
        IterableAPI.email = email
    }
    
    func updateInformationFor(_ user: User) {
        let userInfo: [String : Any] = [ Constants.firstName : user.firstName,
                                         Constants.isRegisteredUser: user.isRegisteredUser,
                                         Constants.saUserTestKey : user.key ]
        IterableAPI.updateUser(userInfo, mergeNestedObjects: false) { _ in
            print("Successfully updated user information for user: \(user)")
        } onFailure: { reason, _ in
            print("Iterable failed to update user information for user: \(user) because of the following reason: \(reason ?? "no reason provided")")
        }
    }
    
    func sendCustomEvent(named eventName: String, with data: [String : Any]) {
        IterableAPI.track(event: eventName, dataFields: data) { _ in
            print("Iterable successfully tracked \(eventName) event")
        } onFailure: { reason, _ in
            print("Iterable failed to track custom event: \(eventName) because of the following reason: \(reason ?? "no reason provided")")
        }
    }
    
    func receiveNotifications(application: UIApplication, userInfo: [AnyHashable : Any], completionHandler:  @escaping (UIBackgroundFetchResult) -> Void) {
        IterableAppIntegration.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
    
}
