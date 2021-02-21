//
//  Game.swift
//  Apple Pie
//
//  Created by hryst on 9/1/19.
//  Copyright © 2019 Anton Mikliayev. All rights reserved.
//

import Foundation

struct Game {
    // загаданное слово
    var word: String
    
    // количество оставшихся попыток
    var incorrectMoveRemaining: Int
    
    //список нажатых букв
    var guessedLetters: [Character]
    
    //отоброжаемое слово
    var formattedWord: String {
        var guessedWord = ""
        
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
                
            } else {
                guessedWord += "_"
            }
        }
        
        return guessedWord
    }
    
    
    // обработка нажатой буквы
    mutating func playerGuessed(letter: Character) {
       guessedLetters.append(letter)
    
        // проверяем есть ли буква в слове 
        if !word.contains(letter) {
          incorrectMoveRemaining -= 1
        }
    }
}



