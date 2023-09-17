//
//  GenreModel.swift
//  InfoFilm
//
//  Created by Dima on 05.09.2023.
//

import Foundation
struct GenresInformation: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
