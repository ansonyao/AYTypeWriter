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

public class AYTypeWriterLabel: UILabel {
    public var shouldPlayTypingSound = false
    public var shouldShowCursor = false
    
    private var originalAttributedString = NSAttributedString()
    private var locationArray = [Int]()
    private var currentLocation: Int {
        if currentLocationIndex >= locationArray.count {
            return 0
        } else {
            return locationArray[currentLocationIndex]
        }
    }
    
    private var isAttributedStringSet = false
    private var timer: Timer?
    private var currentLocationIndex = 0
    private var paused = false
    
    //MARK: - Public Interface
    public func startAnimation() {
        resetAnimation()
        copyOriginalAttributedString()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (timer) in
            guard !self.paused else { return }
            self.animate(location: self.currentLocation)
            self.currentLocationIndex += 1
            print(self.currentLocation)
            if self.currentLocationIndex > self.locationArray.count {
                self.timer?.invalidate()
                self.timer = nil
            }
        })
    }
    
    public func pauseAnimation() {
        paused = true
    }
    
    public func resumeAnimation() {
        paused = false
    }
    
    //TODO: under construction
    public func resetAnimation() {
        if currentLocationIndex != 0 {
            currentLocationIndex = 0
        }
        if originalAttributedString.length > 0 {
            animate(location: 0)
        }
    }
    
    //TODO: under construction
    public func stopAnimation() {
        //resetAnimationIndex()
        guard let text = self.text else { return }
//        animate(index: text.endIndex)
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    //MARK: - Private Helpers
    
    private func copyOriginalAttributedString() {
        guard currentLocationIndex == 0 else { return }
        guard let tmp = self.attributedText else { return }
        originalAttributedString = NSAttributedString(attributedString: tmp) //This is a dangerous operation. Need to ensure the label is reset before copying.
        locationArray.removeAll()
        for (location, _) in self.originalAttributedString.string.enumerated() {
            locationArray.append(location)
        }

    }
    
    private func animate(location: Int) {
        let text = originalAttributedString.string
        let startIndex = originalAttributedString.string.startIndex
        let index = text.index(startIndex, offsetBy: location)
        animate(index: index)
    }
    
    private func animate(index: String.Index) {
        let startIndex = originalAttributedString.string.startIndex
        let endIndex = originalAttributedString.string.endIndex
        
        let combinedAttributedString = NSMutableAttributedString()
        let showingAttributedString = subAttributedString(from: startIndex, to: index, attributedString: originalAttributedString)
        let hidingAttributedStringOriginal = subAttributedString(from: index, to: endIndex, attributedString: originalAttributedString)
        let hidingAttributedStringMutable = NSMutableAttributedString(attributedString: hidingAttributedStringOriginal)
        let range = hidingAttributedStringMutable.string.startIndex..<hidingAttributedStringMutable.string.endIndex
        hidingAttributedStringMutable.addAttributes([
                NSAttributedStringKey.foregroundColor : UIColor.clear,
                NSAttributedStringKey.strikethroughColor : UIColor.clear,
                NSAttributedStringKey.underlineColor : UIColor.clear
            ], range: NSRange(range, in: hidingAttributedStringMutable.string))
        
        let hidingAttributedString = hidingAttributedStringMutable as NSAttributedString
        combinedAttributedString.append(showingAttributedString)
        combinedAttributedString.append(hidingAttributedString)
        print(combinedAttributedString.string)
        self.attributedText = combinedAttributedString
    }
    
    private func subAttributedString(from startIndex: String.Index, to endIndex: String.Index, attributedString: NSAttributedString) -> NSAttributedString {
        let result = NSMutableAttributedString()
        let string = attributedString.string
        for (location, _) in string[startIndex..<endIndex].enumerated() {
            let index = string.index(startIndex, offsetBy: location)
            let tmp = NSAttributedString(string: String(string[index]), attributes: attributedString.attributes(at: location, effectiveRange: nil))
            result.append(tmp)
        }
        return result
    }
}
