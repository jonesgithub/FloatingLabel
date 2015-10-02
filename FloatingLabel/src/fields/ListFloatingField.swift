//
//  ListFloatingField.swift
//  FloatingLabel
//
//  Created by Kevin Hirsch on 27/07/15.
//  Copyright (c) 2015 Kevin Hirsch. All rights reserved.
//

import UIKit

public class ListFloatingField: ActionFloatingField {
	
	//MARK: - Properties
	
	//MARK: UI
	private let dropDown = DropDown()
	
	//MARK: Content
	public var dataSource: [String] {
		get { return dropDown.dataSource }
		set { dropDown.dataSource = newValue }
	}
	
	public var selectedItem: String?
	
	public var selectedRow: Index? {
		get { return dropDown.indexForSelectedRow() }
		set {
			if let newValue = newValue
				where newValue >= 0 && newValue < dataSource.count
			{
				dropDown.selectRowAtIndex(newValue)
			} else {
				dropDown.deselectRowAtIndexPath(newValue)
			}
		}
	}
	
	public override var isEditing: Bool {
		return editing
	}
	
	private var editing = false {
		didSet { updateUI(animated: true) }
	}
	
	//MARK: - Init's
	
	convenience init() {
		self.init(frame: Frame.InitialFrame)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
}

//MARK: - Initialization

extension ListFloatingField {
	
	internal override func setup() {
		super.setup()
		
		rightView = UIImageView(image: Icon.Arrow.image().template())
		rightViewMode = .Always
		
		setNeedsUpdateConstraints()
		
		dropDown.anchorView = self
		dropDown.topOffset = CGPoint(x: Constraints.HorizontalPadding, y: -bounds.height)
		
		dropDown.selectionAction = { [unowned self] (index, item) in
			self.editing = false
			
			self.selectedItem = item
			self.selectedRow = index
			self.text = item
			
			self.valueChangedAction?(item)
		}
		
		dropDown.cancelAction = { [unowned self] in
			self.editing = false
		}
		
		action = { [unowned self] in
			self.editing = true
			self.dropDown.show()
		}
	}
	
}

//MARK: - Initialization

extension ListFloatingField {
	
	public override func layoutSublayersOfLayer(layer: CALayer) {
		super.layoutSublayersOfLayer(layer)
		
		let separatorLineMinY = separatorLine.superview!.convertRect(separatorLine.frame, toView: dropDown.anchorView).minY - 1
		dropDown.bottomOffset = CGPoint(x: Constraints.HorizontalPadding, y: separatorLineMinY)
		dropDown.width = separatorLine.bounds.width
	}
	
	override func updateUI(animated animated: Bool) {
		super.updateUI(animated: animated)
		
		if isFloatingLabelDisplayed {
			dropDown.topOffset.y = -bounds.height
		} else {
			let floatingLabelMinY = floatingLabel.superview!.convertRect(floatingLabel.frame, toView: dropDown.anchorView).minY
			dropDown.topOffset.y = -bounds.height + floatingLabelMinY
		}
	}
	
}