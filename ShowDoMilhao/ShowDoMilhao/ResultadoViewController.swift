//
//  ResultadoViewController.swift
//  ShowDoMilhao
//
//  Created by Matheus Timbó on 13/11/19.
//  Copyright © 2019 Matheus Timbó. All rights reserved.
//

import UIKit

class ResultadoViewController: UIViewController {
    
    var acertos = 0
    var erros = 0

    @IBOutlet weak var labelAcertos: UILabel!
    
    @IBOutlet weak var labelErros: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelAcertos.text = "Acertos: " + String(self.acertos)
        self.labelErros.text = "Erros: " + String(self.erros)
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
