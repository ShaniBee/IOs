//
//  EditProfile.swift
//  pinkwalljmg
//
//  Created by apple on 08/05/21.
//

import SwiftUI
import SDWebImageSwiftUI
import URLImage

struct EditProfile: View {
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var isShowPhotoLibrary = false
    // @State private var image = UIImage()
    
    @State private var images: Image? = Image("")
    @State private var data : Data? = Data()
    
    @State var name: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var countryCode: String = ""
    @State var location: String = ""
    
    @State private var checkedTerms = false
    @State private var checkedPrivacy = false
    @State private var shouldPresentActionScheet = false
    
    @State private var onClickTerms = false
    @State private var onClickPrivacy = false
    @State private var cameraCheck : Int = 0
    
    
    
    var body: some View {
        Color.init("Color_theme").edgesIgnoringSafeArea(.top).overlay(
            VStack(alignment: .leading){
                // Navigation View
                HStack(){
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    },label: { Image(systemName: "arrow.left") }) .padding().frame(width: 50.0, height: 50.0).foregroundColor(Color.white)
                    
                    Text("Profile").padding(.trailing, 50.0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50,alignment: .center).foregroundColor(.white)
                    
                }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Color_theme")/*@END_MENU_TOKEN@*/)
                
                
                ScrollView( showsIndicators: false) {
                    VStack(alignment: .leading){
                        //                        HStack(){
                        //                            Spacer()
                        //                            ZStack(){
                        //
                        //
                        //                                if UserPreference.shared.data?.image ?? "" != "" && data?.count == 0{
                        //                                    images?.data(url: URL(string: UserPreference.shared.data?.image ?? "")!)
                        //                                        .resizable()
                        //                                        .aspectRatio(contentMode: .fill)
                        //                                        .frame(width: 160, height: 160)
                        //                                        .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                        //                                        .clipShape(Circle())
                        //                                }else{
                        //                                    images?
                        //                                        .resizable()
                        //                                        .aspectRatio(contentMode: .fill)
                        //                                        .frame(width: 160, height: 160)
                        //                                        .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                        //                                        .clipShape(Circle())
                        //                                }
                        //
                        //
                        //                                //                                if UserPreference.shared.data?.image ?? "" != ""{
                        //                                //
                        //                                //
                        //                                //
                        //                                //                                    URLImage(url: URL(string: UserPreference.shared.data?.image ?? "")!,
                        //                                //                                             content: { image in
                        //                                //
                        //                                //                                                image
                        //                                //                                                    .resizable()
                        //                                //                                                    .aspectRatio(contentMode: .fill)
                        //                                //                                                    .frame(width: 160.0, height: 160.0)
                        //                                //                                                    .clipShape(Circle())
                        //                                //                                             })
                        //                                //
                        //                                //                                }
                        //
                        //
                        //
                        //                                Button(action: {
                        //                                    self.shouldPresentActionScheet = true
                        //                                    //self.isShowPhotoLibrary = true
                        //                                }) {
                        //                                    Image(systemName: "photo")
                        //                                        .font(.system(size: 60)).padding(.all, 50.0)
                        //
                        //                                }.foregroundColor(.white)
                        //                                .frame(width: 160, height: 160)
                        //
                        //                                .actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                        //                                    ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                        //                                        if !UIImagePickerController.isSourceTypeAvailable(.camera){
                        //                                            print("No camera found on this device")
                        //                                            return
                        //                                        }else {
                        //                                            isShowPhotoLibrary = true
                        //                                            cameraCheck = 1
                        //                                            //                                        self.shouldPresentImagePicker = true
                        //                                            //                                        self.shouldPresentCamera = true
                        //                                        }
                        //
                        //                                    }), ActionSheet.Button.default(Text("Photo Library"), action: {
                        //                                        isShowPhotoLibrary = true
                        //                                        cameraCheck = 2
                        //                                    }), ActionSheet.Button.cancel()])
                        //                                }
                        //                                .sheet(isPresented: $isShowPhotoLibrary) {
                        //                                    if cameraCheck == 1{
                        //                                        ImagePicker(sourceType: .camera, selectedImage: self.$images,data: self.$data)
                        //                                    }else{
                        //                                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$images, data: self.$data)
                        //                                    }
                        //
                        //                                }
                        //                            }
                        //                            Spacer()
                        //                        }
                        
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
                                .disabled(true)
                            
                            
                            
                            
                            Group {
                                //                                Text("Country Code")
                                //                                    .multilineTextAlignment(.leading)
                                //                                    .padding(.top, 5.0)
                                //                                TextField("Enter country code...", text: $countryCode, onEditingChanged: {_ in
                                //
                                //                                }, onCommit: {
                                //
                                //                                })
                                //                                .padding(.leading, 20.0)
                                //                                .frame(height: 40.0)
                                //                                .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                                //                                .cornerRadius(20)
                                //                                .textContentType(.telephoneNumber)
                                //                                .keyboardType(.phonePad)
                                
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
                            }
                            
                            
                            
                            Text("Location")
                                .multilineTextAlignment(.leading)
                                .padding(.top, 5.0)
                            
                            TextField("Enter location...", text: $location,onEditingChanged: {_ in
                                
                                
                            }, onCommit: {
                                
                            })
                            .padding(.leading, 20.0)
                            .frame(height: 40.0)
                            .background(Color(red: 0.826, green: 0.808, blue: 0.859, opacity: 0.28))
                            .cornerRadius(20)
                            .textContentType(.location)
                            
                        }
                        
                        
                        Spacer()
                            .frame(height: 50.0)
                        
                        Button(action: {
                            if name == ""{
                                Toast.shared.showAlert(type: .validationFailure, message: "Please enter username")
                            }else if email == ""{
                                Toast.shared.showAlert(type: .validationFailure, message: "Please enter email address")
                            }else if !Utilities.sharedInstance.isValidEmail(testStr: email){
                                Toast.shared.showAlert(type: .validationFailure, message: "Please enter valid email address")
                                //                            }else if countryCode == ""{
                                //                                Toast.shared.showAlert(type: .validationFailure, message: "Please enter country code")
                            }else if location == ""{
                                Toast.shared.showAlert(type: .validationFailure, message: "Please enter location")
                            }else if phone == ""{
                                Toast.shared.showAlert(type: .validationFailure, message: "Please enter phone number")
                            }else{
                                
                                SignupEP.editProfile(name: name, email: email, countryCode: countryCode, phone: phone, address: location, image: data!).request(showSpinner: true) { (response) in
                                    if response != nil {
                                        guard let obj = response as? LoginModel else {
                                            return
                                        }
                                        UserPreference.shared.data = obj.data
                                        UserPreference.shared.saveData(obj.data!)
                                        
                                        self.presentationMode.wrappedValue.dismiss()
                                        Toast.shared.showAlert(type: .success, message: obj.message ?? "")
                                    }
                                } error: { (error) in
                                    
                                }
                                
                            }
                            
                        }) {
                            Text("Update").padding()
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
                
                
            }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/).navigationBarHidden(true)).onAppear { 
                name = UserPreference.shared.data?.display_name ?? ""
                email = UserPreference.shared.data?.email ?? ""
                location = UserPreference.shared.data?.address ?? ""
                countryCode = UserPreference.shared.data?.countryCode ?? ""
                phone = UserPreference.shared.data?.phone ?? ""
                
                
            }
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}



extension Image {
    
    func data(url:URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            
            return Image(uiImage: UIImage(data: data)!)
                
                .resizable()
            
        }
        
        return self
            
            .resizable()
        
    }
}
