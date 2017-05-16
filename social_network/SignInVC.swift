//
//  SignIn.swift
//  social_network
//
//  Created by Saumya Raval on 5/2/17.
//  Copyright © 2017 ImbaGames. All rights reserved.
//

import UIKit
import Firebase

class SignIn: UIViewController {
    
    @IBOutlet weak var emailField: CustomTextField!
    @IBOutlet weak var passwordField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("SAUMYA: User successfully signed in with email")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("SAUMYA: Unable to sign in with email")
                        } else {
                            print("SAUMYA: User created successfully with email")
                        }
                    })
                }
            })
        }
    }
    
    func firebaseAuth(_ credentials: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("SAUMYA: Error authenticating - \(error)")
            } else {
                print("SAUMYA: Successfully authenticated")
            }
        })
    }
    
    

}

