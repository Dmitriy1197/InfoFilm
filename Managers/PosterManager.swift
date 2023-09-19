//
//  PosterManager.swift
//  InfoFilm
//
//  Created by Dima on 05.09.2023.
//

import Foundation
import SDWebImage
class PosterManager{
    
    func loadPoster(for uiImageView: UIImageView, with imagePath: String) {
        
        let imageUrlString: String = "https://www.themoviedb.org/t/p/original/\(imagePath)"
        let imageURL: URL = URL(string: imageUrlString)!
        DispatchQueue.main.async {
            uiImageView.sd_setImage(with: imageURL, completed: nil)
        }
    }
}

