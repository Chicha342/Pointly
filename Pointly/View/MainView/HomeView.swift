//
//  Home.swift
//  Pointly
//
//  Created by Никита on 10.09.2025.
//

import SwiftUI

struct HomeView: View {
    @State private var edItingMode: Bool = false
    
    @StateObject private var viewModel = NotesViewModel()
    
    var body: some View{
            VStack(spacing: 0){
                CustomHeader(onSave: {
                    viewModel.loadNotes()
                }, onEdit: {
                    withAnimation {
                        edItingMode.toggle()
                    }
                })
                .frame(height: 110)
                
                ScrollView{
                    Text("Targets")
                        .font(.system(size: 32, weight: .bold, design: .default))
                        .padding(.vertical, 8)
                        .padding()
                        .foregroundStyle(LinearGradient(colors:
                        [.black.opacity(1), .blue.opacity(0.7)],
                        startPoint: .leading,endPoint: .trailing))
                    
                    ForEach(viewModel.notes, id: \.id){ item in
                        NoteCellView(note: item, viewModel: viewModel)
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                        
                        if edItingMode{
                            Button{
                                withAnimation {
                                    viewModel.coreDataManager.deleteItem(item)
                                    if let userId = viewModel.session.currentUserId {
                                        viewModel.notes = CoreDataManager.shared.fetchData(for: userId)
                                    }
                                }
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.red)
                                    .padding(8)
                                    .background(Circle().fill(Color.red.opacity(0.1)))
                            }
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .safeAreaInset(edge: .bottom){
                    Color.clear
                        .frame(height: 90)
                }
        }
            .ignoresSafeArea()
        .background{
            Image("bg")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea(.all)
        }
        .onAppear{
            viewModel.loadNotes()
        }
        .onChange(of: viewModel.session.currentUserId) { _ in
            viewModel.loadNotes()
        }
        
    }
    
}

#Preview {
    HomeView()
}
