//
//  Question.swift
//  ShowDoMilhao
//
//  Created by Matheus Timbó on 04/11/19.
//  Copyright © 2019 Matheus Timbó. All rights reserved.
//

import Foundation

class Question: NSObject {

    var question:String
    var answerIndex:Int
    var options:Array<String>
    
    init(question:String, answerIndex:Int, options:Array<String> ) {
        self.question = question
        self.answerIndex = answerIndex
        self.options = options
    }
}

