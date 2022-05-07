//
//  ViewController.swift
//  FireBase Login
//
//  Created by KimJongHee on 2022/05/04.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = "abcdefg"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 1 * charIndex, repeats: false) { timer in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
        
        
        
    }


}

