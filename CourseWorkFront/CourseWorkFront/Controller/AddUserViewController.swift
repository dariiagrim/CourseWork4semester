//
//  AddUserViewController.swift
//  CourseWorkFront
//
//  Created by Dariia Hrymalska on 22.05.2021.
//

import UIKit
import Alamofire

class AddUserViewController: UIViewController {
    
    var userId: Int?
    var infoLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var addUserButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel = UILabel(frame: CGRect(x: 10, y: 300, width: 300, height: 50))
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [infoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                           infoLabel.topAnchor.constraint(equalTo: addUserButton.bottomAnchor, constant: 40)]
        NSLayoutConstraint.activate(constraints)
        infoLabel.isHidden = true
    }
    
    @IBAction func addUserButtonPressed(_ sender: UIButton) {
        if let username = usernameTextField.text, let age = ageTextField.text {
            if username != "" && age != "" {
                self.createUserRequest(username: username, age: age)
            }
        }
        
        
    }
    
    
    func createUserRequest(username: String, age: String) {
        let parameters: [String: Any] = [
            "username": username,
            "age": Int(age) ?? "undefined"
        ]
        AF.request("http://localhost:8080/create", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) in
                self.userId = nil
                if let dict = response.value as? [String: Any] {
                    if let id = dict["id"] as? NSNumber  {
                        self.userId = id.intValue
                    }
                }
                DispatchQueue.main.async {
                    self.changeInfoLabel()
                }
            }
    }
    
    func changeInfoLabel()  {
        infoLabel.isHidden = false
        if let id = userId {
            infoLabel.text = "Your id is \(id), don't forget it!"
        } else {
            infoLabel.text = "Something went wrong. Try again!"
        }
    }
  
}
