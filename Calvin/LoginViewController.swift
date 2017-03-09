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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func onContinue(_ sender: UIButton) {
        self.progress.alpha = 1.0
        self.progress.setProgress(0.1, animated: true)

        self.state.text = "Vérification du nom..."
        
        self.shaHash = sha256(forInput: (name.text?.uppercased())!)
        
        request(withID: "timetable&hash=" + self.shaHash, controller: self, callback: login)
    }
    
    @IBAction func dismiss(_ sender: UITextField) {
        self.view.endEditing(true)
    }
    
    func login(name : String) {
        DispatchQueue.main.async {
            if name.characters.count < 104 {
                self.progress.setProgress(0.0, animated: true)
                self.state.text = "La vérification du nom a échouée."
            } else {
                self.progress.setProgress(0.2, animated: true)
                self.state.text = "Téléchargement en cours..."
                
                UserDefaults.standard.set(self.shaHash, forKey: "user-hash")
                AppDelegate.userHash = self.shaHash

                self.progress.setProgress(1.0, animated: true)
                
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "Dashboard")
               
                self.present(controller!, animated: true, completion: nil)
            }
        }
    }
}
