//
//  Track.swift
//  CourseWorkFront
//
//  Created by Dariia Hrymalska on 22.05.2021.
//

import Foundation

struct Track: Codable {
    let id: Int
    let name: String
    let popularity: Int
    let artistId: Int
    let releaseDate: String
    let danceability: Double
    let energy: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case popularity
        case artistId = "artist_id"
        case releaseDate = "release_date"
        case danceability
        case energy
    }
}
