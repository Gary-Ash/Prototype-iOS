/*****************************************************************************************
 * AppDelegate.swift
 *
 * This class implements the App Delegate
 *
 * Author   :  Gary Ash <gary.ash@icloud.com>
 * Created  :   4-Jun-2021  1:49am
 * Modified :  22-Sep-2021  3:24pm
 *
 * Copyright © 2021 By Gee Dbl A All rights reserved.
 ****************************************************************************************/

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}
}
