//
//  CustomHeader.swift
//  Pointly
//
//  Created by Никита on 10.09.2025.
//

import SwiftUI

struct CustomHeader: View {
    @State private var isShowPlus: Bool = false
    var onSave: (() -> Void)?
    var onEdit: (() -> Void)?
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.ultraThinMaterial.opacity(0.85))
                .frame(height: 110)
                .cornerRadius(12)
                .ignoresSafeArea()
                .shadow(color: .white.opacity(0.3), radius: 8, x: 0, y: 4)
            
            HStack{
                //Left button
                Button {
                    onEdit?()
                } label: {
                    Image(systemName: "square.and.pencil")
                        .foregroundStyle(.blue)
                        .font(.title2)
                        .padding(.leading)
                }
                Spacer()
                //logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                
                Spacer()
                //RightButton
                Button {
                    isShowPlus = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.blue)
                        .font(.title2)
                        .padding(.trailing)
                }
            }
            .padding(.top, 40)
            .frame(minHeight: 110)
        }
        .sheet(isPresented: $isShowPlus) {
            CustomSheet(onSave: onSave)
                .presentationDetents([.medium])
                .presentationCornerRadius(20)
                .presentationBackground{
                    Color.white.opacity(0.22).blur(radius: 5)
                        .cornerRadius(12)
                }
        }
        
    }
}

#Preview {
    CustomHeader()
}
