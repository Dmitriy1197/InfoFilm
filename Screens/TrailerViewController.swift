//
//  TrailerViewController.swift
//  InfoFilm
//
//  Created by Dima on 10.09.2023.
//

import UIKit
import Alamofire

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
//        configurePlayTrailerButtonPressed1()
    }
    
//    private var playTrailerButtonPressed = UIButton()
//        func configurePlayTrailerButtonPressed1(){
//            view.addSubview(playTrailerButtonPressed)
//            playTrailerButtonPressed.translatesAutoresizingMaskIntoConstraints = false
//            playTrailerButtonPressed.setTitle("Show trailer", for: .normal)
//            playTrailerButtonPressed.setTitleColor(.blue, for: .normal)
//            playTrailerButtonPressed.addTarget(self, action: #selector(configureTrailerView), for: .touchUpInside)
//            NSLayoutConstraint.activate([
//                playTrailerButtonPressed.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
//                playTrailerButtonPressed.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
//                playTrailerButtonPressed.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
//                playTrailerButtonPressed.heightAnchor.constraint(equalToConstant: 50)
//
//            ])
//        }
    
    // MARK: Создание view и загрузка видео из ютуба
    
   @objc func configureTrailerView(){
        view.addSubview(trailerView)
        trailerView.backgroundColor = .yellow
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

