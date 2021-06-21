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
        let userInfo: [String : Any] = [ IterableConstants.firstName : user.firstName,
                                         IterableConstants.isRegisteredUser: user.isRegisteredUser,
                                         IterableConstants.saUserTestKey : user.key ]
        IterableAPI.updateUser(userInfo, mergeNestedObjects: false) { _ in
            print("Successfully updated user information for user: \(user)")
        } onFailure: { reason, _ in
            print("Iterable failed to update user information for user: \(user) with reason: \(reason ?? "no reason provided")")
        }
    }
    
}

private enum IterableConstants {
    static let firstName = "firstName"
    static let isRegisteredUser = "isRegisteredUser"
    static let saUserTestKey = "SA_User_Test_Key"
}
