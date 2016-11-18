//
//  ViewController.swift
//  ComposerTest
//
//  Created by Justin Edmund on 11/4/16.
//  Copyright © 2016 Justin Edmund. All rights reserved.
//

import SlackTextViewController
import UIKit

class ViewController: UIViewController, SLKTextViewDelegate, Notifiable {

    fileprivate var didSetupConstraints = false
    var bottomConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    let defaultHeight: CGFloat = 50
    
    let composerView = ComposerView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .maitsuCream
        
        self.register()
        
        self.composerView.contentField.textView.delegate = self
        
        let image1 = UIImageView(image: UIImage(named: "utomaru1"))
        let image2 = UIImageView(image: UIImage(named: "utomaru2"))
        let image3 = UIImageView(image: UIImage(named: "utomaru3"))
        
        self.composerView.mediaView.add(view: image1)
        self.composerView.mediaView.add(view: image2)
        self.composerView.mediaView.add(view: image3)
        
        self.view.addSubview(self.composerView)
    }

    override func updateViewConstraints() {
        Log.info("Updating view constraints...")
        
        if !self.didSetupConstraints {
            self.composerView.autoPinEdge(toSuperviewMargin: .top)
            self.composerView.autoPinEdge(toSuperviewEdge: .leading)
            self.composerView.autoPinEdge(toSuperviewEdge: .trailing)
            
            if (self.heightConstraint == nil) {
                self.heightConstraint = self.composerView.contentField.textView.heightAnchor.constraint(equalToConstant: self.defaultHeight)
                self.heightConstraint?.isActive = true
            }
            
            if (self.bottomConstraint == nil) {
                self.bottomConstraint = self.composerView.autoPin(toBottomLayoutGuideOf: self, withInset: Global.Sizes.SpacingUnit)
            }
            
            self.didSetupConstraints = true
        }
        
        Log.info("Height constraint: \(self.heightConstraint)")
        
        super.updateViewConstraints()
    }
    
    func textViewDidChange(_ textView: UITextView) {
//        textView.sizeToFit()
//        textView.layoutIfNeeded()
        
        let bounds: CGSize = CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        let size: CGSize = textView.sizeThatFits(bounds)
        let height: CGFloat = ceil(size.height)

        self.heightConstraint?.constant = (height < self.defaultHeight) ? self.defaultHeight : height
        self.view.setNeedsUpdateConstraints()
    }
}

protocol Notifiable { }
extension Notifiable where Self: ViewController {
    func register() {
        let mainQueue = OperationQueue.main
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: mainQueue, using: self.keyboardWillShow)
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: mainQueue, using: self.keyboardWillHide)
    }
    
    func unregister() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: Notification) {
        self.updateBottomConstraint(notification: notification)
    }
    
    func keyboardWillHide(notification: Notification) {
        self.updateBottomConstraint(notification: notification)
    }
    
    fileprivate func updateBottomConstraint(notification: Notification) {
        guard let userInfo = (notification as NSNotification).userInfo else { return }
        
        // Setup bottom constraint
        if (self.bottomConstraint == nil) {
            self.bottomConstraint = self.composerView.autoPin(toBottomLayoutGuideOf: self, withInset: Global.Sizes.SpacingUnit)
        }
        
        // Fetch the duration of the keyboard animation from the userInfo dict
        // let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        // Fetch the keyboard's end frame and convert it to the coordinate system of this VC's view
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let convertedKeyboardEndFrame = self.view.convert(keyboardEndFrame, from: self.view.window)
        
        // Log.info(convertedKeyboardEndFrame)
        
        // Fetch the keyboard's animation curve and use it to instantiate UIViewAnimationOptions
        // let rawAnimationCurve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).uint32Value << 16
        // let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
        
        // Set the composer view's bottom constraint based on the view's bounds, the keyboard's end frame, and a spacer
        if (self.view.bounds.maxY - convertedKeyboardEndFrame.minY <= 0) {
            self.bottomConstraint?.constant = -Global.Sizes.SpacingUnit
        } else {
            self.bottomConstraint?.constant = -(self.view.bounds.maxY - convertedKeyboardEndFrame.minY + Global.Sizes.SpacingUnit)
        }
        
        // Update the layout to make changes take effect
        // self.view.layoutIfNeeded()
    }
}
