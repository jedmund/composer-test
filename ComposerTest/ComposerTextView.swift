//
//  ComposerTextView.swift
//  ComposerTest
//
//  Created by Justin Edmund on 11/4/16.
//  Copyright © 2016 Justin Edmund. All rights reserved.
//

import PureLayout
import SlackTextViewController
import Then
import UIKit

class ComposerTextView: UIView {
    // MARK: View properties
    let textView: MaitsuTextView = MaitsuTextView().then {
        $0.isScrollEnabled = false
        $0.textSize = .medium
        $0.textContainer.lineFragmentPadding = 0
        $0.textContainerInset = .zero
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let error: ErrorLabel = ErrorLabel().then {
        $0.numberOfLines = 0
        $0.textColor = .maitsuNeutralGrey
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let line: UIView = UIView().then {
        $0.backgroundColor = .maitsuLightGrey
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Flag properties
    fileprivate var didSetupConstraints = false
    var lineEnabled = true
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.textView)
        // self.addSubview(self.error)
        
        if lineEnabled {
            self.addSubview(self.line)
        }
        
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View layout methods
    override func updateConstraints() {
        if !self.didSetupConstraints {
            let spacer2 = Global.Sizes.SpacingUnit * 2
            
            self.textView.autoPinEdge(toSuperviewEdge: .top, withInset: spacer2)
            self.textView.autoPinEdge(toSuperviewEdge: .leading, withInset: spacer2)
            self.textView.autoPinEdge(toSuperviewEdge: .trailing, withInset: spacer2)
            self.textView.autoPinEdge(toSuperviewEdge: .bottom, withInset: spacer2)
            
            // self.error.autoPinEdge(.top, to: .bottom, of: self.textView)
            // self.error.autoPinEdge(toSuperviewEdge: .leading, withInset: spacer2)
            // self.error.autoPinEdge(toSuperviewEdge: .trailing, withInset: spacer2)
            
            /* 
             if lineEnabled {
                self.line.autoPinEdge(.top, to: .bottom, of: self.error, withOffset: spacer2)
                self.line.autoPinEdge(toSuperviewEdge: .leading)
                self.line.autoPinEdge(toSuperviewEdge: .trailing)
                self.line.autoPinEdge(toSuperviewEdge: .bottom)
                self.line.autoSetDimension(.height, toSize: 1)
            } else {
                self.error.autoPinEdge(toSuperviewEdge: .bottom)
            }
            
            NSLayoutConstraint.autoSetPriority(.high, forConstraints: {
                self.error.autoSetContentHuggingPriority(for: .horizontal)
                self.error.autoSetContentHuggingPriority(for: .vertical)
            })
            */
            
            self.didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}
