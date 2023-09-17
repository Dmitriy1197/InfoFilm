//
//  ModelForRealm.swift
//  InfoFilm
//
//  Created by Dima on 12.09.2023.
//

import Foundation
import RealmSwift

class RealmResult: Object {
//        @objc dynamic var id: Int = 0
//        @objc dynamic var adult: Bool = false
//        @objc dynamic var backdropPath: String = ""
//        @objc dynamic var title: String = ""
//        @objc dynamic var originalLanguage: String = ""
//        @objc dynamic var originalTitle: String = ""
//        @objc dynamic var overview: String = ""
//        @objc dynamic var posterPath: String = ""
//        @objc dynamic var mediaType: String = ""
//        var genreIDS = [Int]()
//        @objc dynamic var popularity: Double = 0.0
//        @objc dynamic var releaseDate: String = ""
//        @objc dynamic var video: Bool = false
//        @objc dynamic var voteAverage: Double = 0.0
//        @objc dynamic var voteCount: Int = 0
    
    @objc dynamic var id: Int = 0
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var mediaType: String = ""
    var genreIDS = [Int]()
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var video: Bool = false
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var originalName: String = ""
    @objc dynamic var firstAirDate: String = ""
    var originCountry = [String]()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
