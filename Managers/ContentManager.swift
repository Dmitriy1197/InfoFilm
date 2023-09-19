//
//  ContentManager.swift
//  InfoFilm
//
//  Created by Dima on 15.09.2023.
//

import Foundation
import Alamofire
class ContentManager{
    
    
    func fetchData(completion: @escaping ([Result]) -> Void) {
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkN2YwNzQzNmI1ZGFiMmMwNzg3YzE1MWIwOGIwNjJiNiIsInN1YiI6IjY0ZGU5MTExNWFiODFhMDBjNWI2NmQ4NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.RUiljWOjqnQlPVsY7XlcbOzeBguVccgd8WXgykyBXo8"
        ]
        AF.request("https://api.themoviedb.org/3/trending/all/week?language=en-US", headers: headers)
            .responseDecodable(of: ContentInfo.self) { response in
                switch response.result {
                case .success(let content):
                    completion(content.results)
                case .failure(let error):
                    
                    print(error)
                }
            }
    }
}













//    func loadingData(type: String, completion: @escaping ([Result]) -> Void) {
//
//
//        let headers: HTTPHeaders = [
//            "accept": "application/json",
//            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkN2YwNzQzNmI1ZGFiMmMwNzg3YzE1MWIwOGIwNjJiNiIsInN1YiI6IjY0ZGU5MTExNWFiODFhMDBjNWI2NmQ4NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.RUiljWOjqnQlPVsY7XlcbOzeBguVccgd8WXgykyBXo8"
//        ]
//        AF.request("https://api.themoviedb.org/3/trending/\(type)/week?language=en-US", headers: headers)
//            .responseDecodable(of: ContentInfo.self) { response in
//                switch response.result {
//                case .success(let content):
//                    completion(content.results)
//
//                case .failure(let error):
//
//                    print(error)
//                }
//            }
//    }









//    func fetchData(page: Int, completion: @escaping ([Result]) -> Void) {
//        let apiKey = "YOUR_API_KEY"
//
//        let headers: HTTPHeaders = [
//            "accept": "application/json",
//            "Authorization": "Bearer YOUR_ACCESS_TOKEN"
//        ]
//
//        let urlString = "https://api.themoviedb.org/3/trending/all/week"
//
//        let parameters: Parameters = [
//            "language": "en-US",
//            "page": page, // Указываем номер страницы
//            "api_key": apiKey
//        ]
//
//        AF.request(urlString, parameters: parameters, headers: headers)
//            .responseDecodable(of: ContentInfo.self) { response in
//                switch response.result {
//                case .success(let content):
//                    completion(content.results)
//                case .failure(let error):
//                    print(error)
//                }
//            }
//    }
