//
//  FrontPageViewController.swift
//  H5MOTA
//  This code is aimed for the introduction ViewController
//
//  Created by Arbitrary Mouse on 12/1/22.
//  ArbitraryMouse@outlook.com
//

import UIKit
import Foundation
import FBSDKShareKit

class FrontPageViewController : UIViewController{

    override func viewDidLoad() {
        //data persistence for small chunk of data
        let h5MotaURL = "https://h5mota.com"
        let userDefaults = UserDefaults.standard
        userDefaults.set(h5MotaURL, forKey: "sharingURL")
    }
    
    //API: FACEBOOK SHARE
    @IBAction func facebookTapped(_ sender: Any) {
        //data persistance
        let userDefaults = UserDefaults.standard
        var savedURL = userDefaults.string(forKey: "sharingURL")
        if(savedURL != "https://h5mota.com")
        {
            savedURL = "https://h5mota.com"
        }
        //code for facebook share
        //copied from https://developers.facebook.com/docs/ios/share-photos
        guard let url = URL(string: "https://h5mota.com") else {
            return
        }

        let content = ShareLinkContent()
        content.contentURL = url

        //code modified from original website since we need to sharing delegate here
        let dialog = ShareDialog(
            fromViewController: self,
            content: content,
            delegate: self as? SharingDelegate
        )
        dialog.show()
    }
    
}
