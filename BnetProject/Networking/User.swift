//
//  User.swift
//  BnetProject
//
//  Created by Andrey Vorobyv on 28.09.2019.
//  Copyright © 2019 Andrey Vorobyv. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    
    var id: String = ""
    var body: String = ""
    var da: Int = 0
    var dm: Int = 0
    
    convenience init(json: JSON) {
        self.init()
        
        self.id = json["id"].stringValue
        self.body = json["body"].stringValue
        self.da = json["da"].intValue
        self.dm = json["dm"].intValue
    }
}
