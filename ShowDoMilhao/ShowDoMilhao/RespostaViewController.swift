//
//  RespostaViewController.swift
//  ShowDoMilhao
//
//  Created by Matheus Timbó on 13/11/19.
//  Copyright © 2019 Matheus Timbó. All rights reserved.
//

import UIKit

class RespostaViewController: UIViewController {

    var acertou = false
    var teste = ""
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.acertou==true){
            self.label.text="Parabéns\n Você acertou!"
        }
        // Do any additional setup after loading the view.
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
