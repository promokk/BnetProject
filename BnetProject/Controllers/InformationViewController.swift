//
//  InformationViewController.swift
//  BnetProject
//
//  Created by Andrey Vorobyv on 29.09.2019.
//  Copyright © 2019 Andrey Vorobyv. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    var daString = 0.0
    var dmString = 0.0
    var bodyString = ""
    
    @IBOutlet weak var daLable: UILabel!
    @IBOutlet weak var dmLable: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daLable.text = "da: \(dateFormatter.string(from: Date(timeIntervalSince1970: Double(daString))))"
        dmLable.text = "dm: \(dateFormatter.string(from: Date(timeIntervalSince1970: Double(dmString))))"
        bodyTextView.text = bodyString
    }
    
    private var dateFormatter: DateFormatter {
        let dt = DateFormatter()
        dt.dateFormat = "MM-dd-yyyy"
        return dt
    }
}
