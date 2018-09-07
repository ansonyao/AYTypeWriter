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

