//
//  ForgotPasswordView.swift
//  pinkwalljmg
//
//  Created by apple on 08/04/21.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var email: String = ""
    @State var password: String = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(alignment: .leading){
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            },label: { Image(systemName: "arrow.left") }) .padding().frame(width: 50.0, height: 50.0).foregroundColor(Color("Color_theme"))
            ScrollView( showsIndicators: false) {
                VStack(alignment: .leading){
                    HStack(){
                        Spacer()
                        Image("withdraw")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 50.0)
                            .frame(width: 200.0, height: 200.0)
                        
                        Spacer()
                    }
                    
                    Group {
                        Text("Forgot Password").underline()
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
                        
                        
                        
                    }
                    
                    
                    Spacer()
                        .frame(height: 50.0)
                    
                    Button(action: {}) {
                        Text("Submit").padding()
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
        }
        
        .navigationBarHidden(true)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
