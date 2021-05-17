//
//  ContactAdmin.swift
//  pinkwalljmg
//
//  Created by apple on 08/05/21.
//

import SwiftUI

struct ContactAdmin: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var shouldPresentActionScheet = false
    @State private var cameraCheck : Int = 0
    @State private var isShowPhotoLibrary = false
    @State var name: String = ""
    @State var email: String = ""
    @State private var image: Image? = Image("")
    @State private var data : Data? = Data()
    
    init() {
        UITextView.appearance().backgroundColor = .clear
        }
    
    var body: some View {
        Color.init("Color_theme").edgesIgnoringSafeArea(.top).overlay(
            VStack(alignment: .leading){
                // Navigation View
                HStack(){
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    },label: { Image(systemName: "arrow.left") }) .padding().frame(width: 50.0, height: 50.0).foregroundColor(Color.white)
                    
                    Text("Contact With Admin").padding(.trailing, 50.0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50,alignment: .center).foregroundColor(.white)
                    
                }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Color_theme")/*@END_MENU_TOKEN@*/)
                
                ScrollView( showsIndicators: false) {
                    VStack(alignment: .leading){
                        Text("Welcome to Jamacian Blogs Contact with us to do promotions or sharing any contents.")
                            .font(.system(size: 20))
                            .multilineTextAlignment(.leading)
                            .padding(.top, 30.0)
                        
                        Spacer(minLength: 50)
                        Group {
                            Text("Request For")
                                .multilineTextAlignment(.leading)
                            
                            TextField("", text: $name)
                                .padding(.leading, 20.0)
                                .frame(height: 40.0)
                                .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                                .cornerRadius(20)
                            
                            
                            Text("Description about request")
                                .multilineTextAlignment(.leading)
                                .padding(.top, 5.0)
                            TextEditor(text: $email)
                                .padding(/*@START_MENU_TOKEN@*/.all, 5.0/*@END_MENU_TOKEN@*/)
                                .frame(height: 100.0)
                                .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                                .cornerRadius(20)
                            Text("Add Attachment")
                                .multilineTextAlignment(.leading)
                            
                            HStack(){
                                
                                ZStack(){
                                    image?.resizable().frame(width: 160, height: 160).scaledToFill().background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                                    
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
                                            ImagePicker(sourceType: .camera, selectedImage: self.$image, data: self.$data)
                                        }else{
                                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image, data: self.$data)
                                        }
                                        
                                    }
                                }
                                Spacer()
                            }
                            Spacer(minLength: 20)
                            Button(action: {
                                if name == ""{
                                    Toast.shared.showAlert(type: .validationFailure, message: "Please enter request for")
                                }else if email == ""{
                                    Toast.shared.showAlert(type: .validationFailure, message: "Please enter description")
                                }else if data?.count == 0{
                                    Toast.shared.showAlert(type: .validationFailure, message: "Please upload document")
                                } else{
                                    SignupEP.contactAdmin(requestFor: name, descriptionAboutRequest: email, image: data!).request(showSpinner: true) { (response) in
                                        if response != nil {
                                            guard let obj = response as? DefaultModel else {
                                                return
                                            }
                                           
                                            Toast.shared.showAlert(type: .success, message: obj.message ?? "")
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                    } error: { (error) in
                                        
                                    }
                                }
                                

                            }) {
                                Text("Submit").padding()
                            }.foregroundColor(.white)
                            
                            .frame(minWidth: 200,
                                   maxWidth: .infinity,
                                   minHeight: 40,
                                   maxHeight: 50,
                                   alignment: .center
                            )
                            .background(Color("Color_theme"))
                            .cornerRadius(20)
                        }
                    }
                    
                   
                    
                }
                .padding(.horizontal, 20.0)
                
            }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/).navigationBarHidden(true))
        
        
    }
}

struct ContactAdmin_Previews: PreviewProvider {
    static var previews: some View {
        ContactAdmin()
    }
}
