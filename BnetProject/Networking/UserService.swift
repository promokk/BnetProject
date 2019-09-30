//
//  UserService.swift
//  BnetProject
//
//  Created by Andrey Vorobyv on 28.09.2019.
//  Copyright © 2019 Andrey Vorobyv. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class UserService {
    
    private let url = "https://bnet.i-partner.ru/testAPI/"
    private let token = "Rilw4np-7k-IwKC2b9"
    private let defaults = UserDefaults.standard
    
    public func loadNewSessionPost() {
        
        let header: HTTPHeaders = [
            "token": token
        ]
        
        let params: Parameters = [
            "a": "new_session"
        ]
        
        Alamofire.request(url, method: .post, parameters: params, headers: header).responseJSON(queue: .global(qos: .userInitiated)) {
            (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                print(value)
                let json = JSON(value)
                let session = json["data"]["session"].stringValue
                self.defaults.set(session, forKey: "firstSession")
                print(self.defaults.object(forKey: "firstSession") as! String)
            }
        }
    }
    
    public func loadGetEntriesPost(completionHandler: (([User]?, Error? ) -> Void)? = nil) {
        
        let header: HTTPHeaders = [
            "token": token
        ]
        
        let params: Parameters = [
            "a": "get_entries",
            "session": defaults.object(forKey: "firstSession") as! String
        ]
        
        Alamofire.request(url, method: .post, parameters: params, headers: header).responseJSON(queue: .global(qos: .userInitiated)) {
            (response) in
            switch response.result {
            case .failure(let error):
                completionHandler?(nil, error)
                print(error)
            case .success(let value):
                print(value)
                let json = JSON(value)
                let user = json["data"][0].arrayValue.map { User(json: $0) }
                completionHandler?(user, nil)
            }
        }
    }
    
    public func loadAddEntryPost(body: String) {
        
        let header: HTTPHeaders = [
            "token": token
        ]
        
        let params: Parameters = [
            "a": "add_entry",
            "session": defaults.object(forKey: "firstSession") as! String,
            "body": body
        ]
        
        Alamofire.request(url, method: .post, parameters: params, headers: header).responseJSON(queue: .global(qos: .userInitiated)) {
            (response) in
            switch response.result {
            case .failure(let error):
                print(error)
            case .success(let value):
                print(value)
            }
        }
    }
}
