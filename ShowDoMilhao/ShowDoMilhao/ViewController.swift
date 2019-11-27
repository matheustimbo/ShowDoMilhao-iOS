//
//  ViewController.swift
//  ShowDoMilhao
//
//  Created by Matheus Timbó on 24/10/19.
//  Copyright © 2019 Matheus Timbó. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    @IBOutlet weak var nomeInput: UITextField!
    
    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var senhaInput: UITextField!
    
    
    @IBOutlet weak var avisoErro: UILabel!
    
    
    @IBAction func cadastrarClick(_ sender: Any) {
        
        self.avisoErro.text = ""
        if(self.nomeInput.text != "" && self.emailInput.text != "" && self.senhaInput.text != ""){
            
            //fazer o login do firebase
            let email = emailInput.text!
            let password = senhaInput.text
            let username = nomeInput.text
            
            let actionCodeSettings = ActionCodeSettings()
            actionCodeSettings.url = URL(string: "https://www.example.com")
            // The sign-in operation has to always be completed in the app.
            actionCodeSettings.handleCodeInApp = true
            actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
            actionCodeSettings.setAndroidPackageName("com.example.android",
                                                 installIfNotAvailable: false, minimumVersion: "12")
            
            Auth.auth().createUser(withEmail: email, password: password!) {
                authResult, error in
                guard let user = authResult?.user, error == nil else {
                    print(error!.localizedDescription)
                    self.avisoErro.text = error!.localizedDescription
                  return
                }
                print("\(user.email!) created")
                
                
                self.ref.child("users").child(user.uid).setValue(["username": username ?? "", "lastShot": 0, "bestShot": 0 ])
                
                
                let alert = UIAlertController(title: "Foi enviado um email de verificação", message: "Confirme seu email", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    self.performSegue(withIdentifier: "toLogin", sender: self)}))
                
                user.sendEmailVerification { (_) in
                    self.present(alert, animated: true, completion: nil)
                }
                
                
            }
            
        }else{ //ta faltando preencher algum dos campos
            if(self.nomeInput.text == ""){
                self.avisoErro.text = "Insira um nome"
            } else
                if(self.emailInput.text == ""){
                    self.avisoErro.text = "Insira uma email"
                }else{
                    if(self.senhaInput.text == ""){
                        self.avisoErro.text = "Insira uma senha"
                    }
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        
        if let _  = Auth.auth().currentUser {
            if(Auth.auth().currentUser!.isEmailVerified){
                if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home") as? HomeViewController {
                    if let navigator = self.navigationController {
                        navigator.pushViewController(viewController, animated: true)
                    }
                }
            }
        }
        
        
    }


}

