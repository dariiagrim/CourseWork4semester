//
//  RateTracksViewController.swift
//  CourseWorkFront
//
//  Created by Dariia Hrymalska on 22.05.2021.
//

import Foundation
import UIKit
import Alamofire

class RateTracksViewController: UIViewController {
    
    var rateButtons: [UIButton]!
    var userId: Int?
    var trackId: Int?
    var rate = 1
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var rateOneButton: UIButton!
    @IBOutlet weak var rateTwoButton: UIButton!
    @IBOutlet weak var rateThreeButton: UIButton!
    @IBOutlet weak var rateFourButton: UIButton!
    @IBOutlet weak var rateFiveButton: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rateButtons = [rateOneButton, rateTwoButton, rateThreeButton, rateFourButton, rateFiveButton]
        disableButtons()
        idTextField.delegate = self
        requestTrack()
    }
    
    func enableButtons() {
        for button in rateButtons {
            button.isEnabled = true
        }
        skipButton.isEnabled = true
    }
    
    func disableButtons() {
        for button in rateButtons {
            button.isEnabled = false
        }
        skipButton.isEnabled = false
    }
    
    @IBAction func rateButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            rate = 1
        case 2:
            rate = 2
        case 3:
            rate = 3
        case 4:
            rate = 4
        case 5:
            rate = 5
        default:
            rate = 1
        }
        rateTrackRequest()
        
        
    }
    @IBAction func skipTrackPressed(_ sender: UIButton) {
        requestTrack()
    }
    
    func rateTrackRequest() {
        let parameters: [String: Any] = [
            "user_id": userId ?? 0,
            "track_id": trackId ?? 0,
            "rating": rate
        ]
        AF.request("http://localhost:8080/rate", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) in
                self.requestTrack()
            }
    }
    
    func requestTrack() {
        let randomId = Int.random(in: 1...69000)
        AF.request("http://localhost:8080/id?id=\(randomId)")
            .validate()
            .responseDecodable(of: ArtistAndTrack.self) { (response) in
                guard let value = response.value else { return }
                self.trackId = value.track.id
                DispatchQueue.main.async {
                    self.trackName.text = value.track.name
                    self.artistName.text = value.artist.name
                }
            }
    }
    
}



extension RateTracksViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        idTextField.resignFirstResponder()
        userId = nil
        disableButtons()
        if let id = idTextField.text {
            if let intId = Int(id) {
                userId = intId
            }
        }
        guard let _ = userId else { return true }
        enableButtons()
        return true
    }
}
