//
//  QuizViewController.swift
//  ShowDoMilhao
//
//  Created by Matheus Timbó on 04/11/19.
//  Copyright © 2019 Matheus Timbó. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var option1: UIButton!
    
    @IBOutlet weak var option2: UIButton!
    
    @IBOutlet weak var option3: UIButton!
    
    @IBOutlet weak var option4: UIButton!
    
    var questionIndex = 0
    var answerIndex = 0
    var ref: DatabaseReference!
    var questions = [Question]()
    var acertos = 0
    var erros = 0
    var acertouUltimaQuestao = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        loadQuestions()
        
        option1.titleLabel?.lineBreakMode = .byWordWrapping
        // you probably want to center it
        option1.titleLabel?.textAlignment = .center// if
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func opt1Press(_ sender: Any) {
        self.processAnswer(answeredIndex: 0)
    }
    
    @IBAction func opt2Press(_ sender: Any) {
        self.processAnswer(answeredIndex: 1)
    }
    
    
    @IBAction func opt3Press(_ sender: Any) {
        self.processAnswer(answeredIndex: 2)
    }
    
    @IBAction func opt4Press(_ sender: Any) {
        self.processAnswer(answeredIndex: 3)
    }
    
    func processAnswer(answeredIndex:Int){
        if(answeredIndex == self.answerIndex){
            self.acertos+=1
            if(self.acertos + self.erros == 16){
                self.acertouUltimaQuestao = true;
                updateFirebaseShots()
                self.performSegue(withIdentifier: "Resultado", sender: self)
            }else{
               self.acertouUltimaQuestao = true; self.performSegue(withIdentifier: "Resposta", sender: self)
            }
        }else{
            self.erros+=1
            if(self.acertos + self.erros == 16){
                self.acertouUltimaQuestao = false;
                updateFirebaseShots()
                self.performSegue(withIdentifier: "Resultado", sender: self)
            }else{
                self.acertouUltimaQuestao = false;
                self.performSegue(withIdentifier: "Resposta", sender: self)
            }
        }
        if(!(self.acertos + self.erros == 2)){
           self.questionIndex+=1
            updateLabels()
        }
        
    }
    
    func updateFirebaseShots(){
        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("lastShot").setValue(self.acertos)
        self.ref.child("users").child(Auth.auth().currentUser!.uid).child("bestShot").observeSingleEvent(of: .value, with: {
            (snapshot) in
            if let bestShot = snapshot.value{
                if( self.acertos > bestShot as! Int ){
                    self.ref.child("users").child(Auth.auth().currentUser!.uid).child("bestShot").setValue(self.acertos)
                }
            } else{
                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("bestShot").setValue(self.acertos)
            }
            
        })
    }
    
    func updateLabels(){
    
        self.questionLabel.text = self.questions[self.questionIndex].question
        self.option1.setTitle(self.questions[self.questionIndex].options[0], for: .normal)
        self.option2.setTitle(self.questions[self.questionIndex].options[1], for: .normal)
        self.option3.setTitle(self.questions[self.questionIndex].options[2], for: .normal)
        self.option4.setTitle(self.questions[self.questionIndex].options[3], for: .normal)
        
        self.answerIndex = self.questions[self.questionIndex].answerIndex
        
        //self.acertosLabel.text = "Acertos: ";
        //self.acertosLabel.text?.append(contentsOf: String(self.acertos) )
    }
    
    func loadQuestions(){
        print("a")
        ref.child("PERGUNTAS").observeSingleEvent(of: .value, with: { (snapshot) in
              // Get user value
              print(snapshot)
            for question in snapshot.children {
                print("question")
                print(question)
                let questionSnapshot = question as! DataSnapshot
                let question = questionSnapshot.value as! [String:Any]
                let options = question["Alternativas"] as! [String]
                let questionInstance = Question(question: question["pergunta"] as! String, answerIndex: question["Resposta"] as! Int, options: options)
                self.questions.append(questionInstance)
                self.updateLabels()
            }
          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Resposta"){
            let dvc = segue.destination as! RespostaViewController;
            print("ultima questao")
            print(self.acertouUltimaQuestao)
            dvc.acertou = self.acertouUltimaQuestao
        }
        if(segue.identifier == "Resultado"){
            let dvc = segue.destination as! ResultadoViewController
            dvc.acertos = self.acertos
            dvc.erros = self.erros
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
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
