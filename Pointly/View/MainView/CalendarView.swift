//
//  CalendarView.swift
//  Pointly
//
//  Created by Никита on 10.09.2025.
//

import SwiftUI
import SwiftUICalendar
import Combine

struct CalendarView: View {
    @ObservedObject var controller = CalendarController()
    @State var isOpenDate = false
    
    var body: some View {
            VStack{
                CustomHeader()
                    .ignoresSafeArea()
                
                Text("Calendar")
                    .font(.system(size: 32, weight: .bold, design: .default))
                    .padding()
                    .foregroundStyle(LinearGradient(colors:
                    [.black.opacity(1), .blue.opacity(0.7)],
                    startPoint: .leading,endPoint: .trailing))
                
                //MARK: - CALENDAR
                VStack {
                    HStack {
                        Button("← Prev") {
                            controller.scrollTo(controller.yearMonth.addMonth(value: -1), isAnimate: true)
                        }
                        Spacer()
                        Text("\(controller.yearMonth.monthShortString), \(controller.yearMonth.year)")
                            .font(.title2)
                        Spacer()
                        Button("Next →") {
                            controller.scrollTo(controller.yearMonth.addMonth(value: 1), isAnimate: true)
                        }
                    }
                    .padding()
                    
                    SwiftUICalendar.CalendarView(controller) { date in
                        Text("\(date.day)")
                            .frame(maxWidth: 35, minHeight: 35)
                            .background(date.isToday ? Color.blue.opacity(0.8) : Color.clear)
                            .cornerRadius(60/2)
                            .padding(.top, 5)
                            .onTapGesture {
                                isOpenDate = true
                                print("\(date)")
                            }
                        
                        Rectangle()
                            .fill(Color.black.opacity(0.6))
                            .frame(width: 100, height: 0.3)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 400)
                    .padding()
                }
                
                
                Spacer()
            }
            .ignoresSafeArea()
            
        
        .background{
            Image("bg")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea(.all)
        }
    }
}

#Preview {
    CalendarView()
}
