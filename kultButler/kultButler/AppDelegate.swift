//
//  AppDelegate.swift
//  kultButler
//
//  Created by Gabriel Knoll on 12.04.21.
//

import Apollo
import SumUpSDK
import UIKit

// swiftlint:disable line_length

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		Network.shared.loadProducts()

		//SumUp Integration / Payment Key
		#if DEBUG
		/*
		*   Logs integration warnings in non-production code. Do not call this method in
		*   release builds.
		*/
		SumUpSDK.testIntegration()
		#endif

		SumUpSDK.setup(withAPIKey: "4e29fecf-e88d-43e2-b258-16a0f3203528")

		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}
}
