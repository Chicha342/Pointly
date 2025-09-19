//
//  ContentView.swift
//  Pointly
//
//  Created by Никита on 10.09.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showLogin = false
    @StateObject private var session = SessionManager.shared
    
    var body: some View {
        StartView(isEndAnimation: $showLogin)
            .fullScreenCover(isPresented: $showLogin) {
                if let _ = session.currentUserId {
                    MainView()
                }else{
                    LoginView()
                }
            }
    }
}

#Preview {
    ContentView()
}
