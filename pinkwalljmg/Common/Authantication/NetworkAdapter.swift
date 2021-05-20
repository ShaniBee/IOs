//
//  NetworkAdapter.swift
//  baseProject
//
//  Created by apple on 01/05/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import Moya
import NVActivityIndicatorView
import SwiftUI

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

struct VerbosePlugin: PluginType {
    let verbose: Bool

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
       
        if let body = request.httpBody,
           let str = String(data: body, encoding: .utf8) {
            print("request to send: \(str))")
        }
        var re = request
        re.cachePolicy = .reloadIgnoringLocalCacheData
        re.httpShouldHandleCookies = false
        
        return re
    }
}




extension TargetType {
    
    func provider<T: TargetType>() -> MoyaProvider<T> {
        return MoyaProvider<T>(plugins: [(NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)),VerbosePlugin(verbose: false)])
    }
    
    func request(showSpinner: Bool? = true, success successCallBack: @escaping (Any?) -> Void, error errorCallBack: ((String?) -> Void)? = nil) {
        
        if showSpinner ?? true {
            let activityData = ActivityData()
            
           NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        }
        
        
        provider().request(self) { (result) in
            //Hide Loader after getting response
            
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
           
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200,201:
                    let model = self.parseModel(data: response.data)
                    successCallBack(model)
                case 404:
                    debugPrint("Session expire")
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any]
                        Toast.shared.showAlert(type: .apiFailure, message: /(json?["message"] as? String))
                        
                        errorCallBack?("404" + /(json?["message"] as? String))
                    } catch {
                        Toast.shared.showAlert(type: .apiFailure, message: error.localizedDescription)
                    }
                    self.logOut()
                case 405:
                    debugPrint("Session expire")
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any]
                      //  Toast.shared.showAlert(type: .apiFailure, message: /(json?["message"] as? String))
                        
                        errorCallBack?(/(json?["message"] as? String))
                    } catch {
                        Toast.shared.showAlert(type: .apiFailure, message: error.localizedDescription)
                    }
                
                case 403:
                    do {
                        let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any]
                        Toast.shared.showAlert(type: .apiFailure, message: /(json?["message"] as? String))
                        successCallBack(nil)
                        //errorCallBack?(/(json?["message"] as? String))
                    } catch {
                        Toast.shared.showAlert(type: .apiFailure, message: error.localizedDescription)
                    }
                case 401:
                    do {
                        let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any]
                        if /(json?["message"] as? String) == "Invaild Authorization"{
                            errorCallBack?(/(json?["message"] as? String))
                            self.logOut()
                        }else{
                            Toast.shared.showAlert(type: .validationFailure, message: /(json?["message"] as? String))
                            errorCallBack?(/(json?["message"] as? String))
                        }
                        
                    } catch {
                        Toast.shared.showAlert(type: .apiFailure, message: error.localizedDescription)
                    }
                case 400, 409, 500,201,203:
                    do {
                        let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any]
                        if response.statusCode == 409{
                            Toast.shared.showAlert(type: .validationFailure, message: /(json?["message"] as? String))
                            errorCallBack?(/(json?["message"] as? String))
                        }else{
                            Toast.shared.showAlert(type: .validationFailure, message: /(json?["message"] as? String))
                            errorCallBack?(/(json?["message"] as? String))
                        }
                        
                        
                    } catch {
                        Toast.shared.showAlert(type: .apiFailure, message: error.localizedDescription)
                    }
                default:
                    Toast.shared.showAlert(type: .apiFailure, message: "Error Default")
                }
            case .failure(let error):
                Toast.shared.showAlert(type: .apiFailure, message: error.localizedDescription)
                errorCallBack?(error.localizedDescription)
            }
        }
    }
  
    
    
    //MARK: - Logout
    fileprivate func logOut() {
        UserPreference.shared.data = nil
    
        
        if UIApplication.shared.windows.count > 0{
            if let windowScene = UIApplication.shared.windows[0].windowScene as? UIWindowScene {
                var windows = UIApplication.shared.windows[0].window?.rootViewController
                if let windowss = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
                    var s = windowss
                   
                    
                    let settings = UserSettings()
                    DispatchQueue.main.async {
                        if let windowScene = windowScene as? UIWindowScene {
                            let window = UIWindow(windowScene: windowScene)
                            
                            settings.loggedIn = false
                            window.rootViewController = UIHostingController(rootView: StartView().environmentObject(settings))
                            let scene = UIApplication.shared.connectedScenes.first
                            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                                sd.window = window
                                window.makeKeyAndVisible()
                            }
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                                s = window
//
//                            }
                            
                            //  reloadDashboard()
                        }
                    }
                    
                    
                    
                    
                }
                
            }
        }
        
    }
    
}
