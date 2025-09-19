//
//  SingInView.swift
//  Pointly
//
//  Created by Никита on 10.09.2025.
//

import SwiftUI

struct SinginView: View {
    
    @State private var passwordIsHide: Bool = true
    @State private var activeAlert: ActiveAlert?
    
    @StateObject private var viewModel = AuthViewModel()
    
    enum ActiveAlert: Identifiable {
        case emptyFields, shortPassword
        
        var id: Int {
            hashValue
        }
    }
    
    var body: some View {
        ZStack{
            if viewModel.isLoggedIn{
                withAnimation {
                    MainView()
                }
            }else {
                singInContent
            }
            
            
        }
    }
    
    private var singInContent: some View {
        NavigationView {
            VStack {
                Spacer()
                
                logoSection
                
                emailField
                    .padding(.top)
                
                passwordField
                
                singInButton
                    
                
                dividerCustom
                
                googleButton
                
                Spacer()
            }
            .alert(item: $activeAlert) { alert in
                switch alert{
                case .emptyFields:
                    return Alert(title: Text("Error"), message: Text("Please fill all fields"), dismissButton: .default(Text("OK")))
                case .shortPassword:
                    return Alert(title: Text("Error"), message: Text("Password should be at least 8 characters long"), dismissButton: .default(Text("OK")))
                }
                
            }
            .background{
                Image("bg")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea(.all)
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationTitle("")
        }
    }
    
    private var logoSection: some View {
        VStack{
            VStack(spacing: -10){
                Image("logo")
                
                Text("Create an account")
                    .font(.system(size: 32, weight: .bold, design: .default))
                    .padding()
                    .foregroundStyle(LinearGradient(colors:
                    [.black.opacity(1), .blue.opacity(0.7)],
                    startPoint: .leading,endPoint: .trailing))
            }
        }
    }
    
    private var emailField: some View {
        VStack(alignment: .leading){
            Text("E-mail")
                .font(.system(size: 20, weight: .medium, design: .default))
            
            TextField( "Email", text: $viewModel.email)
                .padding()
                .frame(width: 309, height: 60)
                .background{
                    Color.white
                        .blur(radius: 55)
                }
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
        VStack(){
            Text("Password")
                .frame(width: 309, height: 20, alignment: .leading)
                .font(.system(size: 20, weight: .medium, design: .default))
                
            
            if passwordIsHide{
                SecureField( "password", text: $viewModel.password)
                    .padding()
                    .frame(width: 309, height: 60)
                    .multilineTextAlignment(.leading)
                    .background{
                        Color.white
                            .blur(radius: 55)
                    }
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(
                        LinearGradient(
                            colors: [.clear.opacity(0.7), .blue.opacity(0.7)],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 0.7
                    ))
                    .overlay {
                        Image(systemName: passwordIsHide ? "eye.slash.fill" : "eye.fill")
                            .padding(.leading, 250)
                            .onTapGesture {
                                passwordIsHide.toggle()
                            }
                    }
            }else{
                TextField( "password", text: $viewModel.password)
                    .padding()
                    .frame(width: 309, height: 60)
                    .multilineTextAlignment(.leading)
                    .background{
                        Color.white
                            .blur(radius: 55)
                    }
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(
                        LinearGradient(
                            colors: [.clear.opacity(0.7), .blue.opacity(0.7)],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 0.7
                    ))
                    .overlay {
                        Image(systemName: passwordIsHide ? "eye.slash.fill" : "eye.fill")
                            .padding(.leading, 250)
                            .onTapGesture {
                                passwordIsHide.toggle()
                            }
                    }
            }
            
            Text("Use at least 8 characters")
                .frame(width: 309, height: 20, alignment: .leading)
                .font(.system(size: 12, weight: .medium, design: .default))
        }
        .padding(.top, 20)
    }
    
    private var singInButton: some View {
        VStack{
            Button {
                viewModel.register()
            } label: {
                Text("Sing In")
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
        }
        .padding(.top, 60)
    }
    
    private var dividerCustom: some View {
        HStack{
            Rectangle()
                .frame(width: 139, height: 0.5)
                .foregroundColor(.gray)
            
            Text("Or")
                .font(.system(size: 14, weight: .medium, design: .default))
            
            Rectangle()
                .frame(width: 139, height: 0.5)
                .foregroundColor(.gray)
        }
        .padding(.top, 20)
    }
    
    private var googleButton: some View {
        VStack{
            Button {
                print("Google button tapped")
            } label: {
                Text("Continue with Google")
                    .padding()
                    .frame(width: 309, height: 60)
                    .foregroundStyle(.black)
                    .font(.system(size: 16, weight: .medium))
                    .background{
                        Color.white.opacity(0.22)
                            .blur(radius: 5)
                    }
                    .cornerRadius(12)
                    .overlay {
                        Image("google")
                            .padding(.leading, -130)
                    }
                
            }
            .padding(.top, 20)
            
            Text("Already have an account? Log in")
                .font(.system(size: 15, weight: .medium, design: .default))
                .padding(.top, 10)
                .onTapGesture {
                    print("Switch to login view tapped")
                }
        }
    }
    
}



#Preview {
    SinginView()
}
