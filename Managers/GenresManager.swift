//
//  GenresManager.swift
//  InfoFilm
//
//  Created by Dima on 05.09.2023.
//

import Foundation
import Alamofire
class GenresManager{
    
    func loadingGenresData(completion: @escaping ([Genre]) -> Void) {
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkN2YwNzQzNmI1ZGFiMmMwNzg3YzE1MWIwOGIwNjJiNiIsInN1YiI6IjY0ZGU5MTExNWFiODFhMDBjNWI2NmQ4NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.RUiljWOjqnQlPVsY7XlcbOzeBguVccgd8WXgykyBXo8"
        ]
        AF.request("https://api.themoviedb.org/3/genre/movie/list?language=en", headers: headers)
            .responseDecodable(of: GenresInformation.self) { response in
                switch response.result {
                case .success(let genres):
                    completion(genres.genres)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
