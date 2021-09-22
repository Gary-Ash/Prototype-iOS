/*****************************************************************************************
 * ViewController.swift
 * 
 *
 *
 * Author   :  Gary Ash <gary.ash@icloud.com>
 * Created  :   4-Jun-2021  1:49am
 * Modified :  14-Sep-2021  2:41pm
 *
 * Copyright © 2021 By Gee Dbl A All rights reserved.
 ****************************************************************************************/

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

	@IBOutlet weak var button: UIButton!
	@IBOutlet weak var textView: PlaceHolderBorderedTextView!
	override func viewDidLoad() {
		super.viewDidLoad()
		textView.delegate = self
	}


	@IBAction func buttonTapped(_ sender: Any) {
		NSLog("text - \(String(describing: textView.text))")
	}

	func textViewDidBeginEditing(_ textView: UITextView) {
		NSLog("Begin edit")
	}


	func textViewDidEndEditing(_ textView: UITextView) {
		NSLog("end edit")

	}

}
