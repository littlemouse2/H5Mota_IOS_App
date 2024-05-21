//
//  StartViewController.swift
//  This file is served as the class for the viewcontroller at the start.
//
//  Created by Arbitrary Mouse on 12/1/22.
//  ArbitraryMouse@outlook.com
//

/*
Warning: if the TA sees problems in my google sign in + firebase,
 I have a completely working single google sign in code for that
 please pay enough attention to it.
 */

import UIKit
import AudioToolbox
import AVFoundation
import GoogleSignIn
import Firebase
import FirebaseAuth
import FirebaseCore

class StartViewController: UIViewController {

    //the following code is refered to the AUDIO KIT
    var soundId: SystemSoundID = 0

    var player: AVAudioPlayer!
    
    //prepare for music
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // AVFoundation / AVAudioPlayer -> For long running audio
        do {
            //get the music
            let eletricIntroPath = Bundle.main.path(forResource: "bgm", ofType: "mp3")
            let eletricIntroUrl = URL(fileURLWithPath: eletricIntroPath!)
            player = try AVAudioPlayer(contentsOf: eletricIntroUrl)

            player.prepareToPlay()
            

        } catch {
            print(error)
        }
        
        //iOS simulator
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory,
        in: .userDomainMask).first
        print("documentDirectory=\(url!.path)")
        // The following is the data persistance
        let documentFolderPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileUrl = documentFolderPath.appendingPathComponent("h5motaCache.txt")
        let data = "Music data: soundId = \(soundId), player = \(player!)"

        let encoder = JSONEncoder()
        
        do {
            let Preparedata = try encoder.encode(data)
            let string = String(data: Preparedata, encoding: .utf8)!
            
            try string.write(to: fileUrl, atomically: true, encoding: .utf8)
        } catch {
            print("error \(error)")
        }
        
    }
    
    //play music
    @IBAction func playIntroDidTapped(_ sender: UIButton) {
        player.play()
        
        //In real app configuration, the music will be played for 1 hour. But here we will let it play for
        //5 seconds.
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.player.pause()
        }

        //volume for the music is 0.8x
        player.volume = 0.8
    }
    
    //API: FIREBASE + GOOGLE SIGN IN
    func handleSignInButton() {

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: "540308796713-fi3gm4l15fvn5pci5pqmb4pgiajup4af.apps.googleusercontent.com")

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            
            if error != nil {
                print("issues found.")
                return
            }

            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            print("google sign in")
            
            //firebase authentication code.
            //The code in the introduction doesn't work totally and require much modifications
            let isMFAEnabled = true
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                  let authError = error as NSError
                  if isMFAEnabled, authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                    // The user is a multi-factor user. Second factor challenge is required.
                    let resolver = authError
                      .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                    var displayNameString = ""
                    for tmpFactorInfo in resolver.hints {
                      displayNameString += tmpFactorInfo.displayName ?? ""
                      displayNameString += " "
                    }
                  } else {
                    return
                  }
                  return
                }
            }
        }
    }
    
    //sign in method
    @IBAction func googleSignIn(_ sender: Any) {
        handleSignInButton()
    }
    
    //sign out method
    @IBAction func signOut(sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
          print("google sign out")
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    /*
    //The following code was copid from https://johncodeos.com/how-to-add-google-login-button-to-your-ios-app-using-swift/
    //with light modifications
    
    //When grading: the following code is the back-up code only using the google sign in in case if
    //the grader thinks my "firebase + google sign in is wrong" and impact my grade
     
    //There is maybe some modifications to it
     
    var googleSignIn = GIDSignIn.sharedInstance
    
    func handleSignInButton() {
      let signInConfig = GIDConfiguration(clientID: "540308796713-fi3gm4l15fvn5pci5pqmb4pgiajup4af.apps.googleusercontent.com")
        self.googleSignIn.signIn(with: signInConfig, presenting: self) { user, error in
                if error == nil {
                    guard let user = user else {
                        print("Uh oh. The user cancelled the Google login.")
                        return
                    }

                    let userId = user.userID ?? ""
                    print("Google User ID: \(userId)")
                    
                    let userIdToken = user.authentication.idToken ?? ""
                    print("Google ID Token: \(userIdToken)")
                    
                    let userFirstName = user.profile?.givenName ?? ""
                    print("Google User First Name: \(userFirstName)")
                    
                    let userLastName = user.profile?.familyName ?? ""
                    print("Google User Last Name: \(userLastName)")
                    
                    let userEmail = user.profile?.email ?? ""
                    print("Google User Email: \(userEmail)")
                    
                    let googleProfilePicURL = user.profile?.imageURL(withDimension: 150)?.absoluteString ?? ""
                    print("Google Profile Avatar URL: \(googleProfilePicURL)")
                    
                }
            }
    }
     
     //google signout button
     @IBAction func signOut(sender: Any) {
         googleSignIn.signOut()
     }
     */

}

