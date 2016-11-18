//
//  ComposerView.swift
//  ComposerTest
//
//  Created by Justin Edmund on 11/4/16.
//  Copyright © 2016 Justin Edmund. All rights reserved.
//

import Font
import Then
import UIKit

class ComposerView: UIView {
    // MARK: Flag properties
    var didSetupConstraints = false
    
    // MARK: View properties
    let scrollView: UIScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.isUserInteractionEnabled = true
        $0.translatesAutoresizingMaskIntoConstraints = true
    }
    
    let stackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let contentField: ComposerTextView = ComposerTextView().then {
        $0.lineEnabled = false
        $0.textView.placeholder = "Please type as much text as you can in this text view."
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let mediaView: MediaView = MediaView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Validation properties
    /*
    let contentRules: ValidationRuleSet<String> = {
        var ruleset = ValidationRuleSet<String>()
        
        let minLengthRule = ValidationRuleMinLength(min: 3, failureError: ComposerValidationError.ContentTooShort)
        ruleset.add(rule: minLengthRule)
        
        return ruleset
    }()
    */
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        // Add subviews
        self.stackView.addArrangedSubview(self.contentField)
        self.stackView.addArrangedSubview(self.mediaView)
        self.scrollView.addSubview(self.stackView)
        self.addSubview(self.scrollView)
        
        // Add validation rules
        /*
        self.contentField.textView.validationRules = contentRules
        self.contentField.textView.validateOnInputChange(validationEnabled: true)
        self.contentField.textView.validateOnEditingEnd(validationEnabled: true)
        */
        
        self.setNeedsUpdateConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View layout methods
    override func updateConstraints() {
        if !self.didSetupConstraints {
            // Setup initial constraints
            self.scrollView.autoPinEdgesToSuperviewEdges()
            self.stackView.autoPinEdgesToSuperviewEdges()
            
            self.stackView.autoMatch(.height, to: .height, of: self)
            self.stackView.autoMatch(.width, to: .width, of: self)
            
            self.contentField.autoPinEdge(.leading, to: .leading, of: self)
            self.contentField.autoPinEdge(.trailing, to: .trailing, of: self)
            self.contentField.autoPinEdge(toSuperviewEdge: .top)

            self.mediaView.autoPinEdge(.leading, to: .leading, of: self)
            self.mediaView.autoPinEdge(.trailing, to: .trailing, of: self)
            self.mediaView.autoPinEdge(.top, to: .bottom, of: self.contentField)
            self.mediaView.autoSetDimension(.height, toSize: self.mediaView.height)
            
            NSLayoutConstraint.autoSetPriority(UILayoutPriorityDefaultHigh, forConstraints: {
                self.contentField.autoSetContentCompressionResistancePriority(for: .vertical)
            })
            
            self.didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
}
