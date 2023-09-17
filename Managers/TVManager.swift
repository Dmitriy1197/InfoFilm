////
////  TVManager.swift
////  InfoFilm
////
////  Created by Dima on 15.09.2023.
////
//
//import Foundation
//import Alamofire
//class TVManager{
//    
//    
//    func loadingData(completion: @escaping ([Result]) -> Void) {
//        
//        let headers: HTTPHeaders = [
//            "accept": "application/json",
//            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkN2YwNzQzNmI1ZGFiMmMwNzg3YzE1MWIwOGIwNjJiNiIsInN1YiI6IjY0ZGU5MTExNWFiODFhMDBjNWI2NmQ4NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.RUiljWOjqnQlPVsY7XlcbOzeBguVccgd8WXgykyBXo8"
//        ]
//        AF.request("https://api.themoviedb.org/3/trending/tv/week?language=en-US", headers: headers)
//            .responseDecodable(of: MoviesInformation.self) { response in
//                switch response.result {
//                case .success(let movies):
//                    completion(movies.results)
//                   
//                case .failure(let error):
//                    
//                    print(error)
//                }
//            }
//    }
//}
