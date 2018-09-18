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

//Hint: if you want to change the text after an animation is performed. You

public class AYTypewriterView: UIView {
    public var shouldPlayTypingSound = false //TODO
    public var shouldShowCursor = false //TODO
    public var typingSpeed = 0 //TODO
    public var randomTypingInterval = false //TODO
    
    public var label = UILabel()
    private var displayingLabel = UILabel()
    
    private var originalAttributedString: NSAttributedString {
        return label.attributedText ?? NSAttributedString()
    }
    private var locationArray: [Int] {
        //TODO: use fp to make it clean.
        var results = [Int]()
        for (location, _) in self.originalAttributedString.string.enumerated() {
            results.append(location)
        }
        return results
    }
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.addSubview(label)
        self.addSubview(displayingLabel)
        addConstraintsToFillParent(label)
        addConstraintsToFillParent(displayingLabel)
        label.isHidden = true
        displayingLabel.textAlignment = NSTextAlignment.center
    }


    //MARK: - Public Interface
    public func startAnimation() {
        resetAnimation()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (timer) in
            guard !self.paused else { return }
            self.isHidden = false
            if self.currentLocation == self.locationArray.count - 1 {
                self.finishAnimation()
            } else {
                self.animate(location: self.currentLocation)
                self.currentLocationIndex += 1
            }
        })
    }
    
    public func pauseAnimation() {
        paused = true
    }
    
    public func resumeAnimation() {
        paused = false
    }
    
    public func finishAnimation() {
        timer?.invalidate()
        timer = nil
        animate(index: originalAttributedString.string.endIndex)
    }
    
    public func clearAnimation() {
        resetAnimation()
        self.animate(index: originalAttributedString.string.startIndex)
    }
    
    //TODO: under construction
    private func resetAnimation() {
        if currentLocationIndex != 0 {
            currentLocationIndex = 0
        }
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    //MARK: - Private Helper
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
        displayingLabel.attributedText = combinedAttributedString
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
    
    
    private func addConstraintsToFillParent(_ view: UIView) {
        guard let parentView = view.superview else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraintLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: parentView, attribute: .left, multiplier: 1.0, constant: 0.0)
        let constraintRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: parentView, attribute: .right, multiplier: 1.0, constant: 0.0)
        let constraintTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let constraintBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        parentView.addConstraints([constraintLeft, constraintRight, constraintTop, constraintBottom])
    }
}
