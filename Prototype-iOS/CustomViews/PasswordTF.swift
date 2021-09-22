/*****************************************************************************************
 * PasswordTF.swift
 *
 * This file contains the implenentation of a specialize text field for entering user
 * passwords. This class displays error messages as needed
 *
 * Author   :  Gary Ash <gary.ash@icloud.com>
 * Created  :  14-Sep-2021  7:45pm
 * Modified :  14-Sep-2021  7:52pm
 *
 * Copyright © 2021 By Gee Dbl A All rights reserved.
 ****************************************************************************************/

import UIKit

@IBDesignable
class PasswordTF: UITextField, UITextFieldDelegate {
	private	let button = UIButton(type: .custom)

	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)!
		commonInit()
	}
	
	override required init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	override open func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		commonInit()
	}
	
	private func commonInit() {
		let largeConfiguration = UIImage.SymbolConfiguration(scale: .large)

		button.setImage(UIImage(systemName: "eye", withConfiguration: largeConfiguration), for: .normal)
		button.setImage(UIImage(systemName: "eye.slash", withConfiguration: largeConfiguration), for: .selected)
		button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
		rightView = button
		rightViewMode = .always
		button.isSelected = isSecureTextEntry
	}

	@objc func togglePasswordView(_ sender: Any) {
		isSecureTextEntry.toggle()
		button.isSelected.toggle()
	}

}
