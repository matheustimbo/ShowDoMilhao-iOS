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
        }
        self.questionIndex+=1
        updateLabels()
    }
    
    @IBAction func teste(_ sender: Any) {
        //self.questionIndex+=1
        //updateLabels()
        print(self.acertos)
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
        ref.child("questions").observeSingleEvent(of: .value, with: { (snapshot) in
              // Get user value
              print(snapshot)
            for question in snapshot.children {
                let questionSnapshot = question as! DataSnapshot
                let question = questionSnapshot.value as! [String:Any]
                let options = question["options"] as! [String]
                let questionInstance = Question(question: question["question"] as! String, answerIndex: question["answerIndex"] as! Int, options: options)
                self.questions.append(questionInstance)
                self.updateLabels()
            }
          // ...
          }) { (error) in
            print(error.localizedDescription)
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
