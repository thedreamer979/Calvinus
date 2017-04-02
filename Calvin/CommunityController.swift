//
//  CommunityController.swift
//  Calvin
//
//  Created by Arion Zimmermann on 23.03.17.
//  Copyright © 2017 AZEntreprise. All rights reserved.
//

import UIKit

class CommunityController : BasicController, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var passwd: UITextField!
    @IBOutlet weak var price: UISegmentedControl!
    @IBOutlet weak var offerOrRequest: UISegmentedControl!
    @IBOutlet weak var validate: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func uploadDone() {
        DispatchQueue.main.async {
            self.validate.isEnabled = true
            self.loading.stopAnimating()
        }
    }
    
    func textFieldShouldReturn(_ field: UITextField) -> Bool {
        switch(field) {
            case self.name:
                self.desc.becomeFirstResponder()
            case self.desc:
                self.phone.becomeFirstResponder()
            case self.phone:
                self.passwd.becomeFirstResponder()
            default:
                self.view.endEditing(true)
        }
        
        return true
    }
    
    @IBAction func validate(_ sender: UIButton) {
        self.validate.isEnabled = false
        self.loading.startAnimating()
        self.view.endEditing(true)
        
        guard let name = self.name.text?.replacingOccurrences(of: "|", with: "/") else {
            uploadDone()
            return showError(controller: self, description: "Ton nom / pseudo est invalide")
        }
        
        guard let desc = self.desc.text?.replacingOccurrences(of: "|", with: "/") else {
            uploadDone()
            return showError(controller: self, description: "Ta description est invalide")
        }
        
        guard let phone = self.phone.text?.replacingOccurrences(of: "|", with: "/") else {
            uploadDone()
            return showError(controller: self, description: "Ton numéro de téléphone est invalide")
        }
        
        guard let passwd = self.passwd.text else {
            uploadDone()
            return showError(controller: self, description: "Ton mot de passe est invalide")
        }
        
        let price = self.price.titleForSegment(at: self.price.selectedSegmentIndex)
        let oor = self.offerOrRequest.titleForSegment(at: self.offerOrRequest.selectedSegmentIndex)
        
        let data = "repet|\(name)|\(desc)|\(phone)|\(price!)|\(oor!)|\(sha256(forInput: passwd))"
        
        uploadData(controller: self, data: data, passwd: "repetitoires", done: uploadDone)
    }
}
