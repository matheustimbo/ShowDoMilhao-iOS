//
//  StartViewController.swift
//  ShowDoMilhao
//
//  Created by Matheus Timbó on 30/10/19.
//  Copyright © 2019 Matheus Timbó. All rights reserved.
//

import UIKit
import AVFoundation

class StartViewController: UIViewController {
    
    var musicEffect: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let musicFile = Bundle.main.path(forResource: "abertura", ofType: ".mp3")
        
        do{
            try musicEffect = AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicFile!))
        }
        
        catch{
                print(error)
        }
        
        

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
    
    
    @IBAction func playMusic(_ sender: Any) {
        
        musicEffect.play()
    }
    
    
    @IBAction func stopMusic(_ sender: Any) {
        
        musicEffect.stop()
    }
    

}
