//
//  LoginViewController.swift
//  Sheasy
//
//  Created by Rashid Gaitov on 24.05.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var loginButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.setTitle("Login", for: .normal)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
