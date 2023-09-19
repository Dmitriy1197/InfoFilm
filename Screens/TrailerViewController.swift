//
//  TrailerViewController.swift
//  InfoFilm
//
//  Created by Dima on 10.09.2023.
//

import UIKit
import YouTubeiOSPlayerHelper

final class TrailerViewController: UIViewController {
    
    // MARK: Variables & Constants
    var trailerView  = YTPlayerView()
    let videoManager = VideoManager()
    var trailerKey = String()

    // MARK: ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.alpha = 0.95
        configureTrailerView()
    }
    

    // MARK: Создание view и загрузка видео из ютуба
    
   @objc func configureTrailerView(){
        view.addSubview(trailerView)
        trailerView.translatesAutoresizingMaskIntoConstraints = false
        trailerView.load(withVideoId: trailerKey)
        NSLayoutConstraint.activate([
            trailerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            trailerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            trailerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            trailerView.heightAnchor.constraint(equalToConstant: 230)
        ])
    }
}
