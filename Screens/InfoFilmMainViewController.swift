//
//  InfoFilmMainViewController.swift
//  InfoFilm
//
//  Created by Dima on 05.09.2023.
//

import UIKit

final class InfoFilmMainViewController: UIViewController{
    
    //MARK: Variable & Constants
    
    let contentManager = ContentManager()
    let gengresManager = GenresManager()
    let posterManager = PosterManager()
    let videoManager = VideoManager()
    var content: [Result] = []
    var genresDict : [Genre] = []
    var segmentedControl = UISegmentedControl()
    
    
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addBarItem()
        createSegmentedControl()
        setupTV()
    }
    
    //MARK: UISegmentControl
    
    
    func createSegmentedControl(){
        let mediaType = ["Movie", "TV Shows"]
        segmentedControl = UISegmentedControl(items: mediaType)
        segmentedControl.addTarget(self, action: #selector(typeDidChage(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        typeDidChage(segmentedControl)
    }
    
    @objc func typeDidChage(_ segmentedControl: UISegmentedControl){
        if segmentedControl.selectedSegmentIndex == 0 {
            title = "Movies"
            contentManager.fetchData{ content in
                var movies = [Result]()
                for elemn in content{
                    if elemn.mediaType.rawValue == "movie"{
                        movies.append(elemn)
                    }
                }
                self.content = movies
                self.tableView.reloadData()
            }
            gengresManager.loadingGenresData(mediaType: "movie") { genres in
                self.genresDict = genres
                self.tableView.reloadData()
            }
        } else {
            title = "TV Shows"
            contentManager.fetchData{ content in
                var tvShows = [Result]()
                for elemn in content{
                    if elemn.mediaType.rawValue == "tv"{
                        tvShows.append(elemn)
                    }
                }
                self.content = tvShows
                self.tableView.reloadData()
            }
            gengresManager.loadingGenresData(mediaType: "tv") { genres in
                self.genresDict = genres
                self.tableView.reloadData()
            }
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
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Add Button in Navigation Bar
    
    func addBarItem(){
        let addButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    @objc func addButtonTapped() {
        print("Кнопка в navigationbar нажата")
        navigationController?.pushViewController(FavoriteFilmViewController(), animated: true)
    }
    
    
}

//MARK: Extention DataSource

extension InfoFilmMainViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoFilmTableViewCell", for: indexPath) as! InfoFilmTableViewCell
        let currentContent = content[indexPath.row]
        var currentGenreName = [String]()
        for id in currentContent.genreIDS{
            for genre in self.genresDict{
                if id  == genre.id{
                    currentGenreName.append(genre.name)
                }
            }
        }
        let currentGenreNameString = currentGenreName.joined(separator: ", ")
        cell.originalTitleLabel.text = currentContent.originalTitle ?? currentContent.originalName
        cell.genreLabel.text =  "\(currentGenreNameString)"
        posterManager.loadPoster(for: cell.posterImage, with: currentContent.posterPath)
        
        return cell
    }
    
}

//MARK: Extencion Delegate

extension InfoFilmMainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentContent = content[indexPath.row]
        let detailVC = InfoFilmDetailViewController()
        
        detailVC.title = "Detail"
        detailVC.posterPath = currentContent.posterPath
        detailVC.filmId = currentContent.id
        detailVC.currentContent = currentContent
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
}















//            contentManager.loadingData(type: "movie") { content in
//                self.content = content
//                self.tableView.reloadData()
//            }








//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoFilmTableViewCell", for: indexPath) as! InfoFilmTableViewCell
//        let currentMovie = movies[indexPath.row]
//        var currentGenreName = [String]()
//        for id in currentMovie.genreIDS{
//            for genre in self.genresDict{
//                if id  == genre.id{
//                    currentGenreName.append(genre.name)
//                }
//            }
//        }
//        let currentGenreNameString = currentGenreName.joined(separator: ", ")
//        cell.originalTitleLabel.text = currentMovie.originalTitle
//        cell.genreLabel.text =  "\(currentGenreNameString)"
//        posterManager.loadPoster(for: cell.posterImage, with: currentMovie.posterPath)
//
//        return cell
//    }
