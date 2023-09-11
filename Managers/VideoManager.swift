//
//  VideoManager.swift
//  InfoFilm
//
//  Created by Dima on 09.09.2023.
//

import Foundation
import Alamofire
import YouTubeiOSPlayerHelper

class VideoManager{
    func loadTrailerKey(id: Int, completion: @escaping ([Results]) -> Void) {
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkN2YwNzQzNmI1ZGFiMmMwNzg3YzE1MWIwOGIwNjJiNiIsInN1YiI6IjY0ZGU5MTExNWFiODFhMDBjNWI2NmQ4NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.RUiljWOjqnQlPVsY7XlcbOzeBguVccgd8WXgykyBXo8"
          ]
        AF.request("https://api.themoviedb.org/3/movie/\(String(id))/videos?language=en-US", headers: headers)
            .responseDecodable(of: VideoInformation.self) { response in
                switch response.result {
                case .success(let video):
                    completion(video.results)
                
                case .failure(let error):
                    
                    print(error)
                }
            }
    }
}
