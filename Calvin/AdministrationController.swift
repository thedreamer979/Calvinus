//
//  AdministrationController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 25.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class AdministrationController : BasicController {
   
    @IBOutlet weak var data: UITextView!
    @IBOutlet weak var passwd: UITextField!
    @IBOutlet weak var send: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func uploadDone() {
        DispatchQueue.main.async {
            self.send.isEnabled = true
            self.loading.stopAnimating()
        }
    }
    
    @IBAction func send(_ sender: UIButton) {
        self.send.isEnabled = false
        self.loading.startAnimating()
        self.view.endEditing(true)
        
        let data = self.data.text.replacingOccurrences(of: "|", with: "/")
        
        if data.isEmpty {
            uploadDone()
            return showError(controller: self, description: "Tes données sont invalides")
        }
        
        guard let passwd = self.passwd.text else {
            uploadDone()
            return showError(controller: self, description: "Mot de passe invalide")
        }
        
        uploadData(controller: self, data: data, passwd: passwd, done: uploadDone)
    }
}
