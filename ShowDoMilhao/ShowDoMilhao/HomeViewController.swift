//
//  HomeViewController.swift
//  ShowDoMilhao
//
//  Created by Matheus Timbó on 25/10/19.
//  Copyright © 2019 Matheus Timbó. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class HomeViewController: UIViewController {
    var ref: DatabaseReference!
    var username = ""
    var loggingOut = false
    
    @IBOutlet weak var helloLabel: UILabel!
    
   
    
    
    @IBAction func logoutClick(_ sender: Any) {
        if(!self.loggingOut){
            self.loggingOut = true
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                self.loggingOut = false
                self.performSegue(withIdentifier: "logout", sender: self)
            } catch let signOutError as NSError {
                self.loggingOut = false
                print ("Error signing out: %@", signOutError)
            }
        }
        
    }
    
    func getUsername(){
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
              // Get user value
              let value = snapshot.value as? NSDictionary
              print(value)
              let username = value?["username"] as? String ?? ""
              print("username")
              print(username)
              self.username = username
              self.helloLabel.text = "Olá, " + username

          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.getUsername()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
