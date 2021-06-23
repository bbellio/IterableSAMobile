//
//  ContentView.swift
//  IterableSAChallenge
//
//  Created by Bethany Bellio on 6/19/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Update User Information") {
            IterableService.shared.updateInformationFor(currentUser)
        }
        .onAppear {
            IterableService.shared.identifyUser(with: currentUser.email)
        }
        Button("Send Custom Event") {
            IterableService.shared.sendCustomEvent(named: Constants.eventName, with: [ Constants.platform : Constants.iOS,
                                                                                       Constants.isTestEvent : true,
                                                                                       Constants.url : Constants.customURL,
                                                                                       Constants.secretCodeKey : Constants.secretCodeValue  ])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
