//
//  UserTableViewController.swift
//  BnetProject
//
//  Created by Andrey Vorobyv on 28.09.2019.
//  Copyright © 2019 Andrey Vorobyv. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    var user = [User]()
    let userService = UserService()
    let firstRun = UserDefaults.standard.bool(forKey: "firstRun") as Bool
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkInternet()
        checkFirstRun()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        userService.loadGetEntriesPost() { [weak self] user, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let user = user, let self = self else { return }
            
            self.user = user
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return user.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        
        cell.bodyTextView.text = user[indexPath.row].body
        cell.daLable.text = dateFormatter.string(from: Date(timeIntervalSince1970: Double(user[indexPath.row].da)))
        cell.dmLable.text = dateFormatter.string(from: Date(timeIntervalSince1970: Double(user[indexPath.row].dm)))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "informationViewController" {
            if let informationViewController = segue.destination as? InformationViewController {
                let indexPath = tableView.indexPathForSelectedRow
                let user = self.user[indexPath!.row]
                informationViewController.daString = Double(user.da)
                informationViewController.dmString = Double(user.dm)
                informationViewController.bodyString = user.body
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let dt = DateFormatter()
        dt.dateFormat = "MM-dd-yyyy"
        return dt
    }
    
    func checkFirstRun() {
        
        if firstRun {
            print("🔥Run")
            print(UserDefaults.standard.object(forKey: "firstSession") as! String)
        } else {
            runFirst()
        }
    }
    
    func runFirst() {
        
        print("🔥FIRST RUN!")
        UserDefaults.standard.set("", forKey: "firstSession")
        userService.loadNewSessionPost()
        UserDefaults.standard.set(true, forKey: "firstRun")
    }
    
    func checkInternet() {
        if (CheckInternet.isConnectedToNetwork() == true) {
        } else{
            alertInternetConnection()
        }
    }
    
    func alertInternetConnection() {
        
        let alertController = UIAlertController(title: "Нет соединения с интернетом!", message: "Проверьте соединение с интернетом.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Повторить попытку", style: .cancel, handler: cancelHandler)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func cancelHandler(alert: UIAlertAction!) {
        
        if !CheckInternet.isConnectedToNetwork() {
            alertInternetConnection()
        }
    }
}
