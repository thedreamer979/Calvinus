//
//  AZEntrepriseServer.swift
//  Calvin
//
//  Created by Arion Zimmermann on 25.02.17.
//
//

import UIKit

func login(controller : UIViewController, userHash : String?, onResponse : @escaping (Bool)->Void) {
    guard var news = UserDefaults.standard.stringArray(forKey: "offline-user-data"), let userHash = userHash else {
        UserDefaults.standard.set([String](), forKey: "offline-user-data")
        UserDefaults.standard.set("", forKey: "user-hash")
        onResponse(false)
        return
    }
    
    var shasum = String()
    
    for entry in news {
        shasum.append(sha4(forInput: entry))
    }
    
    let request = URLRequest(url: URL(string: "https://www.azentreprise.org/calvin.php?user=\(userHash)&data=\(shasum)")!)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            showError(controller: controller, description: (error?.localizedDescription)!)
            return
        }
    
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            showError(controller: controller, description: "La réponse du serveur n'a pas pu être validée (" + String(httpStatus.statusCode) + ")")
        }

        let utfData = String(bytes: data, encoding: .utf8)
        let elements = utfData?.components(separatedBy: "\n")
        
        if (utfData?.isEmpty)! {
            onResponse(false)
        } else {
            for element in elements! {
                let index = element.characters.index(of: ":")
                let id = element[element.startIndex..<index!]
                let realData = element[index!..<element.endIndex]
                let realId = Int(id)!
                
                if realId < news.count {
                    news[realId] = realData
                } else {
                    news.append(realData)
                }
            }
            
            UserDefaults.standard.set(news, forKey: "offline-user-data")
            
            onResponse(true)
        }
    }
    
    task.resume()
}


func showError(controller: UIViewController, description: String) {
    DispatchQueue.main.async {
        let alert = UIAlertController(title: "Erreur", message: description, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        
        controller.present(alert, animated: true, completion: nil)
    }
}

func sha4(forInput: String) -> String {
    let sha = sha256(forInput: forInput)
    return sha[sha.startIndex...sha.index(sha.startIndex, offsetBy: 4)]
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
