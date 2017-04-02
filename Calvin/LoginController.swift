//
//  LoginViewController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 05.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class LoginController : UIViewController {
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func onContinue(_ sender: UIButton) {
        self.progress.alpha = 1.0

        self.state.text = "Téléchargement en cours..."
        
        let hash = sha256(forInput: (name.text?.uppercased().trimmingCharacters(in: .whitespaces))!)
        
        login(controller: self, userHash: hash, onResponse: loginResponse)
        
        self.progress.setProgress(0.1, animated: true)
    }
    
    @IBAction func dismiss(_ sender: UITextField) {
        self.view.endEditing(true)
    }
    
    func loginResponse(success : Bool) {
        DispatchQueue.main.sync {
            if success {
                self.progress.setProgress(1.0, animated: true)
                
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "Dashboard")
                
                self.present(controller!, animated: true, completion: nil)
            } else {
                self.progress.setProgress(0.0, animated: true)
                self.state.text = "La vérification du nom a échouée."
            }
        }
    }
}
