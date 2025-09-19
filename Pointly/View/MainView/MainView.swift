//
//  MainView.swift
//  Pointly
//
//  Created by Никита on 10.09.2025.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTabbar: tabbar = .home
    @State private var blur: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack {
                switch selectedTabbar {
                case .home:
                    HomeView()
                case .calendar:
                    CalendarView()
                case .profile:
                    ProfileView()
                }
                
                CustomTabBar(selectedTab: $selectedTabbar, blur: $blur)
                    .padding(.bottom, 30)
                    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .bottom)
    }
}
 

#Preview {
    MainView()
}
