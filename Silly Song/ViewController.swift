//
//  ViewController.swift
//  Silly Song
//
//  Created by Mochammad Alamsyah on 04/01/18.
//  Copyright © 2018 malamsyah.id. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = String("")
        lyricsView.text = String("")
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        if (nameField.text != ""){
            lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
            nameField.text = String("Done")
        } else {
            lyricsView.text = String("Please Enter Your Name!")
        }
    }
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    func shortNameFromName(name: String) -> String {
        let lowercaseName = name.lowercased().folding(options: .diacriticInsensitive, locale: .current)

        let vowelSet = CharacterSet(charactersIn: "aeiou")
 
        let range = lowercaseName.rangeOfCharacter(from: vowelSet, options: [], range: lowercaseName.startIndex..<lowercaseName.endIndex)
        
        if let fromIndex = (range?.lowerBound){
            return String(lowercaseName.suffix(from: fromIndex))
        } else {
            return lowercaseName
        }
    }
    
    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        
        let shortName = shortNameFromName(name: fullName)
        
        let lyrics = lyricsTemplate
            .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
            .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        return lyrics
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

