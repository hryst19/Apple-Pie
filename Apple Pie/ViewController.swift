//
//  ViewController.swift
//  Apple Pie
//
//  Created by hryst on 8/31/19.
//  Copyright © 2019 Anton Mikliayev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //слова для угадывания
    var listOfWord = [ "арбуз" ,
       "банан",
       "вертолет",
       "гномик",
       "домик",
                       
    ]
   // мах количество попыток
    let  incorrectMoveAllowed = 7
    
    // количество выигрошей и проигрошей
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    // текущая игра
    var currentGame: Game!
    
    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       newRound()
    }
    
    // запуск нового раунда игры
    func newRound() {
        
        if !listOfWord.isEmpty {
            let newWord = listOfWord.removeFirst()
            
            currentGame = Game(word: newWord, incorrectMoveRemaining: incorrectMoveAllowed, guessedLetters: [])
            
            enableLetterButtons(true)
            
        } else {
            enableLetterButtons(false)
        }
     updateUI()
    }
    
    //зазмораживаю кнопки
    func enableLetterButtons(_ enabel: Bool) {
        for button in letterButtons {
            button.isEnabled = enabel
        }
    }
    
    //обновление интерфейса
    func updateUI() {
        
        //обновление дерева
        
        let imageName = "Tree \(currentGame.incorrectMoveRemaining)"
        let image = UIImage(named: imageName)
        treeImageView.image = image
        
        
        // обновляем угадываемое слово
        var letters = [String]()
        for letter in  currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpaces = letters.joined(separator: " ")
        
        
        correctWordLabel.text = wordWithSpaces
        
        // обновляем счет
        scoreLabel.text = "Выиграши: \(totalWins), проигрыши: \(totalLosses)"
        
     
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
       sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    
    // проверяем на окончание игры
    func updateGameState() {
        if currentGame.incorrectMoveRemaining < 1 {
            // проиграли раунд
            totalLosses += 1
        } else {
            if currentGame.word == currentGame.formattedWord {
                // выиграли раунд
                totalWins += 1
            } else {
              updateUI()
            }
        }
  
    }
    
}

