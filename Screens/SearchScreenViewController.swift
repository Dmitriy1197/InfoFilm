//
//  SearchScreenViewController.swift
//  InfoFilm
//
//  Created by Dima on 08.09.2023.
//

import UIKit
import WebKit
class SearchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
configureSearchScreen()
        loadSearchScreen()
    }
    func loadSearchScreen(){
        let webString = "https://google.com"
        guard let url = URL(string: webString) else {return}
        let request = URLRequest(url: url)
        searchScreen.load(request)
    }
let searchScreen = WKWebView()
    func configureSearchScreen(){
        view.addSubview(searchScreen)
        searchScreen.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchScreen.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            searchScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
