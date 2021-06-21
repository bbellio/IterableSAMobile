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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
