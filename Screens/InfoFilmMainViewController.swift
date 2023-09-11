//
//  InfoFilmMainViewController.swift
//  InfoFilm
//
//  Created by Dima on 05.09.2023.
//

import UIKit

class InfoFilmMainViewController: UIViewController{
    
    //MARK: Variable & Constants
    
    let filmManager = FilmManager()
    let gengresManager = GenresManager()
    let posterManager = PosterManager()
    let videoManager = VideoManager()
    var movies: [Result] = [] // Массив для хранения данных
    var genresDict : [Genre] = []
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        filmManager.loadingData { moviesData in
            self.movies = moviesData // Обновление массива данными
            self.tableView.reloadData()
        }
        gengresManager.loadingGenresData { genres in
            self.genresDict = genres
            self.tableView.reloadData()
        }
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

extension InfoFilmMainViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoFilmTableViewCell", for: indexPath) as! InfoFilmTableViewCell
        let currentMovie = movies[indexPath.row]
        var currentGenreName = [String]()
        for id in currentMovie.genreIDS{
            for genre in self.genresDict{
                if id  == genre.id{
                    currentGenreName.append(genre.name)
                }
            }
        }
        let currentGenreNameString = currentGenreName.joined(separator: ", ")
        cell.originalTitleLabel.text = currentMovie.originalTitle
        cell.genreLabel.text =  "\(currentGenreNameString)"
        posterManager.loadPoster(for: cell.posterImage, with: currentMovie.posterPath)
        
        return cell
    }
}

//MARK: Extencion Delegate

extension InfoFilmMainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentMovie = movies[indexPath.row]
        let detailVC = InfoFilmDetailViewController()
     
        detailVC.title = currentMovie.originalTitle
        detailVC.posterPath = currentMovie.posterPath
        detailVC.filmId = currentMovie.id
        navigationController?.pushViewController(detailVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
}

