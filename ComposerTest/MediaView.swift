//
//  MediaView.swift
//  ComposerTest
//
//  Created by Justin Edmund on 11/4/16.
//  Copyright © 2016 Justin Edmund. All rights reserved.
//

import PureLayout
import UIKit

internal class MediaView: UIView {
    // MARK: View properties
    internal let scrollView: UIScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.isUserInteractionEnabled = true
        $0.translatesAutoresizingMaskIntoConstraints = true
    }
    
    // MARK: Data properties
    fileprivate var _media: [UIView] = []
    internal var media: [UIView] {
        get {
            return self._media
        }
    }
    
    // MARK: Configuration properties
    internal let gutter: CGFloat = Global.Sizes.SpacingUnit * 2
    internal let spacer: CGFloat = Global.Sizes.SpacingUnit
    internal let height: CGFloat = 120.0
    
    // MARK: Flag properties
    fileprivate var didSetupConstraints: Bool = false
    
    // MARK: - Initializers
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.scrollView)
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View layout methods
    override func updateConstraints() {
        if !self.didSetupConstraints {
            self.scrollView.autoPinEdgesToSuperviewEdges()
            self.didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    // MARK: - Collection methods
    func add(view: UIView) {
        // Add the remove icon to the added view
        let removeIcon = self.removeIcon()
        view.addSubview(removeIcon)
        
        // Set the view's corner radius
        view.layer.cornerRadius = Global.Sizes.CardCornerRadius
        view.clipsToBounds = true
        
        // Set the remove icon's constraints
        removeIcon.autoPinEdge(toSuperviewEdge: .top, withInset: self.spacer)
        removeIcon.autoPinEdge(toSuperviewEdge: .trailing, withInset: self.spacer)
        
        // Add the added view to the scroll view
        self.scrollView.addSubview(view)
        
        // Set up constraints for the new view
        self.addConstraints(for: view)
        
        // Set the scroll view's new content size
        let leadingSpace: CGFloat = (self.media.count > 0) ? 0 : self.spacer
        let contentWidth: CGFloat = self.scrollView.contentSize.width + view.frame.size.width + self.spacer + leadingSpace
        self.scrollView.contentSize = CGSize(width: contentWidth, height: self.height)
        
        // Append the added view to our array of media views
        self._media.append(view)
    }
    
    func remove(sender: Any?) {
        // Safely unwrap the necessary values to do work
        guard let recognizer = sender as? UITapGestureRecognizer else { return }
        guard let iconView = recognizer.view else { return }
        guard let view = iconView.superview else { return }
        guard let index = self.media.index(of: view) else { return }
        
        // Remove the view from our array and its superview
        self._media.remove(at: index)
        view.removeFromSuperview()
        
        // Reconfigure constraints of remaining media items
        if (self.scrollView.subviews.count > 0) {
            let adjustedIndex = (index >= self.scrollView.subviews.count) ? index - 1 : index
            let view = self.scrollView.subviews[adjustedIndex]
            
            if (index == 0) {
                view.autoPinEdge(toSuperviewEdge: .leading, withInset: self.spacer)
            } else {
                view.autoPinEdge(.leading, to: .trailing, of: self.scrollView.subviews[index - 1], withOffset: self.spacer)
            }
        }
    }
    
    // MARK: - Private helper methods
    fileprivate func removeIcon() -> UIImageView {
        // Set up view for icon
        let assetName = "CircleCross"
        let icon = UIImage(named: assetName)
        let iconView = UIImageView(image: icon)
        iconView.isUserInteractionEnabled = true
        
        // Set up tap gesture recognizer so icon can perform its function
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.remove(sender:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        iconView.addGestureRecognizer(tapGesture)
        
        return iconView
    }
    
    fileprivate func addConstraints(for view: UIView) {
        let size = CGSize(width: self.calculateWidth(for: view), height: self.height)
        
        view.autoPinEdge(toSuperviewEdge: .top)
        view.autoSetDimensions(to: size)
        
        if (self.media.count > 0) {
            view.autoPinEdge(.leading, to: .trailing, of: self.media.last!, withOffset: self.spacer)
        } else {
            view.autoPinEdge(toSuperviewEdge: .leading, withInset: self.spacer)
        }
    }
    
    fileprivate func calculateWidth(for view: UIView) -> CGFloat {
        let width = view.frame.width
        let height = view.frame.height
        return width / (height / self.height)
    }
}

