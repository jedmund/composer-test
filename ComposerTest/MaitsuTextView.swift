//
//  MaitsuTextView.swift
//  ComposerTest
//
//  Created by Justin Edmund on 11/4/16.
//  Copyright © 2016 Justin Edmund. All rights reserved.
//

import Font
import SlackTextViewController
import UIKit

class MaitsuTextView: SLKTextView {
    // MARK: - Properties
    var color: UIColor = .maitsuOrange {
        didSet {
            self.textColor = color
            self.tintColor = color
        }
    }
    
    var textSize: MaitsuTextFieldSize? {
        didSet {
            guard let size = self.textSize else { fatalError("Text size was not set properly.") }
            self.font = Font.StandardFont(size.rawValue, weight: .regular, style: .none).generate()
        }
    }
    
    // MARK: Validation properties
    weak var errorLabel: UILabel?
    var validationEnabled: Bool = false
    var isValid: Bool = false
    
    // MARK: - Initializers
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.backgroundColor = .clear
        self.placeholderNumberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


