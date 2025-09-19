//
//  LoginView.swift
//  Pointly
//
//  Created by Никита on 10.09.2025.
//

import Foundation
import SwiftUI
struct LoginView: View {
    @State private var passwordIsHide: Bool = true
    @State private var goToCreate: Bool = false
    
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        ZStack {
            if  viewModel.isLoggedIn {
                MainView()
                    .transition(.opacity)
                    .animation(.easeInOut, value: viewModel.isLoggedIn)
            } else {
                NavigationView {
                    loginContent
                }
            }
        }
    }
    
    private var loginContent: some View {
        VStack {
            Spacer()
            
            logoSection
            
            emailField
            
            passwordField
            
            loginButton
            
            forgotPassword
            
            orDivider
            
            createAccountButton
            
            Spacer()
        }
        .padding(.bottom, 100)
        .background(backgroundImage)
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("Error"),
                message: Text("Email or password is incorrect"),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationTitle("")
    }
    
    private var logoSection: some View {
        VStack(spacing: -10) {
            Image("logo")
            
            Text("Welcome back")
                .font(.system(size: 32, weight: .bold, design: .default))
                .padding()
                .foregroundStyle(LinearGradient(
                    colors: [.black.opacity(1), .blue.opacity(0.7)],
                    startPoint: .leading,
                    endPoint: .trailing
                ))
        }
        .padding(.top, 50)
    }
    
    private var emailField: some View {
        VStack(alignment: .leading) {
            Text("E-mail")
                .font(.system(size: 20, weight: .medium, design: .default))
            
            TextField("Email", text: $viewModel.email)
                .padding()
                .frame(width: 309, height: 60)
                .background(Color.white.blur(radius: 55))
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(
                    LinearGradient(
                        colors: [.blue.opacity(0.7), .clear.opacity(0.7)],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 0.7
                ))
        }
    }
    
    private var passwordField: some View {
        VStack(alignment: .leading) {
            Text("Password")
                .font(.system(size: 20, weight: .medium, design: .default))
                .padding(.top, 20)
            
            Group {
                if passwordIsHide {
                    SecureField("password", text: $viewModel.password)
                } else {
                    TextField("password", text: $viewModel.password)
                }
            }
            .padding()
            .frame(width: 309, height: 60)
            .background(Color.white.blur(radius: 55))
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(
                LinearGradient(
                    colors: [.clear.opacity(0.7), .blue.opacity(0.7)],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                lineWidth: 0.7
            ))
            .overlay(eyeIcon, alignment: .trailing)
            
            Text("Use at least 8 characters")
                .font(.system(size: 12, weight: .medium, design: .default))
        }
    }
    
    private var eyeIcon: some View {
        Image(systemName: passwordIsHide ? "eye.slash.fill" : "eye.fill")
            .padding(.trailing, 16)
            .onTapGesture {
                passwordIsHide.toggle()
            }
    }
    
    private var loginButton: some View {
        Button {
            viewModel.login()
        } label: {
            Text("Log in")
                .padding()
                .frame(width: 309, height: 60)
                .foregroundStyle(.white)
                .background(.blue.opacity(0.4))
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(
                    LinearGradient(
                        colors: [.white.opacity(0.7), .clear.opacity(0.7)],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 0.5
                ))
        }
        .padding(.top, 60)
    }
    
    private var forgotPassword: some View {
        Text("Forgot password?")
            .font(.system(size: 15, weight: .medium, design: .default))
            .padding(.top, 10)
            .foregroundStyle(.blue)
            .onTapGesture {
                print("Forgot password tapped")
            }
            .padding(.vertical, 10)
    }
    
    private var orDivider: some View {
        HStack {
            Rectangle()
                .frame(width: 139, height: 0.5)
                .foregroundColor(.gray)
            
            Text("Or")
                .font(.system(size: 14, weight: .medium, design: .default))
            
            Rectangle()
                .frame(width: 139, height: 0.5)
                .foregroundColor(.gray)
        }
    }
    
    private var createAccountButton: some View {
        VStack{
            Button {
                goToCreate = true
            } label: {
                Text("Create an account")
                    .padding()
                    .frame(width: 309, height: 60)
                    .foregroundStyle(.black)
                    .font(.system(size: 16, weight: .medium))
                    .background(Color.white.opacity(0.22).blur(radius: 5))
                    .cornerRadius(12)
            }
            .padding(.top, 20)
            
            NavigationLink(destination: SinginView(), isActive: $goToCreate, label: { EmptyView() } )
        }
    }
    
    private var backgroundImage: some View {
        Image("bg")
            .resizable()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .ignoresSafeArea(.all)
    }
    
//    private func handleLogin() {
//        print("Log in Button tapped")
//        
//        Task { @MainActor in
//            let networkManager = NetworkManager()
//            
//            let loginSuccessful = await networkManager.checkLogin(
//                email: viewModel.email,
//                password: viewModel.password
//            )
//            
//            if loginSuccessful {
//                print("Успешный вход: \(viewModel.email)")
//                goToMainView = true
//                viewModel.email = ""
//                viewModel.password = ""
//            } else {
//                print("error: неверный email или пароль")
//                viewModel.showError = true
//            }
//        }
//    }
}

#Preview {
    LoginView()
}
