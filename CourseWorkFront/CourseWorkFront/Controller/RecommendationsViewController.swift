//
//  RecommendationsViewController.swift
//  CourseWorkFront
//
//  Created by Dariia Hrymalska on 23.05.2021.
//

import UIKit
import Alamofire

class RecommendationsViewController: ViewController {
    
    var recommendations = [Recommendation]()
    var userId: Int {
        Int(idTextField.text!) ?? 0
    }
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var recommendationsTableView: UITableView!
    @IBOutlet weak var getRecommendationsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendationsTableView.dataSource = self
        recommendationsTableView.register(UINib(nibName: "RecommendationCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
    }
    @IBAction func getRecommendationsPressed(_ sender: UIButton) {
        recommendations = []
        self.recommendationsTableView.reloadData()
        if userId == 0 {
            return
        }
        AF.request("http://localhost:5000/user/\(userId)")
            .validate()
            .responseJSON { (response) in
                if let dict = response.value as? [String: Any] {
                    if let recommends = dict["recommendations"] as? [[Any]] {
                        AF.request("http://localhost:8080/rated?user_id=\(self.userId)")
                            .validate()
                            .responseJSON { (response) in
                                if let dict = response.value as? [String: Any] {
                                    if let ratedTracks = dict["tracks"] as? [Int] {
                                        for recommend in recommends {
                                            if !ratedTracks.contains(recommend[0] as! Int) {
                                                AF.request("http://localhost:8080/id?id=\(recommend[0] as! Int)")
                                                    .validate()
                                                    .responseDecodable(of: ArtistAndTrack.self) { (response) in
                                                        guard let value = response.value else { return }
                                                        self.recommendations.append(Recommendation(trackName: value.track.name, artistName: value.artist.name))
                                                        DispatchQueue.main.async {
                                                            self.recommendationsTableView.reloadData()
                                                        }
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                    }
                }
            }
        
    }
}


extension RecommendationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recommendationsTableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! RecommendationCell
        cell.trackName.text = recommendations[indexPath.row].trackName
        cell.artistName.text = recommendations[indexPath.row].artistName
        return cell
    }
    
    
}
