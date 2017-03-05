//
//  LoginViewController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 05.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class LoginViewContrller : UIViewController {
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var name: UITextField!
    
    var shaHash = "none"
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onContinue(_ sender: UIButton) {
        self.progress.alpha = 1.0
        self.progress.setProgress(0.1, animated: true)
        self.state.text = "Vérification du nom..."
        
        let shaData = sha256(string: (name.text?.uppercased())!)
        self.shaHash = shaData!.map { String(format: "%02hhx", $0) }.joined()
        
        request(withID: "timetable&hash=" + self.shaHash, controller: self, callback: login)
    }
    
    func login(name : String) {
        DispatchQueue.main.async {
            if name.characters.count < 52 {
                self.progress.setProgress(0.0, animated: true)
                self.state.text = "La vérification du nom a échouée."
            } else {
                self.progress.setProgress(0.2, animated: true)
                self.state.text = "Téléchargement en cours..."
                
                UserDefaults.standard.set(self.shaHash, forKey: "user-hash")
                AppDelegate.userHash = self.shaHash

                self.progress.setProgress(1.0, animated: true)
                
                self.show(UIViewController, sender: <#T##Any?#>)
            }
        }
    }
    
    func sha256(string: String) -> Data? {
        guard let messageData = string.data(using:String.Encoding.utf8) else { return nil }
        var digestData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_SHA256(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        return digestData
    }
}
