/*****************************************************************************************
 * PlaceHolderBorderedTextView.swift
 * 
 * This class implemeents a custom UITextView that supports a border around the view and
 * a place holder text feature like that standard UITextField
 *
 * Author   :  Gary Ash <gary.ash@icloud.com>
 * Created  :  13-Sep-2021  1:46am
 * Modified :  13-Sep-2021 11:47pm
 *
 * Copyright © 2021 By Gee Dbl A All rights reserved.
 ****************************************************************************************/

import UIKit

@IBDesignable
class PlaceHolderBorderedTextView: UITextView, UITextViewDelegate {
    @IBInspectable var placeHolderText: String = NSLocalizedString("Placeholder Text", comment: "")

    private var delegates: [UITextViewDelegate] = []

	override var text: String? {
		get {
			if super.text == placeHolderText {
				return ""
			}
			return super.text
		}
		set {
			super.text = newValue
		}
	}

    override weak  var delegate: UITextViewDelegate? {
		get { return super.delegate }
		set {
			if super.delegate != nil {
				delegates.append(newValue!)
            }
            else {
                super.delegate = newValue
            }
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }

    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

    private func commonInit() {
		delegate = self
		if text == nil || text!.isEmpty {
			textColor = UIColor.placeholderText
			text = placeHolderText
		}
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.borderColor = UIColor.placeholderText.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 8
        clipsToBounds = true
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.placeholderText {
            textView.textColor = UIColor.label
			textView.text = ""
        }

		for delegate in delegates {
			delegate.textViewDidBeginEditing?(textView)
		}
    }


    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeHolderText
            textView.textColor = UIColor.placeholderText
        }

		for delegate in delegates {
			delegate.textViewDidEndEditing?(textView)
		}
    }
}
