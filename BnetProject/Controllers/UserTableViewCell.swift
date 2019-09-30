//
//  UserTableViewCell.swift
//  BnetProject
//
//  Created by Andrey Vorobyv on 28.09.2019.
//  Copyright © 2019 Andrey Vorobyv. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var daLable: UILabel!
    @IBOutlet weak var dmLable: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
}
