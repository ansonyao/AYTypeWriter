//
//  ViewController.swift
//  AYTypeWritter
//
//  Created by Anson Yao on 2018-09-05.
//  Copyright © 2018 Anson Yao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var exampleLabel: AYTypeWriterLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        exampleLabel.text = "Hello, AYTypeWriterLabel"
        exampleLabel.startAnimation()
    }
    
}

