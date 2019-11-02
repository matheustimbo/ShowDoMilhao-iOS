//
//  StartViewController.swift
//  ShowDoMilhao
//
//  Created by Matheus Timbó on 30/10/19.
//  Copyright © 2019 Matheus Timbó. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

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
