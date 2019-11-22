//
//  RankingViewController.swift
//  ShowDoMilhao
//
//  Created by Matheus Timbó on 04/11/19.
//  Copyright © 2019 Matheus Timbó. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct PessoaNoRanking{
    var nome:String = ""
    var pontos:Int = 0
    
    init(nome:String, pontos:Int) {
        self.nome = nome
        self.pontos = pontos
    }
}


class RankingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    var pessoasNoRanking : [PessoaNoRanking] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        ref = Database.database().reference()
        
        ref.child("users").queryOrdered(byChild: "lastShot").observe(.childAdded) { (snapshot) in
            print("pessoa")
            var pessoa = (snapshot.value as! [String: Any])
            self.pessoasNoRanking.append(
                PessoaNoRanking(nome: pessoa["username"] as! String, pontos: pessoa["bestShot"] as! Int)
            )
            self.pessoasNoRanking.sort { (pessoa1, pessoa2) -> Bool in
                return pessoa1.pontos > pessoa2.pontos
            }
            self.tableView.reloadData()
            /*print("\((snapshot.value as? [String: Any])!)")

            for pessoa in ((snapshot.value as? [String: Any])!){
                print("pessoa")
                print(pessoa)
                
                
                //self.pessoasNoRanking.append(
                //    PessoaNoRanking(nome: pessoa["username"] as String, pontos: pessoa["bestShot"] as String)
                //)
            }*/
            
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    

}


extension RankingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pessoasNoRanking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankingCell", for: indexPath)
        cell.textLabel?.text = self.pessoasNoRanking[indexPath.row].nome + " " + String(self.pessoasNoRanking[indexPath.row].pontos) + " acertos"
        return cell
    }
    
    
}
