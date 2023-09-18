//
//  FavoriteFilmViewController.swift
//  InfoFilm
//
//  Created by Dima on 14.09.2023.
//

import UIKit

class FavoriteFilmViewController: UIViewController {
    
    //MARK: Variable & Constants
    let gengresManager = GenresManager()
    let posterManager = PosterManager()
    let videoManager = VideoManager()
    //    var content: [Result] = [] // Массив для хранения данных
    var genresDict : [Genre] = []
    let dataManager = DataManager.shared
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        setupTV()
//        dataManager.contentList = dataManager.getFromRealm()
        dataManager.contentFromRealmList = dataManager.getFromRealm()
    }
    
    //MARK: TableView
    
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(InfoFilmTableViewCell.self, forCellReuseIdentifier: InfoFilmTableViewCell.cellID)
        return tableView
    }()
    func setupTV(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    
    
}

//MARK: Extention DataSource

extension FavoriteFilmViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataManager.contentList.count
        return dataManager.contentFromRealmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoFilmTableViewCell", for: indexPath) as! InfoFilmTableViewCell
        let currentContent = dataManager.contentFromRealmList[indexPath.row]
        var currentGenreName = [String]()
        for id in currentContent.genreIDS{
            for genre in self.genresDict{
                if id  == genre.id{
                    currentGenreName.append(genre.name)
                }
            }
        }
        let currentGenreNameString = currentGenreName.joined(separator: ", ")
        cell.originalTitleLabel.text = currentContent.originalTitle
        
        posterManager.loadPoster(for: cell.posterImage, with: currentContent.posterPath)
        
        return cell
    }
}

//MARK: Extencion Delegate

extension FavoriteFilmViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentContent = dataManager.contentFromRealmList[indexPath.row]
//        let currentContent = dataManager.contentList[indexPath.row]

        let detailVC = InfoFilmDetailViewController()
        
        detailVC.title = "Detail"
        detailVC.posterPath = currentContent.posterPath
        detailVC.filmId = currentContent.id
//        detailVC.realmContent = currentContent
        detailVC.currentContent = currentContent
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            dataManager.deleteFromRealm(dataManager.contentFromRealmList[indexPath.row])
//            dataManager.contentList = dataManager.getFromRealm()
            dataManager.contentFromRealmList = dataManager.getFromRealm()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
}
