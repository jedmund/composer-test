//
//  ErrorLabel.swift
//  ComposerTest
//
//  Created by Justin Edmund on 11/4/16.
//  Copyright © 2016 Justin Edmund. All rights reserved.
//

import Font
import UIKit

class UnauthLabel: UILabel {
    init() {
        super.init(frame: CGRect.zero)
        
        self.font = Font.StandardFont(16.0, weight: .regular, style: .none).generate()
        self.textColor = .maitsuBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias ErrorLabel = UnauthLabel
