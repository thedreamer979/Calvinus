//
//  AZEntrepriseServer.swift
//  Calvin
//
//  Created by Arion Zimmermann on 25.02.17.
//
//

import UIKit

func login(controller: UIViewController, userHash: String?, onResponse: @escaping (Bool)->Void) {
    var news = UserDefaults.standard.stringArray(forKey: "offline-user-data")

    if news == nil {
        news = [String]()
    }
    
    if let userHash = userHash {
        var shasum = String()
        
        for entry in news! {
            shasum.append(sha4(forInput: entry))
        }
                
        let request = URLRequest(url: URL(string: "https://www.azentreprise.org/calvin.php?user=\(userHash)&data=\(shasum)")!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                showError(controller: controller, description: (error?.localizedDescription)!)
                onResponse(false)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                showError(controller: controller, description: "La réponse du serveur n'a pas pu être validée (" + String(httpStatus.statusCode) + ")")
                onResponse(false)
            }
            
            let utfData = String(bytes: data, encoding: .utf8)
            let elements = utfData?.components(separatedBy: "\n")
            
            if utfData == "ERR_AUTH_FAILED" {
                onResponse(false)
            } else {
                for element in elements! {
                    if let index = element.characters.index(of: ":") {
                        let id = element[element.startIndex..<index]
                        let realData = element[element.index(after: index)..<element.endIndex]
                        let realId = Int(id)!
                        
                        if realId < news!.count {
                            news![realId] = realData
                        } else {
                            news!.append(realData)
                        }
                        
                        print("New update: \(element)")
                    }
                }
                
                UserDefaults.standard.set(news, forKey: "offline-user-data")
                UserDefaults.standard.set(userHash, forKey: "user-hash")
                
                onResponse(true)
            }
        }
        
        task.resume()
    } else {
        onResponse(false)
    }
}

func uploadData(controller: UIViewController, data: String, passwd: String, done: @escaping (Void)->Void) {
    let utf8data = data.data(using: String.Encoding.utf8)
    
    if let base64 = utf8data?.base64EncodedString() {
        let request = URLRequest(url: URL(string: "https://www.azentreprise.org/calvin.php?passwd=\(sha256(forInput: passwd))&data=\(base64)")!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                done()
                return showError(controller: controller, description: (error?.localizedDescription)!)
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                done()
                return showError(controller: controller, description: "La réponse du serveur n'a pas pu être validée (" + String(httpStatus.statusCode) + ")")
            }
            
            let response = String(bytes: data, encoding: .utf8)
            
            print(response ?? String())
            
            done()
            
            if response == "ERR_UPLOAD_FAILED" {
                showError(controller: controller, description: "L'envoi des données a échoué")
            } else {
                login(controller: controller, userHash: UserDefaults.standard.string(forKey: "user-hash"), onResponse: dummyOnResponse)
                showError(controller: controller, description: "L'envoi des données a réussi", notAnError: "Victoire")
            }
        }
        
        task.resume()
    } else {
        done()
        showError(controller: controller, description: "L'envoi des données a échoué")
    }
}

func requestDeletion(controller: UIViewController, data: String) {
    DispatchQueue.main.async {
        let alert = UIAlertController(title: "Entre le mot de passe", message: "", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { (field) in
            field.placeholder = "Mot de passe"
            field.isSecureTextEntry = true
        })
        
        let del = UIAlertAction(title: "Supprimer", style: .destructive, handler: { (action) in
            deleteData(controller: controller, data: data, passwd: alert.textFields![0].text!)
        })
        
        let cancel = UIAlertAction(title: "Annuler", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(del)
        alert.addAction(cancel)
        
        controller.present(alert, animated: true, completion: nil)
    }
}

func deleteData(controller: UIViewController, data: String, passwd: String) {
    let utf8data = data.data(using: String.Encoding.utf8)
    
    if let base64 = utf8data?.base64EncodedString() {
        let request = URLRequest(url: URL(string: "https://www.azentreprise.org/calvin.php?delete=true&passwd=\(passwd)&data=\(base64)")!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return showError(controller: controller, description: (error?.localizedDescription)!)
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                return showError(controller: controller, description: "La réponse du serveur n'a pas pu être validée (" + String(httpStatus.statusCode) + ")")
            }
            
            let response = String(bytes: data, encoding: .utf8)
            
            print(response ?? String())
            
            if response == "ERR_AUTH_FAILED" {
                showError(controller: controller, description: "Authentification échouée")
            } else {
                login(controller: controller, userHash: UserDefaults.standard.string(forKey: "user-hash"), onResponse: dummyOnResponse)
                showError(controller: controller, description: "La suppression a réussi", notAnError: "Victoire")
            }
        }
        
        task.resume()
    } else {
        showError(controller: controller, description: "La suppression a échoué")
    }
}

func showError(controller: UIViewController, description: String, notAnError: String = "Erreur") {
    DispatchQueue.main.async {
        let alert = UIAlertController(title: notAnError, message: description, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        
        controller.present(alert, animated: true, completion: nil)
    }
}

func dummyOnResponse(dummy : Bool) {
    UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Dashboard")
}

func sha4(forInput: String) -> String {
    let sha = sha256(forInput: forInput)
    return sha[sha.startIndex..<sha.index(sha.startIndex, offsetBy: 4)]
}

func sha256(forInput: String) -> String {
    let messageData = forInput.data(using: String.Encoding.utf8)
    
    var digestData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
    
    _ = digestData.withUnsafeMutableBytes {digestBytes in
        messageData?.withUnsafeBytes {messageBytes in
            CC_SHA256(messageBytes, CC_LONG((messageData?.count)!), digestBytes)
        }
    }
    
    return digestData.map { String(format: "%02hhx", $0) }.joined()
}
