/*****************************************************************************************
 * LocationTF.swift
 * 
 * This class implements a iOS text field with a button to insert the user's location as
 * by the phone's GPS as an option
 *
 * Author   :  Gary Ash <gary.ash@icloud.com>
 * Created  :  9/16/21 10:50 PM
 * Modified :  
 *
 * Copyright © 2021 By Gee Dbl A All rights reserved.
 ****************************************************************************************/

import CoreLocation
import UIKit

@IBDesignable
class LocationTF: UITextField, CLLocationManagerDelegate {
	let locationManager = CLLocationManager()

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
		let image = UIImage(systemName: "location", withConfiguration: largeConfiguration)

		let rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: frame.height, height: frame.height))
		self.rightView = rightView
		rightViewMode = .always
		let locationButtonView = UIImageView(image: image)
		locationButtonView.isUserInteractionEnabled = true
		self.rightView?.addSubview(locationButtonView)
		locationButtonView.center = CGPoint(x: rightView.bounds.midX, y: rightView.bounds.midY)
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getLocationTapped))
		locationButtonView.addGestureRecognizer(gestureRecognizer)
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.distanceFilter = 200

		if locationManager.authorizationStatus == .authorizedAlways ||
			locationManager.authorizationStatus == .authorizedWhenInUse {
			locationManager.requestLocation()
		}
	}

	@objc func getLocationTapped() {
		locationManager.requestWhenInUseAuthorization()
		locationManager.requestLocation()
	}

	func locationManager(_: CLLocationManager, didFailWithError _: Error) {}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations _: [CLLocation]) {
		if let location = manager.location {
			let geocoder = CLGeocoder()
			geocoder.reverseGeocodeLocation(location,
											completionHandler: { placemarks, error in
												if error == nil {
													if let placemarks = placemarks?[0] {
														if let city = placemarks.locality {
															self.text = city
														}
														if let stateArea = placemarks.administrativeArea {
															self.text = self.text! + ", " + stateArea
														}
														if let country = placemarks.country {
															self.text = self.text! + ", " + country
														}
													}
												}
											})
		}
	}
}
