//
//  UITableViewCell+Extension.swift
//  FloatingLabel
//
//  Created by Kevin Hirsch on 11/08/15.
//  Copyright (c) 2015 Kevin Hirsch. All rights reserved.
//

import UIKit
import DropDown

internal extension UIView {
	
	func parentTableView() -> UITableView? {
		return findSuperviewOfClass(UITableView) as? UITableView
	}
	
	func parentCollectionView() -> UICollectionView? {
		return findSuperviewOfClass(UICollectionView) as? UICollectionView
	}
	
	private func findSuperviewOfClass(viewClass: AnyClass) -> UIView? {
		var view = self.superview
		
		while let superview = view where !superview.isKindOfClass(viewClass) {
			view = view?.superview
		}
		
		if let view = view where view.isKindOfClass(viewClass) {
			return view
		} else {
			return nil
		}
	}
	
	func performBatchUpdates(batchUpdates: Closure) {
		if let tableView = parentTableView() {
			tableView.beginUpdates()
			batchUpdates()
			layoutIfNeeded()
			tableView.endUpdates()
		} else if let collectionView = parentCollectionView() {
			collectionView.performBatchUpdates(batchUpdates, completion: nil)
		} else {
			batchUpdates()
		}
	}
	
}

//MARK: - Constraints

internal extension UIView {
	
	func addConstraints(format format: String, options: NSLayoutFormatOptions = [], metrics: [String: AnyObject]? = nil, views: [String: UIView]) {
		addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: options, metrics: metrics, views: views))
	}
	
	func addUniversalConstraints(format format: String, options: NSLayoutFormatOptions = [], metrics: [String: AnyObject]? = nil, views: [String: UIView]) {
		addConstraints(format: "H:\(format)", options: options, metrics: metrics, views: views)
		addConstraints(format: "V:\(format)", options: options, metrics: metrics, views: views)
	}
	
}
