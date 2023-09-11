//
//  InfoFilmDetailViewController.swift
//  InfoFilm
//
//  Created by Dima on 05.09.2023.
//

import UIKit
import SDWebImage
import YouTubeiOSPlayerHelper
import AVKit

class InfoFilmDetailViewController: UIViewController {
    
    // MARK: Variables & Constants
    var posterPath = String()
    var posterImage = UIImageView()
    let posterManager = PosterManager()
    var filmId = Int()
    var trailerKey = String()
    var trailerView  = YTPlayerView()
    let videoManager = VideoManager()
    let playTrailerButtonPressed = UIButton()
    weak var trailerVC = TrailerViewController()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configurePosterImage()
        configurePlayTrailerButtonPressed()
    }
    
    
    // MARK: Создание постера
    func configurePosterImage(){
        view.addSubview(posterImage)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterManager.loadPoster(for: posterImage, with: posterPath)
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            posterImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            posterImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            posterImage.heightAnchor.constraint(equalToConstant: 350)
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
    
    // MARK: Создание кнопки
    func configurePlayTrailerButtonPressed(){
        view.addSubview(playTrailerButtonPressed)
        playTrailerButtonPressed.translatesAutoresizingMaskIntoConstraints = false
        playTrailerButtonPressed.setTitle("Show trailer", for: .normal)
        playTrailerButtonPressed.setTitleColor(.blue, for: .normal)
        playTrailerButtonPressed.addTarget(self, action: #selector(configureTrailerView), for: .touchUpInside)
        DispatchQueue.main.async {
                self.loadKey { key in
                    self.trailerKey = key
                }
                    
            }
        NSLayoutConstraint.activate([
            playTrailerButtonPressed.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 20),
            playTrailerButtonPressed.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            playTrailerButtonPressed.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            playTrailerButtonPressed.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    // MARK: Создание view из ютуба
    @objc func configureTrailerView(){
        view.addSubview(trailerView)
        trailerView.backgroundColor = .yellow
        trailerView.translatesAutoresizingMaskIntoConstraints = false
        trailerView.load(withVideoId: trailerKey)
        NSLayoutConstraint.activate([
            trailerView.topAnchor.constraint(equalTo: playTrailerButtonPressed.bottomAnchor, constant: 10),
            trailerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            trailerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            trailerView.heightAnchor.constraint(equalToConstant: 200)

        ])
    }
    
 
}





















/*
//MARK: Загрузку плеера

@objc func playTrailerVideo(){
    let videoURLString = "https://www.youtube.com/watch?v=eQfMbSe7F2g" //+ keyTrailer
    
    guard let videoURL = URL(string: videoURLString) else { return }
    let player = AVPlayer(url: videoURL)
    let playerVC = AVPlayerViewController()
    playerVC.player = player
    present(playerVC, animated: true) {
        player.play()
    }
}
 */

/*
 //MARK: Удаление плеера с экрана путем нажатия мимо плеера
 let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideView))
         view.addGestureRecognizer(tapGesture)
 
 @objc func handleTapOutsideView(sender: UITapGestureRecognizer) {
         let location = sender.location(in: view)

         // Проверьте, находится ли точка касания вне trailerView
         if !trailerView.frame.contains(location) {
             // Точка касания находится вне trailerView, скройте его
             trailerView.removeFromSuperview()
           
         }
     }
 */
