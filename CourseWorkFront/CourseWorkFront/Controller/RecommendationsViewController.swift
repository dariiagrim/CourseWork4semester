//
//  RecommendationsViewController.swift
//  CourseWorkFront
//
//  Created by Dariia Hrymalska on 23.05.2021.
//

import UIKit

class RecommendationsViewController: ViewController {
    
    var recommendations: [Recommendation] = [
        Recommendation(trackName: "7 rings.,bvgjhckjp,;oluiyftbnm,'m;lbcpiouyt", artistName: "Ariana Grandeugytfkul;j"),
        Recommendation(trackName: "Titaniumkjhgfdghkjl;", artistName: "Siaihuygtftguyhijop"),
        Recommendation(trackName: "7 rings.,bvgjhckjp,;oluiyftbnm,'m;lbcpiouyt", artistName: "Ariana Grandeugytfkul;j"),
        Recommendation(trackName: "Titaniumkjhgfdghkjl;", artistName: "Siaihuygtftguyhijop"),
        Recommendation(trackName: "7 rings.,bvgjhckjp,;oluiyftbnm,'m;lbcpiouyt", artistName: "Ariana Grandeugytfkul;j"),
        Recommendation(trackName: "Titaniumkjhgfdghkjl;", artistName: "Siaihuygtftguyhijop")
    ]
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var recommendationsTableView: UITableView!
    @IBOutlet weak var getRecommendationsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendationsTableView.dataSource = self
        recommendationsTableView.register(UINib(nibName: "RecommendationCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
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
