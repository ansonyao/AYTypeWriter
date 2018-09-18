//
//  ViewController.swift
//  AYTypeWritter
//
//  Created by Anson Yao on 2018-09-05.
//  Copyright © 2018 Anson Yao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var typewriterView: AYTypewriterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        typewriterView.label.text = "Hello, AYTypeWriterLabel"
        typewriterView.startAnimation()
        
        //It works for both customization on the UILabel or the AttributedString
        /*
         Customization 1
        */
        //setupTextAppearance()
        
        /*
         Customization 2
         */
        typewriterView.label.attributedText = getAttributedText()
    }
    
    func setupTextAppearance() {
        typewriterView.label.textColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        typewriterView.label.font = UIFont(name: "Ubuntu-Bold", size: 18)
    }
    
    func getAttributedText() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "Hello, AYTypeWriterLabel", attributes:
            [NSAttributedStringKey.foregroundColor: UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0),
             NSAttributedStringKey.font: UIFont(name: "Ubuntu-Bold", size: 18)]
        )
        return attributedString
    }
    
    func setupTextAppearanceWithAttributedString() {
        
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

