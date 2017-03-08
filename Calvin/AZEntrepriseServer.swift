//
//  AZEntrepriseServer.swift
//  Pods
//
//  Created by Arion Zimmermann on 25.02.17.
//
//

import UIKit

func request(withID: String, controller: UIViewController, callback:@escaping ((String)->Void)) {
    
    print("Request " + withID)
    
    let request = URLRequest(url: URL(string: "https://www.azentreprise.org/calvin.php?request=" + withID)!)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            showError(controller: controller, description: (error?.localizedDescription)!)
            return
        }
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            showError(controller: controller, description: "La réponse du serveur n'a pas pu être validée (" + String(httpStatus.statusCode) + ")")
        }
        
        callback(String(data: data, encoding: .utf8)!)
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
