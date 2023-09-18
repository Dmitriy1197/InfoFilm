//
//  DataManager.swift
//  InfoFilm
//
//  Created by Dima on 14.09.2023.
//

import Foundation
import RealmSwift

class DataManager{
    
    static let shared = DataManager()
    private let realm = try? Realm()
    var contentList = [RealmResult]()
    var contentFromRealmList = [Result]()
    func contentExists(withID id: Int) -> Bool {
        let exist = (realm?.objects(RealmResult.self).filter("id == \(id)").count)! > 0
        return exist
    }
    // MARK: - Realm action
   
    func saveToRealm(_ data: Result) {
        let realmItem = RealmResult()
        realmItem.id = data.id
        realmItem.adult = data.adult
        realmItem.backdropPath = data.backdropPath
        realmItem.title = data.title ?? data.name!
        realmItem.originalLanguage = data.originalLanguage.rawValue
        realmItem.originalTitle = data.originalTitle ?? data.originalName!
        realmItem.overview = data.overview
        realmItem.posterPath = data.posterPath
        realmItem.mediaType = data.mediaType.rawValue
        realmItem.genreIDS = data.genreIDS
        realmItem.popularity = data.popularity
        realmItem.releaseDate = data.releaseDate ?? data.firstAirDate!
        realmItem.video = data.video ?? false
        realmItem.voteAverage = data.voteAverage
        realmItem.voteCount = data.voteCount
        realmItem.name = data.name ?? ""
        realmItem.originalName = data.originalName ?? ""
        realmItem.firstAirDate = data.firstAirDate ?? ""
        realmItem.originCountry = data.originCountry ?? []
        print( realmItem.id, realmItem.title)
        if !contentExists(withID: realmItem.id) {
            try? realm?.write {
                realm?.add(realmItem)
            }
        }
    }
    
//    func getFromRealm() -> [RealmResult] {
//        var filmList = [RealmResult]()
//        guard let gettingResults = realm?.objects(RealmResult.self) else { return [] }
//
//        for realmResult in gettingResults {
////             Создаем экземпляр структуры Result на основе данных RealmResult
////            let result = Result(
////                id: realmResult.id,
////                title: realmResult.title,
////                originalTitle: realmResult.originalTitle,
////                overview: realmResult.overview,
////                posterPath: realmResult.posterPath,
////                genreIDS: Array(realmResult.genreIDS),
////                popularity: realmResult.popularity,
////                releaseDate: realmResult.releaseDate,
////                voteAverage: realmResult.voteAverage,
////                voteCount: realmResult.voteCount
////            )
//            filmList.append(realmResult)
//        }
//
//        return filmList
//    }
//    func getFromRealm() -> [RealmResult] {
//        guard let realm = realm else {
//            return []
//        }
//        return Array(realm.objects(RealmResult.self))
//    }
    func getFromRealm() -> [Result] {
        var contentFromRealm = [Result]()

        guard let gettingResults = realm?.objects(RealmResult.self) else { return [] }

        for realmResult in gettingResults {
            let result = Result(
                id: realmResult.id, adult: realmResult.adult,
                backdropPath: realmResult.backdropPath,
                title: realmResult.title,
                originalLanguage: OriginalLanguage(rawValue: realmResult.originalLanguage) ?? .en,
                originalTitle: realmResult.originalTitle,
                overview: realmResult.overview,
                posterPath: realmResult.posterPath,
                mediaType: MediaType(rawValue: realmResult.mediaType) ?? .movie,
                genreIDS: realmResult.genreIDS,
                popularity: realmResult.popularity,
                releaseDate: realmResult.releaseDate,
                video: realmResult.video,
                voteAverage: realmResult.voteAverage,
                voteCount: realmResult.voteCount,
                name: realmResult.name,
                originalName: realmResult.originalName,
                firstAirDate: realmResult.firstAirDate,
                originCountry: realmResult.originCountry
            )
            print(result)
            contentFromRealm.append(result)
        }

        contentFromRealmList = contentFromRealm // Сохраняем результат в свойство contentFromRealmList

        return contentFromRealm
    }


//    func deleteFromRealm(_ film: RealmResult){
//
//        try? realm?.write({
//            realm?.delete(film)
//        })
//    }
    func deleteFromRealm(_ film: Result) {
        // Преобразование объекта Result в RealmResult
        if let realmResultToDelete = realm?.objects(RealmResult.self).filter("id == \(film.id)").first {
            try? realm?.write {
                realm?.delete(realmResultToDelete)
            }
        }
    }

    
}
