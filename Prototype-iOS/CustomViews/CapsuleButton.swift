/*****************************************************************************************
 * CapsuleButton.swift
 * 
 * This class implements a UIButton with rounded edges
 *
 * Author   :  Gary Ash <gary.ash@icloud.com>
 * Created  :  16-Sep-2021 11:10am
 * Modified :  22-Sep-2021  2:42pm
 *
 * Copyright © 2021 By Gee Dbl A All rights reserved.
 ****************************************************************************************/

import UIKit

@IBDesignable
class CapsuleButton: UIButton {
	override public var isEnabled: Bool {
		didSet {
			if self.isEnabled {
				self.backgroundColor = self.backgroundColor?.withAlphaComponent(1.0)
			}
			else {
				self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.5)
			}
		}
	}

	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
		commonInit()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	override open func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		commonInit()
	}

	private func commonInit() {
		setTitleColor(UIColor.white, for: UIControl.State.highlighted)
		setTitleColor(UIColor.white, for: UIControl.State.normal)
		setTitleColor(UIColor.placeholderText, for: UIControl.State.disabled)
		titleLabel?.font   = .systemFont(ofSize : 18, weight : .semibold)
		backgroundColor    = UIColor.systemBlue
		layer.cornerRadius = 20
		clipsToBounds      = true
	}
}
