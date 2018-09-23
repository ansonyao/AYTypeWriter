//
//  ViewController.swift
//  AYTypeWritter
//
//  Created by Anson Yao on 2018-09-05.
//  Copyright © 2018 Anson Yao. All rights reserved.
//

import UIKit
import AYTypeWriter

class ViewController: UIViewController {
    @IBOutlet weak var typewriterView: AYTypewriterView!
    
    let welcomeMessage = "Hello, AYTypeWriterView 📝"
    let primaryColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    let primaryFont = UIFont(name: "Ubuntu-Bold", size: 18)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        typewriterView.backgroundColor = UIColor.black
        typewriterView.cursorColor = UIColor.white
        
        /*
         Customization 1
        */
        //typewriterView.label.text = welcomeMessage
        //setupTextAppearance()
        
        /*
         Customization 2
         */
//        typewriterView.label.attributedText = getAttributedText()
        typewriterView.label.attributedText = getAttributedTextWithRainBowColors()
        //Both customizations will work

        typewriterView.startAnimation()
        typewriterView.delegate = self
    }
    
    func setupTextAppearance() {
        typewriterView.label.textColor = primaryColor
        typewriterView.label.font = primaryFont
    }
    
    func getAttributedText() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: welcomeMessage, attributes:
            [NSAttributedStringKey.foregroundColor: primaryColor,
             NSAttributedStringKey.font: primaryFont]
        )
        return attributedString
    }
    
    //Just for fun
    func getAttributedTextWithRainBowColors() -> NSAttributedString {
        let colors = [
            UIColor.getColor(rgb: (148, 0, 211)),
            UIColor.getColor(rgb: (75, 0, 130)),
            UIColor.getColor(rgb: (0, 0, 255)),
            UIColor.getColor(rgb: (0, 255, 0)),
            UIColor.getColor(rgb: (255, 255, 0)),
            UIColor.getColor(rgb: (255, 127, 0)),
            UIColor.getColor(rgb: (255, 0 , 0))
        ]
        let attributedString = NSMutableAttributedString()
        let characters = Array(welcomeMessage)
        for (index, subString) in characters.enumerated()  {
            attributedString.append(NSAttributedString(string: String(subString), attributes:
                [NSAttributedStringKey.foregroundColor: colors[index%colors.count],
                 NSAttributedStringKey.font: primaryFont]))
        }
        return attributedString
    }
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        typewriterView.startAnimation()
    }
    
    @IBAction func finishButtonAction(_ sender: UIButton) {
        typewriterView.finishAnimation()
    }
    
    @IBAction func pauseButtonAction(_ sender: UIButton) {
        typewriterView.pauseAnimation()
    }
    
    @IBAction func resumeButtonAction(_ sender: UIButton) {
        typewriterView.resumeAnimation()
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        typewriterView.clearAnimation()
    }
}

extension ViewController: AYTypeWriterLabelDelegate {
    func animationFinished() {
        NSLog("animationFinished")
    }
}

