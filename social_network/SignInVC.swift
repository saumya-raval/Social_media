//
//  SignIn.swift
//  social_network
//
//  Created by Saumya Raval on 5/2/17.
//  Copyright © 2017 ImbaGames. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SignIn: UIViewController {
    
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("SAUMYA: ID found in keychain")
            performSegue(withIdentifier: "FeedVC", sender: nil)
        }
    }

    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("SAUMYA: User successfully signed in with email")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("SAUMYA: Unable to sign in with email")
                        } else {
                            print("SAUMYA: User created successfully with email")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }
 
//    This function is used for Facebook auth only
//
//    func firebaseAuth(_ credentials: FIRAuthCredential) {
//        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
//            if error != nil {
//                print("SAUMYA: Error authenticating - \(error)")
//            } else {
//                print("SAUMYA: Successfully authenticated")
//            }
//        })
//    }
    	
    func completeSignIn(id: String, userData: Dictionary<String, String>){
        DataServices.ds.createFirebaseUser(uid: id, userData: userData)
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Successfully saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "FeedVC", sender: nil)
    }

}

