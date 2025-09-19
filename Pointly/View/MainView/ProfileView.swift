//
//  ProfileView.swift
//  Pointly
//
//  Created by Никита on 10.09.2025.
//

import SwiftUI

struct ProfileView: View {
    @State private var isLogedOut: Bool = false
    
    enum ActiveAlert: Identifiable {
        case deleteAccount, logeOutAccount
        
        var id: Int {
            hashValue
        }
    }
    
    @State private var activeAlert: ActiveAlert?
    
    @StateObject private var viewModel = NotesViewModel()
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        VStack{
            CustomHeader()
                .ignoresSafeArea()
            
            Text("Your Account")
                .font(.system(size: 32, weight: .bold, design: .default))
                .padding(.top)
                .foregroundStyle(LinearGradient(colors:
                                                    [.black.opacity(1), .blue.opacity(0.7)],startPoint: .leading,endPoint: .trailing))
            
            Rectangle()
                .frame(width: 193, height: 1)
            

            HStack(alignment: .top){
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 117, height: 117)
                
                Text(viewModel.userEmail)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundStyle(LinearGradient(colors:
                    [.black.opacity(1), .blue.opacity(0.7)],startPoint: .leading,endPoint: .trailing))
                    .padding(.top)
            }
            .padding(.top, 10)
            
            VStack{
                HStack{
                    Button {
                        
                    } label: {
                        Text("Settings")
                            .padding()
                            .frame(width: 165, height: 65)
                            .background(Color.blue.opacity(0.75))
                            .cornerRadius(12)
                            .foregroundStyle(.white)
                    }
                    
                    Button {
                        print("Create New")
                    } label: {
                        Text("Create New")
                            .padding()
                            .frame(width: 165, height: 65)
                            .foregroundStyle(.black)
                            .font(.system(size: 16, weight: .medium))
                            .background{
                                Color.white.opacity(0.22)
                                    .blur(radius: 5)
                            }
                            .cornerRadius(12)
                    }
                }
                
                HStack{
                    Button {
                        print("Delete Account")
                        
                        activeAlert = .deleteAccount
                    } label: {
                        Text("Delete Account")
                            .padding()
                            .frame(width: 165, height: 65)
                            .foregroundStyle(.black)
                            .font(.system(size: 16, weight: .medium))
                            .background{
                                Color.blue.opacity(0.1)
                                    .blur(radius: 5)
                            }
                            .cornerRadius(12)
                    }
                    
                    Button {
                        print("LogOut")
                        
                        activeAlert = .logeOutAccount
                    } label: {
                        Text("Log Out")
                            .padding()
                            .frame(width: 165, height: 65)
                            .foregroundStyle(.black)
                            .font(.system(size: 16, weight: .medium))
                            .background{
                                Color.white.opacity(0.22)
                                    .blur(radius: 5)
                            }
                            .cornerRadius(12)
                            .shadow(radius: 5)
                        
                    }
                    
                }
            }
            .padding(.bottom, 140)
            Spacer()
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $isLogedOut, content: {
            LoginView()
        })
        
        .background{
            Image("bg")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea(.all)
        }
        .task {
            await viewModel.loadUserEmail()
        }
        .alert(item: $activeAlert){ alert in
            switch alert {
            case .deleteAccount:
                return Alert(title: Text("Are you shure?"),
                             message: Text("You deleted account forever!"),
                             primaryButton: .destructive(Text("Delete"), action: {
                    Task{
                        authViewModel.deleteAccount()
                        isLogedOut = true
                    }
                }),secondaryButton: .cancel())
                
            case .logeOutAccount:
                return Alert(title: Text("Are you shure?"),
                             message: Text("You loged out"),
                             primaryButton: .destructive(Text("Logout"), action: {
                    authViewModel.logOutAccount()
                    isLogedOut = true
                }),secondaryButton: .cancel())
            }
        }
    }
    
}

#Preview {
    ProfileView()
}
