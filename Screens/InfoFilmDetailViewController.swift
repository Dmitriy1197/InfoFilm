//
//  InfoFilmDetailViewController.swift
//  InfoFilm
//
//  Created by Dima on 05.09.2023.
//

import UIKit
//import SDWebImage
//import YouTubeiOSPlayerHelper

 struct Distance{
    let extern : CGFloat = 16
    let intern : CGFloat = 8
}

final class InfoFilmDetailViewController: UIViewController {
    
    
    
    // MARK: Variables & Constants
    private let distance : CGFloat = 16
    
    let alert = AlertManager()
    let posterManager = PosterManager()
    let videoManager = VideoManager()
    
    var posterImage = UIImageView()
    var nameLabel = UILabel()
    var pubDateLabel = UILabel()
    var rate = UILabel()
    var descript = UILabel()
    
    let playTrailerButtonPressed = UIButton()
    var posterPath = String()
    
    var filmId = Int()
    var trailerKey = String()
    var trailerVC = TrailerViewController()
    var currentContent : Result? = nil
    var realmContent : RealmResult? = nil
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUISetup()
    }
    
    func configureUISetup(){
        addBarItem()
        configurePosterImage()
        configurePlayTrailerButtonPressed()
        configureNameLabel()
        configurePubDateLabel()
        configureDescriptionLabel()
    }
    
    // MARK: Создание постера
  
    func configurePosterImage(){
        guard let currentContent = currentContent else { return }
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.layer.cornerRadius = 8
        posterImage.layer.masksToBounds = true
        posterManager.loadPoster(for: posterImage, with: currentContent.posterPath)
        view.addSubview(posterImage)
        let aspectRatioConstraint = NSLayoutConstraint(item: posterImage, attribute: .width, relatedBy: .equal, toItem: posterImage, attribute: .height, multiplier: 3.0 / 4.0, constant: 0.0)
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Distance().intern),
            posterImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Distance().extern),
            posterImage.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.5), // Ширина не более половины экрана
            aspectRatioConstraint
        ])
    }
    
    //MARK: Создание названия
    func configureNameLabel(){
        nameLabel.text =
        (currentContent?.originalTitle ?? currentContent?.originalName) ??
        (realmContent?.originalTitle ?? realmContent?.originalName)
        nameLabel.numberOfLines = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Distance().intern),
            nameLabel.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: Distance().extern),
            nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Distance().extern),
        ])
    }
    //MARK: Создание даты публикации
    func configurePubDateLabel(){
        pubDateLabel.text =
        (currentContent?.releaseDate ?? currentContent?.firstAirDate) ??
        (realmContent?.releaseDate ?? realmContent?.firstAirDate)
        pubDateLabel.font = UIFont.systemFont(ofSize: 10)
        pubDateLabel.translatesAutoresizingMaskIntoConstraints = false
        pubDateLabel.textColor = .systemGray
        view.addSubview(pubDateLabel)
        
        NSLayoutConstraint.activate([
            pubDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Distance().intern),
            pubDateLabel.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: Distance().extern),
            pubDateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Distance().extern),
        ])
    }
    
    // MARK: Создание кнопки
    func configurePlayTrailerButtonPressed(){
        view.addSubview(playTrailerButtonPressed)
        playTrailerButtonPressed.translatesAutoresizingMaskIntoConstraints = false
        playTrailerButtonPressed.setTitle("Show trailer", for: .normal)
//        playTrailerButtonPressed.setTitleColor(.blue, for: .normal)
        playTrailerButtonPressed.layer.borderColor = UIColor.white.cgColor
        playTrailerButtonPressed.layer.borderWidth = 1
        playTrailerButtonPressed.layer.cornerRadius = 8
        playTrailerButtonPressed.addTarget(self, action: #selector(showTrailerVC), for: .touchUpInside)
        DispatchQueue.main.async {
            self.loadKey { key in
                self.trailerVC.trailerKey = key
            }
        }
        NSLayoutConstraint.activate([
            playTrailerButtonPressed.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: Distance().intern),
            playTrailerButtonPressed.leftAnchor.constraint(equalTo: posterImage.leftAnchor),
            playTrailerButtonPressed.rightAnchor.constraint(equalTo: posterImage.rightAnchor),
            playTrailerButtonPressed.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    @objc func showTrailerVC(){
        present(trailerVC, animated: true)
    }
    
    
    //MARK: Создание описания
    func configureDescriptionLabel(){
        descript.text = currentContent?.overview ?? realmContent?.overview
        descript.numberOfLines = 0
        descript.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descript)
        
        NSLayoutConstraint.activate([
            descript.topAnchor.constraint(equalTo: playTrailerButtonPressed.bottomAnchor, constant: Distance().intern),
            descript.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Distance().extern),
            descript.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Distance().extern),
//            descript.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
        ])
    }
    

    
    // MARK: Загрузка ключа для ссылки на трейлер
    
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
   
    // MARK: - Create Add Button in Navigation Bar
    
    func addBarItem(){
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    @objc func addButtonTapped() {
        print("Кнопка в navigationbar нажата")
        alert.showAddingAlert(self, content: currentContent)
    }
    
}





















/*
 //MARK: Загрузка плеера
 
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

/*
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
 */
/*
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
 */
 /*
  //MARK: Cоздание постера
    func configurePosterImage(){
        view.addSubview(posterImage)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.layer.cornerRadius = 20 // Устанавливает радиус закругления углов
        posterImage.layer.masksToBounds = true
        posterManager.loadPoster(for: posterImage, with: posterPath)
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            posterImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            posterImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            posterImage.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
*/
