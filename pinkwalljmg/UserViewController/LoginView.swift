//
//  LoginView.swift
//  pinkwalljmg
//
//  Created by apple on 08/04/21.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @State private var onClickForgotPassword = false
    @State private var onClickSignup = false
    @State private var onClickHome = false
    var body: some View {
        NavigationView {
            ScrollView( showsIndicators: false) {
                
                NavigationLink(destination: ForgotPasswordView(), isActive: $onClickForgotPassword) {  }
                NavigationLink(destination: SignupView(), isActive: $onClickSignup) {  }
                NavigationLink(destination: HomeView(), isActive: $onClickHome) {  }
                
                VStack(alignment: .leading){
                    HStack(){
                        Spacer()
                        Image("blogiconstwo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 50.0)
                            .frame(width: 200.0, height: 200.0)
                        
                        Spacer()
                    }
                    
                    Group {
                        Text("Sign In").underline()
                            .padding(.top, 30.0)
                            .frame(minWidth: 0/*@END_MENU_TOKEN@*/, idealWidth: 100/*@END_MENU_TOKEN@*/, maxWidth: .infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0, idealHeight: 40, maxHeight: /*@START_MENU_TOKEN@*/.infinity, alignment: /*@START_MENU_TOKEN@*/.center).foregroundColor(Color("Color_theme"))
                            .font(.title)
                        
                        
                        
                        
                        Text("Email Address")
                            .multilineTextAlignment(.leading)
                            .padding(.top, 30.0)
                        TextField("Enter email...", text: $email)
                            .padding(.leading, 20.0)
                            .frame(height: 40.0)
                            .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                            .cornerRadius(20)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                        
                        
                        Text("Password")
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5.0)
                        SecureField("Enter password...", text: $password)
                            .padding(.leading, 20.0)
                            .frame(height: 40.0)
                            .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                            .cornerRadius(20)
                            .textContentType(.password)
                    }
                    
                    
                    Spacer()
                        .frame(height: 50.0)
                    
                    Button(action: {
                        if email == ""{
                            Toast.shared.showAlert(type: .validationFailure, message: "Please enter email")
                        }else if !Utilities.sharedInstance.isValidEmail(testStr: email){
                            Toast.shared.showAlert(type: .validationFailure, message: "Please enter valid email address")
                        } else if password == ""{
                            Toast.shared.showAlert(type: .validationFailure, message: "Please enter password")
                        }else{
                            SignupEP.login(user_email: email, user_pass: password).request(showSpinner: true) { (response) in
                                if response != nil {
                                    guard let obj = response as? LoginModel else {
                                        return
                                    }
                                    onClickHome = true
                                    Toast.shared.showAlert(type: .success, message: obj.message ?? "")
                                }
                                
                            } error: { (error) in
                                
                            }

                            
                        }
                        
                    }) {
                        Text("Sign In").padding()
                    }.foregroundColor(.white)
                    
                    .frame(minWidth: 200,
                           maxWidth: .infinity,
                           minHeight: 40,
                           maxHeight: .infinity,
                           alignment: .center
                    )
                    .background(Color("Color_theme"))
                    .cornerRadius(20)
                    
                    HStack(){
                        Spacer()
                        Button(action: {
                            print("button pressed")
                            self.onClickForgotPassword = true
                        }) {
                            Text("Forgot Password?")
                        }.foregroundColor(.gray)
                    }
                    Spacer()
                        .frame(height: 30.0)
                    HStack(){
                        Spacer()
                        Text("New User?")
                        Button(action: {
                            print("button pressed")
                            self.onClickSignup = true
                        }) {
                            Text("Sign Up").underline()
                        }.foregroundColor(Color("Color_theme"))
                        Spacer()
                    }
                    
                    
                    
                    
                }.padding(.horizontal, 40.0).frame(minWidth: 0,
                                                   maxWidth: .infinity,
                                                   minHeight: 0,
                                                   maxHeight: .infinity,
                                                   alignment: .leading
                )
                
                
            }
            .navigationBarHidden(true)
        }
        
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
