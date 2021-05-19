//
//  ProfileView.swift
//  pinkwalljmg
//
//  Created by apple on 10/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var onClickProfile = false
    @State private var onClickTerms = false
    @State private var onClickAdmin = false
    @State var onClickPrivacy = false
    @State var onClockLogin = false
    @State private var onClickChangePassword = false
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        
        
        
        
        Color.init("Color_theme").edgesIgnoringSafeArea(.top).overlay(
            VStack(alignment: .leading){
                // Navigation View
                
                NavigationLink(destination: EditProfile(), isActive: $onClickProfile) {  }
                NavigationLink(destination: ContactAdmin(), isActive: $onClickAdmin) {  }
                NavigationLink(destination: TermsView(), isActive: $onClickTerms) {  }
                NavigationLink(destination: PrivacyView(), isActive: $onClickPrivacy) {  }
                NavigationLink(destination: LoginView(), isActive: $onClockLogin) {  }
                NavigationLink(destination: ChangePasswordView(), isActive: $onClickChangePassword) {  }
                
                    //
                HStack(){
                    Text("Profile").padding(.trailing, 0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50,alignment: .center).foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Color_theme")/*@END_MENU_TOKEN@*/)
                
                HStack(){
                    Spacer()
                    WebImage(url: URL(string: UserPreference.shared.data?.image ?? ""))
                        .resizable()
                        .placeholder(Image(systemName: "person.crop.circle.fill"))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160.0, height: 160.0)
                        .clipShape(Circle())
                    
                        
//                    Image(systemName: "person.crop.circle.fill")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 160.0, height: 160.0)
                    Spacer()
                }
                
                HStack(){
                    Spacer()
                    Text(UserPreference.shared.data?.display_name ?? "aa")
                        .foregroundColor(Color.black)
                    Spacer()
                }
                
                List {
                    HStack(){
                        Text("Profile")
                            .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                            .foregroundColor(Color.black)
                            .onTapGesture {
                                print("Posts")
                                self.onClickProfile = true
                            }
                        
                    }
//                    HStack(){
//                        Text("Contact with Admin").frame(maxWidth: .infinity, alignment: .leading)
//                            .background(Color.white)
//                            .foregroundColor(Color.black)
//                            .onTapGesture {
//                                print("Posts")
//                                self.onClickAdmin = true
//                            }
//
//                    }
                    HStack(){
                        Text("Change Password")
                            .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                            .foregroundColor(Color.black)
                        
                    }.onTapGesture {
                        print("Posts")
                        self.onClickChangePassword = true
                    }
                    HStack(){
                        Text("Terms & Condition")
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                    }.onTapGesture {
                        print("Posts")
                        self.onClickTerms = true
                    }
                    HStack(){
                        Text("Privacy Policy")
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                    }.onTapGesture {
                        print("Posts")
                        self.onClickPrivacy = true
                    }
                    HStack(){
                        Text("Log Out")
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                    }.onTapGesture {
                        print("Posts")
                        
                        Utilities.sharedInstance.showAlertViewWithAction("", "Are you sure you want to logout?") {
                            UserPreference.shared.data = nil
                            self.onClockLogin = true
                           

                        }
                    }
                }
                .padding(10)
                
            }.background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/).navigationBarHidden(true))
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
