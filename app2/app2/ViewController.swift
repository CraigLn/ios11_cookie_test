//
//  ViewController.swift
//  app2
//
//  Created by Craig Lane on 10/3/17.
//  Copyright © 2017 Motorola Solutions Inc. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    fileprivate var _safariSession: SFAuthenticationSession?
    fileprivate let redirectScheme = "com.example.app2"

    @IBOutlet weak var serverHostname: UITextField!
    @IBOutlet weak var cookieLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func presentSafariAuthenticationSession(_ url: URL) {
        let safariSession = SFAuthenticationSession(url: url, callbackURLScheme: redirectScheme) { (callBack, error) in
            DispatchQueue.main.async {

                guard error == nil, let url = callBack, let queryItems = URLComponents(string: url.absoluteString)?.queryItems, let user = queryItems.first(where: { $0.name == "user" })?.value else {
                    print(error!)
                    self.cookieLabel.text = "Error retrieving cookie"
                    return
                }

                self.cookieLabel.text = (user == "None") ? "user cookie not set" : "User: \(user)"

                self._safariSession = nil
            }
        }

        self._safariSession = safariSession

        safariSession.start()
    }

    @IBAction func createUserCookie(_ sender: Any) {
        guard let hostname = serverHostname.text, let createCookieURL = URL(string: "http://\(hostname):5000/create-cookie/user?callbackUrl=\(redirectScheme)://") else {
            return
        }

        self.presentSafariAuthenticationSession(createCookieURL)
    }

    @IBAction func getUserCookie(_ sender: Any) {
        guard let hostname = serverHostname.text, let getCookieURL = URL(string: "http://\(hostname):5000/get-cookie/user?callbackUrl=\(redirectScheme)://") else {
            return
        }

        self.presentSafariAuthenticationSession(getCookieURL)
    }

    @IBAction func deleteUserCookie(_ sender: Any) {
        guard let hostname = serverHostname.text, let deleteCookieURL = URL(string: "http://\(hostname):5000/delete-cookie/user?callbackUrl=\(redirectScheme)://") else {
            return
        }

        self.presentSafariAuthenticationSession(deleteCookieURL)
    }
}
