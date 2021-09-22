/*****************************************************************************************
 * ProfilePhotoView.swift
 * 
 * This file contains the the implementation of the the user profile photo display and
 * selection custom view
 *
 * Author   :  Gary Ash <gary.ash@icloud.com>
 * Created  :  14-Sep-2021  2:40am
 * Modified :  19-Sep-2021 11:47pm
 *
 * Copyright © 2021 By Gee Dbl A All rights reserved.
 ****************************************************************************************/

import UIKit

@IBDesignable
class ProfilePhotoView: UIImageView, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
	@IBInspectable var photoShape: Int = 2
    @IBInspectable var allowEditing: Bool = true
    @IBInspectable var borderColor: UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)

	private var editPrompt: UILabel?
    private let pickerController = UIImagePickerController()
    private weak var presentationController: UIViewController?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }

    override required init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
		commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        clipsToBounds = true

        if borderColor.cgColor.alpha > 0.0 {
            layer.borderWidth = 4
        }
        layer.masksToBounds = true
		layer.borderColor =  borderColor.cgColor
		if photoShape == 2 {
			layer.cornerRadius = frame.width / 2
		}
		else if photoShape == 1 {
			layer.cornerRadius = 20.0
		}
    }

	private func makeEditPrompt() {
		editPrompt = UILabel()
		editPrompt?.textAlignment = .center
		editPrompt?.textColor = UIColor.white
		editPrompt?.backgroundColor = UIColor.lightGray
		editPrompt?.layer.borderColor = UIColor.darkGray.cgColor
		editPrompt?.layer.borderWidth = 1.0
		editPrompt?.layer.cornerRadius = 5.0
		editPrompt?.layer.masksToBounds = true
		editPrompt?.clipsToBounds = true
		editPrompt?.text = NSLocalizedString(" Tap To Edit ", comment: "")
		editPrompt?.translatesAutoresizingMaskIntoConstraints = false
		addSubview(editPrompt!)

		editPrompt?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		addConstraint(NSLayoutConstraint(item: editPrompt!,
										 attribute: NSLayoutConstraint.Attribute.bottom,
										 relatedBy: NSLayoutConstraint.Relation.equal,
										 toItem: self,
										 attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -30))
	}

    private func commonInit() {
        let largeConfiguration = UIImage.SymbolConfiguration(scale: .large)
		if borderColor.cgColor.alpha > 0.0 {
			image = UIImage(systemName: "person.fill", withConfiguration: largeConfiguration)!.withTintColor(borderColor)
		}
		else {
			image = UIImage(systemName: "person.fill", withConfiguration: largeConfiguration)!.withTintColor(UIColor.systemBlue)
		}

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profilePhotoTapped))
        self.addGestureRecognizer(gestureRecognizer)
        self.isUserInteractionEnabled = true

        pickerController.delegate = self
        pickerController.allowsEditing = true

		makeEditPrompt()
    }

    @objc func profilePhotoTapped() {
        if allowEditing {
			self.presentationController = self.getOwningViewController()
            present(from: self)
        }
    }

    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }

    public func present(from sourceView: UIView) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = self.action(for: .camera, title: NSLocalizedString("Take photo", comment: "")) {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: NSLocalizedString("Camera roll", comment: "")) {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: NSLocalizedString("Photo library", comment: "")) {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        presentationController?.present(alertController, animated: true)
    }

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])  {
        guard let image = info[.editedImage] as? UIImage else {
            return pickerController(picker, didSelect: nil)
        }

        let sourceOptions = [kCGImageSourceShouldCache:false] as CFDictionary
        let source = CGImageSourceCreateWithData(image.jpegData(compressionQuality: 0.9)! as CFData, sourceOptions)!
        let downsampleOptions = [kCGImageSourceCreateThumbnailFromImageAlways:true,
                                 kCGImageSourceThumbnailMaxPixelSize: 400.0,
                                 kCGImageSourceShouldCacheImmediately:true,
                                 kCGImageSourceCreateThumbnailWithTransform:true] as CFDictionary

        let downsampledImage = CGImageSourceCreateThumbnailAtIndex(source, 0, downsampleOptions)!
        self.image = UIImage(cgImage: downsampledImage)
        pickerController(picker, didSelect: self.image)
    }
}

extension UIResponder {
	func getOwningViewController() -> UIViewController? {
		var nextResponser = self
		while let next = nextResponser.next {
			nextResponser = next
			if let viewController = nextResponser as? UIViewController {
				return viewController
			}
		}
		return nil
	}
}
