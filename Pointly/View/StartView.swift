//
//  StartView.swift
//  Pointly
//
//  Created by Никита on 10.09.2025.
//

import SwiftUI

struct StartView: View {
    @Binding var isEndAnimation: Bool
        
    var body: some View {
        VStack {
            LottieView(filename: "animatedLogo")
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.3){
                        self.isEndAnimation = true
                    }
                }
        }
    }
}

#Preview {
    StartView(isEndAnimation: .constant(false))
}
