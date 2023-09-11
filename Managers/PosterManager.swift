//
//  PosterManager.swift
//  InfoFilm
//
//  Created by Dima on 05.09.2023.
//

import Foundation
import SDWebImage
class PosterManager{
    
    
    //    func loadPoster(for vc: UIViewController, with imagePath: String) {
    //
    //        let imageUrlString: String = "https://www.themoviedb.org/t/p/original/\(imagePath)"
    //        let imageURL: URL = URL(string: imageUrlString)!
    //        vc.posterImage.sd_setImage(with: imageURL, completed: nil)
    //    }
//    func loadImage(with urlString: String, completion: @escaping (UIImage?) -> Void) {
//        // Используем SDWebImage для загрузки изображения по URL
//        if let url = URL(string: urlString) {
//            SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { (image, _, _, _, _, _) in
//                // Завершаем выполнение замыкания, передавая UIImage (или nil, если изображение не загружено)
//                completion(image)
//            }
//        } else {
//            // URL недействителен, завершаем выполнение замыкания с nil
//            completion(nil)
//        }
//    }
    
    func loadPoster(for uiImageView: UIImageView, with imagePath: String) {
        
        let imageUrlString: String = "https://www.themoviedb.org/t/p/original/\(imagePath)"
        let imageURL: URL = URL(string: imageUrlString)!
        DispatchQueue.main.async {
            uiImageView.sd_setImage(with: imageURL, completed: nil)
        }
    }
}

