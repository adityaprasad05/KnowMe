//
//  LogInViewController.swift
//  
//
//  Created by Aditya Prasad on 6/5/20.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!{
       didSet {
        passwordTextField.tintColor = UIColor.white
        passwordTextField.setIcon(UIImage(imageLiteralResourceName: "icon-key"))
       }
    }
    @IBOutlet weak var emailTextField: UITextField!{
       didSet {
          emailTextField.tintColor = UIColor.white
        emailTextField.setIcon(UIImage(imageLiteralResourceName: "icon-email"))
       }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 200/255, alpha: 1)
        setUpElements()
        
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleFilledButton(logInButton)
    }
    
    
        @IBAction func logInButtonTapped(_ sender: UIButton) {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
                if error != nil {
                    self.errorLabel.text = error!.localizedDescription
                    self.errorLabel.alpha = 1
                
                }
                else{
                   let welcomeNavigationController = self.storyboard?.instantiateViewController(identifier: LogInConstants.storyboard.welcomeNavigationController)
                    self.view.window?.rootViewController = welcomeNavigationController
                    self.view.window?.makeKeyAndVisible()
 
                }
            }
            
        }
            
        
}
extension UITextField {
func setIcon(_ image: UIImage) {
   let iconView = UIImageView(frame:
                  CGRect(x: 1, y: 5, width: 20, height: 20))
   iconView.image = image
   let iconContainerView: UIView = UIView(frame:
                  CGRect(x: 20, y: 0, width: 30, height: 30))
   iconContainerView.addSubview(iconView)
   leftView = iconContainerView
   leftViewMode = .always
}
}
