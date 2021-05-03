//
//  ChangePasswordView.swift
//  pinkwalljmg
//
//  Created by apple on 14/04/21.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @State var oldPassword: String = ""
    @State var newPassword: String = ""
    @State var confirmPassword: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Color.init("Color_theme").edgesIgnoringSafeArea(.top).overlay(
            VStack(alignment: .leading){
                // Navigation View
                HStack(){
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    },label: { Image(systemName: "arrow.left") }) .padding().frame(width: 50.0, height: 50.0).foregroundColor(Color.white)
                    Text("Change Password").padding(.trailing, 50.0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50,alignment: .center).foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Color_theme")/*@END_MENU_TOKEN@*/)
                
                ScrollView( showsIndicators: false) {
                    
                    VStack(alignment: .leading){
                        
                        Spacer()
                            .frame(height: 20.0)
                        Group {
                            
                            Text("Current Password")
                                .multilineTextAlignment(.leading)
                                .padding(.top, 30.0)
                            SecureField("******", text: $oldPassword)
                                .padding(.leading, 20.0)
                                .frame(height: 40.0)
                                .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                                .cornerRadius(20)
                                .textContentType(.emailAddress)
                                .keyboardType(.emailAddress)
                            
                            
                            Text("New Password")
                                .multilineTextAlignment(.leading)
                                .padding(.top, 5.0)
                            SecureField("******", text: $newPassword)
                                .padding(.leading, 20.0)
                                .frame(height: 40.0)
                                .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                                .cornerRadius(20)
                                .textContentType(.password)
                            
                            Text("Confirm Password")
                                .multilineTextAlignment(.leading)
                                .padding(.top, 5.0)
                            SecureField("******", text: $confirmPassword)
                                .padding(.leading, 20.0)
                                .frame(height: 40.0)
                                .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                                .cornerRadius(20)
                                .textContentType(.password)
                        }
                        
                        
                        Spacer()
                            .frame(height: 50.0)
                        
                        Button(action: {
                            
                        }) {
                            Text("Reset Password").padding()
                        }.foregroundColor(.white)
                        
                        .frame(minWidth: 200,
                               maxWidth: .infinity,
                               minHeight: 40,
                               maxHeight: .infinity,
                               alignment: .center
                        )
                        .background(Color("Color_theme"))
                        .cornerRadius(20)
                        
                        
                        
                        
                        
                        
                        
                    }.padding(.horizontal, 40.0).frame(minWidth: 0,
                                                       maxWidth: .infinity,
                                                       minHeight: 0,
                                                       maxHeight: .infinity,
                                                       alignment: .leading
                    )
                    
                    
                }
                
            }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/).navigationBarHidden(true))
        
        
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
