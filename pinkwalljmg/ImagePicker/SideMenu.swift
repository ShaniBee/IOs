//
//  SideMenu.swift
//  pinkwalljmg
//
//  Created by apple on 10/04/21.
//

import SwiftUI

struct MenuContent: View {
    @State private var onClickProfile = false
    @State private var onClickTerms = false
    @State var onClickPrivacy = false
    @State private var onClickChangePassword = false
    @State var menuOpen: Bool = false
    
    @Binding var show: Bool
    var body: some View {
        //
        VStack(){
            NavigationLink(destination: ProfileView(), isActive: $onClickProfile) {  }
            NavigationLink(destination: TermsView(), isActive: $onClickTerms) {  }
            NavigationLink(destination: PrivacyView(), isActive: $onClickPrivacy) {  }
            NavigationLink(destination: ChangePasswordView(), isActive: $onClickChangePassword) {  }
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 50.0)
                .frame(width: 150.0, height: 150.0)
            Text("UserName")
            Spacer()
                .frame(height: 30.0)
            List {
                Text("Blog").onTapGesture {
                    print("My Profile")
                    show.toggle()
                }
                Text("My Profile").onTapGesture {
                    print("My Profile")
                    onClickProfile = true
                    
                }
                Text("Terms & Condition").onTapGesture {
                    print("Posts")
                    self.onClickTerms = true
                }
                Text("Privacy Policy").onTapGesture {
                    self.onClickPrivacy = true
                    print("Logout")
                }
                Text("Change Password").onTapGesture {
                    self.onClickChangePassword = true
                    print("Logout")
                }
                Text("Logout").onTapGesture {
                    print("Logout")
                }
                
            }
        }
        
    }
    func openMenu() {
        self.menuOpen.toggle()
    }
}

struct SideMenu: View {
    let width: CGFloat
    let isOpen: Bool
    let menuClose: () -> Void
    @State private var show = false
    
    
    func menuCloseCall(){
        
    }
    var body: some View {
        ZStack {
            
           
            
            if show == true{
                GeometryReader { _ in
                    EmptyView()
                }
                .background(Color.gray.opacity(0.3))
                .opacity(show  == isOpen ? 0.0 : (isOpen == true ? 0.0 : 1.0))
                .animation(Animation.easeIn.delay(0.25))
                .onTapGesture {
                    show = true
                    self.menuClose()
                }
                HStack {
                    MenuContent(show: $show)
                        .frame(width: self.width)
                        .background(Color.white)
                        .offset(x: show  == isOpen ? (isOpen == true ? -self.width : 0) : 0 )
                        .animation(.default)
                    
                    Spacer()
                }
            }else{
                
                
                
                GeometryReader { _ in
                    EmptyView()
                }
                .background(Color.gray.opacity(0.3))
                .opacity(show  == isOpen ? 0.0 : (isOpen == true ? 1.0 : 0.0))
                .animation(Animation.easeIn.delay(0.25))
                .onTapGesture {
                   
                    self.menuClose()
                }
                HStack {
                    MenuContent(show: $show)
                        .frame(width: self.width)
                        .background(Color.white)
                        .offset(x: show  == isOpen ? (isOpen == true ? 0 : -self.width) : 0 )
                        .animation(.default)
                    
                    Spacer()
                }
            }
            
            
            
        }
    }
}
