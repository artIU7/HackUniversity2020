//
//  AppDelegate.swift
//  Sky.Tech-Route.Rebuild
//
//  Created by Артем Стратиенко on 17/08/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import UIKit
import NMAKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let registrationData =
        (appId: "7T8UgnMEkQDNCeJH182A",
        appCode: "wfyqs2ZxyVaiTgdkqDnIcQ",
        licenseKey: "hL8pHBv0MVECxndHUAZqf8HPPoPKusdmGlEG931xUoVoA6IkfiHujvE/boHQmmDe/XrkjLPlVFJuh+Xqct6pvyNsGT7pkSMKu+cqmE1mqt7y6kzL6Xa4nxM8h0iblvneZNYeey5rTD5JOcU+IPr6zFb0TSrWm54ifWyc/Ia2hn5/cxDHGgRkO5HIHnaTQQ4qg+t8kPEUKUzy33i9Ouqq64mumoyTmy0KMorIOXvj9FJONsXRLRCDbdXPJqbc3e8azOJtRPsSTcjjBWFMtIZbOCfjMlcWpC7EyIiAa73FzEhUQEKY3sb4QPNTIBO6IZR0YHwvSjHudrpDldKtks7xseTBvzN8hmJoHbkPix3+8rLmVll/jeWxw9I7d14Kvk0YBHZyHjmNR70s60EmbVDoLfNrlSWMckBNMfJcVig2QUNn5GXsULpg+dKEm8aWrAjShQeCLMQlgD7IvMje1f7uey4GfWZ8A/7l8CedXcnWN33lx40qNqKn1NvKsiJREISTePdSwdLVfCc7UuOUT+YaqU/BFgncH8gLWEZWUzd0bOj/waZk8Rf4xiWWqsfgNiBufPLrWrTm41fJX+CloteDoXnbSCDPslFORNVDEBDXfVUm2bN/Whd/snzhovtY7arUEs9g3yUOv0VCkkdy4Ttc0N8kHIIQsWB3sMgT0NaNYi4="
    )
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NMAApplicationContext.setAppId(registrationData.appId, appCode: registrationData.appCode, licenseKey: registrationData.licenseKey)
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

