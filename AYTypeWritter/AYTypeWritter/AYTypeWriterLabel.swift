//
//  AYTypeWritterLabel.swift
//  AYTypeWritter
//
//  Created by Anson Yao on 2018-09-05.
//  Copyright © 2018 Anson Yao. All rights reserved.
//

import UIKit

protocol AYTypeWriterLabelDelegate: class {
    func animationFinished()
}

class AYTypeWriterLabel: UILabel {
    var isAttributedStringSet = false
    var timer: Timer?
    var currentIndex = 0
    var paused = false
    
    /**
        Start animation, from the beginning
     */
    public func startAnimation() {
        guard let text = self.text else { return }
        let startIndex = text.startIndex
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (timer) in
            guard !self.paused else { return }
            let index = text.index(startIndex, offsetBy: self.currentIndex)
            self.animate(index: index)
            self.currentIndex += 1
            
            if index == text.endIndex {
                self.timer?.invalidate()
                self.timer = nil
            }
        })
    }
    
    
    public func toggleAnimation() {
        paused = !paused
    }
    
    public func resetAnimation() {
        currentIndex = 0
    }
    
    private func animate(index: String.Index) {
        guard let text = self.text else { return }
        let combinedAttributedString = NSMutableAttributedString()
        let showingString = String(text[..<index])
        let hidingString = String(text[index...])
        let showingAttributedString = NSAttributedString(string: showingString, attributes: nil)
        let hidingAttributedString = NSAttributedString(string: hidingString, attributes: [NSAttributedStringKey.foregroundColor : UIColor.clear])
        combinedAttributedString.append(showingAttributedString)
        combinedAttributedString.append(hidingAttributedString)
        self.attributedText = combinedAttributedString
    }
}
