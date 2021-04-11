//
//  SignupView.swift
//  pinkwalljmg
//
//  Created by apple on 08/04/21.
//

import SwiftUI

struct SignupView: View {
    @State private var isShowPhotoLibrary = false
   // @State private var image = UIImage()
    @Environment(\.presentationMode) var presentationMode
    @State private var image: Image? = Image("")
    
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var phone: String = ""
    @State var location: String = ""
    
    @State private var checkedTerms = false
    @State private var checkedPrivacy = false
    @State private var shouldPresentActionScheet = false
    
    @State private var cameraCheck : Int = 0
    
    var body: some View {
        VStack(alignment: .leading){
            // Navigation View
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            },label: { Image(systemName: "arrow.left") }) .padding().frame(width: 50.0, height: 50.0).foregroundColor(Color("Color_theme"))
            
            // Scroll view
            
            ScrollView( showsIndicators: false) {
                VStack(alignment: .leading){
                    HStack(){
                        Spacer()
                        ZStack(){
                            image?.resizable().frame(width: 160, height: 160).scaledToFill().background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28)).clipShape(Circle())
                            
                            Button(action: {
                                self.shouldPresentActionScheet = true
                                //self.isShowPhotoLibrary = true
                            }) {
                                Image(systemName: "photo")
                                    .font(.system(size: 60)).padding(.all, 50.0)
                                    
                            }.foregroundColor(.white)
                            .frame(width: 160, height: 160)
                            
                            .actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                                ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                                    if !UIImagePickerController.isSourceTypeAvailable(.camera){
                                        print("No camera found on this device")
                                        return
                                    }else {
                                        isShowPhotoLibrary = true
                                        cameraCheck = 1
//                                        self.shouldPresentImagePicker = true
//                                        self.shouldPresentCamera = true
                                    }
                                    
                                }), ActionSheet.Button.default(Text("Photo Library"), action: {
                                    isShowPhotoLibrary = true
                                    cameraCheck = 2
                                }), ActionSheet.Button.cancel()])
                            }
                            .sheet(isPresented: $isShowPhotoLibrary) {
                                if cameraCheck == 1{
                                    ImagePicker(sourceType: .camera, selectedImage: self.$image)
                                }else{
                                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                                }
                                
                            }
                        }
                        Spacer()
                    }
                    Text("Sign Up").underline()
                        .padding(.top, 30.0)
                        .frame(minWidth: 0/*@END_MENU_TOKEN@*/, idealWidth: 100/*@END_MENU_TOKEN@*/, maxWidth: .infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0, idealHeight: 40, maxHeight: /*@START_MENU_TOKEN@*/.infinity, alignment: /*@START_MENU_TOKEN@*/.center).foregroundColor(Color("Color_theme"))
                        .font(.title)
                    Group {
                        Text("Name")
                            .multilineTextAlignment(.leading)
                            .padding(.top, 30.0)
                        TextField("Enter name...", text: $name)
                            .padding(.leading, 20.0)
                            .frame(height: 40.0)
                            .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                            .cornerRadius(20)
                        
                        
                        Text("Email Address")
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5.0)
                        TextField("Enter email...", text: $email)
                            .padding(.leading, 20.0)
                            .frame(height: 40.0)
                            .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                            .cornerRadius(20)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                        
                        
                        Text("Phone Number")
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5.0)
                        TextField("Enter phone number...", text: $phone)
                            .padding(.leading, 20.0)
                            .frame(height: 40.0)
                            .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                            .cornerRadius(20)
                            .textContentType(.telephoneNumber)
                            .keyboardType(.phonePad)
                        
                        
                        Text("Location")
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5.0)
                        TextField("Enter location...", text: $location)
                            .padding(.leading, 20.0)
                            .frame(height: 40.0)
                            .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                            .cornerRadius(20)
                            .textContentType(.location)
                        
                        Text("Password")
                            .multilineTextAlignment(.leading)
                            .padding(.top, 5.0)
                        
                        SecureField("Enter password...", text: $password)
                            .padding(.leading, 20.0)
                            .frame(height: 40.0)
                            .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                            .cornerRadius(20)
                        
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
                    
                    HStack(){
                        Button(action: {
                            
                            
                        }) {
                            CheckBoxView(checked: $checkedTerms)
                            Text("I accept the")
                        }.foregroundColor(Color.gray)
                        
                        Button(action: {
                            
                            
                        }) {
                           Text("Terms & Conditions").underline()
                        }.foregroundColor(Color.gray)
                    }
                    
                    Spacer()
                        .frame(height: 10.0)
                    HStack(){
                        Button(action: {
                            
                            
                        }) {
                            CheckBoxView(checked: $checkedPrivacy)
                            Text("I accept the")
                        }.foregroundColor(Color.gray)
                        
                        Button(action: {
                            
                            
                        }) {
                           Text("Privacy Policy").underline()
                        }.foregroundColor(Color.gray)
                    }
                    
                    Spacer()
                        .frame(height: 30.0)
                    HStack(){
                        Spacer()
                        Text("Already have an account?")
                        
                        
                        Button(action: {
                            print("button pressed")
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Sign In").underline()
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
            
        }.navigationBarHidden(true)
    }
}


struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
