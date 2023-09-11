//
//  TrailerViewController.swift
//  InfoFilm
//
//  Created by Dima on 10.09.2023.
//

import UIKit
import Alamofire

import YouTubeiOSPlayerHelper

class TrailerViewController: UIViewController {
    
    // MARK: Variables & Constants
    var trailerView  = YTPlayerView()
    var filmId = Int()
    let videoManager = VideoManager()
    var trailerKey = String()

    // MARK: ViewDidLoad
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.alpha = 0.95
        configureTrailerView()
//        configurePlayTrailerButtonPressed1()
    }
    
    private var playTrailerButtonPressed = UIButton()
        func configurePlayTrailerButtonPressed1(){
            view.addSubview(playTrailerButtonPressed)
            playTrailerButtonPressed.translatesAutoresizingMaskIntoConstraints = false
            playTrailerButtonPressed.setTitle("Show trailer", for: .normal)
            playTrailerButtonPressed.setTitleColor(.blue, for: .normal)
            playTrailerButtonPressed.addTarget(self, action: #selector(configureTrailerView), for: .touchUpInside)
            NSLayoutConstraint.activate([
                playTrailerButtonPressed.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
                playTrailerButtonPressed.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
                playTrailerButtonPressed.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
                playTrailerButtonPressed.heightAnchor.constraint(equalToConstant: 50)
    
            ])
        }
    // MARK: Загрузка ключа для ссылки
    
    func loadKey(complition: @escaping (String) -> Void){
        videoManager.loadTrailerKey(id: filmId) { trailers in
            for result in trailers {
                if result.type.rawValue == "Trailer" {
                        complition(result.key)
                        return
                }
            }
        }
    }
    
    // MARK: Создание view и загрузка видео из ютуба
    
   @objc func configureTrailerView(){
        view.addSubview(trailerView)
        trailerView.backgroundColor = .yellow
        trailerView.translatesAutoresizingMaskIntoConstraints = false
      
//        Загрузка ключа
       DispatchQueue.main.async {
               self.loadKey { key in
                   self.trailerKey = key

               }

           }
        trailerView.load(withVideoId: trailerKey)
        NSLayoutConstraint.activate([
            trailerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            trailerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            trailerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            trailerView.heightAnchor.constraint(equalToConstant: 230)
            
        ])
    }
}


/*
 
 //private var playTrailerButtonPressed = UIButton()
 //    func configurePlayTrailerButtonPressed1(){
 //        view.addSubview(playTrailerButtonPressed)
 //        playTrailerButtonPressed.translatesAutoresizingMaskIntoConstraints = false
 //        playTrailerButtonPressed.setTitle("Show trailer", for: .normal)
 //        playTrailerButtonPressed.setTitleColor(.blue, for: .normal)
 //        playTrailerButtonPressed.addTarget(self, action: #selector(configureTrailerView), for: .touchUpInside)
 //        NSLayoutConstraint.activate([
 //            playTrailerButtonPressed.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
 //            playTrailerButtonPressed.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
 //            playTrailerButtonPressed.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
 //            playTrailerButtonPressed.heightAnchor.constraint(equalToConstant: 50)
 //
 //        ])
 //    }
 //    @objc func playTrailerVideo(){
 //
 //        let videoURLString = "https://www.youtube.com/watch?v=eQfMbSe7F2g" //+ keyTrailer
 //
 //        guard let videoURL = URL(string: videoURLString) else { return }
 //        let player = AVPlayer(url: videoURL)
 //        let playerVC = AVPlayerViewController()
 //        playerVC.player = player
 //        present(playerVC, animated: true) {
 //            player.play()
 //        }
 //    }
 */
