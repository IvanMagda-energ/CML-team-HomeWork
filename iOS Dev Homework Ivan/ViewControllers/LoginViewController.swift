//
//  LoginViewController.swift
//  iOS Dev Homework Ivan
//
//  Created by Иван Магда on 24.06.2022.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let networkClient = NetworkClient.shared
    
    private func alert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Attention", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func sendRequestButton(_ sender: Any) {
        guard let login = loginTextField?.text, let password = passwordTextField?.text else {
            self.alert(message: "Incorrect login or password")
            return
        }
        networkClient.loginRequest(email: login, password: password) { error in
            if error == nil {
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let navigationController = storyboard.instantiateViewController(withIdentifier: "MemberAreaNavigationController")
                    self.view.window?.rootViewController = navigationController
                }
            } else {
                self.alert(message: "Incorrect login or password")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
