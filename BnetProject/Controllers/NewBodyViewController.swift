//
//  ViewController.swift
//  BnetProject
//
//  Created by Andrey Vorobyv on 28.09.2019.
//  Copyright © 2019 Andrey Vorobyv. All rights reserved.
//

import UIKit

class NewBodyViewController: UIViewController {
    
    @IBOutlet weak var newBodyTextView:UITextView!

    let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func saveButoon(_ sender: Any) {
        
        if newBodyTextView.text != "" {
        userService.loadAddEntryPost(body: newBodyTextView.text!)
        dismiss(animated: true, completion: nil)
        } else {
            alertCancel()
        }
    }
    
    @IBAction func cancelButoon(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func alertCancel() {
        
        let alertController = UIAlertController(title: "Пусто!", message: "Введите текст.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
}

