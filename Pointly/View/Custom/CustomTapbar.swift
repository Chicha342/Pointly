
//
//  customTabBar.swift
//  SwiftUITraining
//
//  Created by Никита on 02.06.2025.
//

import SwiftUI



struct CustomTabBar: View {
    @Binding var selectedTab: tabbar
    @Binding var blur : Bool
    
    @Namespace var animation
    
    var body: some View {
        VStack{
            Spacer()
            
            HStack{
                ForEach(tabbar.allCases, id: \.self){ tab in
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)){
                            selectedTab = tab
                        }
                    }, label: {
                        VStack(spacing: 4){
                            Image(tab.symbolsImageName)
                                .resizable()
                                .renderingMode(.template)
                            //.font(.system(size: 20, weight: .semibold))
                                .frame(width: 25, height: 25, alignment: .center)
                            
                                .scaledToFit()
                                .foregroundColor(selectedTab == tab ? .blue : .black.opacity(1))
                            
                            //                        Text(tab.rawValue)
                            //                            .font(.system(size: 10))
                            //                            .foregroundColor(selectedTab == tab ? .white : .gray.opacity(0.5))
                        }
                        .foregroundColor(selectedTab == tab ? .white : .gray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            ZStack{
                                if selectedTab == tab{
                                    RoundedRectangle(cornerRadius: 35)
                                        .fill(blur ? Color.black.opacity(0.3) : Color.white.opacity(1))
                                        .shadow(radius: 2)
                                        .matchedGeometryEffect(id: "Active Tab", in: animation)
                                }
                            }
                        )
                    })
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .fill(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            )
            .padding(.horizontal, 24)
            
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.home), blur: .constant(false))
}
