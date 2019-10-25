//
//  LoginViewController.swift
//  ShowDoMilhao
//
//  Created by Matheus Timbó on 25/10/19.
//  Copyright © 2019 Matheus Timbó. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var senhaInput: UITextField!
    
    @IBOutlet weak var avisoErro: UILabel!
    
    @IBAction func loginClick(_ sender: Any) {
        
        self.avisoErro.text = ""
        if( self.emailInput.text != "" && self.senhaInput.text != ""){
            
            //fazer o login do firebase
            let email = emailInput.text!
            let password = senhaInput.text
            
            Auth.auth().signIn(withEmail: email, password: password!) { [weak self] user, error in
              guard let strongSelf = self else { return }
                if let error = error {
                    self?.avisoErro.text = error.localizedDescription
                    return
                }
                
                //navegar para a tela de login
                if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home") as? HomeViewController {
                    if let navigator = self?.navigationController {
                        navigator.pushViewController(viewController, animated: true)
                    }
                }
            }
            
        }else{ //ta faltando preencher algum dos campos
            if(self.emailInput.text == ""){
                    self.avisoErro.text = "Insira um email"
                }else{
                    if(self.senhaInput.text == ""){
                        self.avisoErro.text = "Insira uma senha"
                    }
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
