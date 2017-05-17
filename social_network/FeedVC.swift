//
//  FeedVC.swift
//  social_network
//
//  Created by Saumya Raval on 5/2/17.
//  Copyright © 2017 ImbaGames. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var captionField: CustomTextField!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as? FeedTableViewCell)!
    }


    @IBAction func signOutTapped(_ sender: Any) {
        let result = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("SAUMYA: Keychain item removed succesfully \(result)")
        do {
            try FIRAuth.auth()?.signOut()
        } catch let error as NSError {
            print("\(error)")
        }
        performSegue(withIdentifier: "SignOut", sender: nil)
    }
    
    @IBAction func cameraBtnClicked(_ sender: Any) {
    }
    
    @IBAction func postBtnClicked(_ sender: Any) {
    }
    
    
}
