//
//  ViewController.swift
//  ShowDoMilhao
//
//  Created by Matheus Timbó on 24/10/19.
//  Copyright © 2019 Matheus Timbó. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?

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
            
            Auth.auth().createUser(withEmail: email, password: password!) {
                authResult, error in
                guard let user = authResult?.user, error == nil else {
                    print(error!.localizedDescription)
                    self.avisoErro.text = error!.localizedDescription
                  return
                }
                print("\(user.email!) created")
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
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
          // ...
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
   self.navigationController?.isNavigationBarHidden = false
    Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


}

