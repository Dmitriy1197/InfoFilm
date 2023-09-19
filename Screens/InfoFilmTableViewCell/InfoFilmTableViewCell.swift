//
//  InfoFilmTableViewCell.swift
//  InfoFilm
//
//  Created by Dima on 05.09.2023.
//

import UIKit

class InfoFilmTableViewCell: UITableViewCell {
    static let cellID = "InfoFilmTableViewCell"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    var originalTitleLabel: UILabel!
    var genreLabel: UILabel!
    var posterImage: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        originalTitleLabel = UILabel()
        originalTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        originalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(originalTitleLabel)
        
        genreLabel = UILabel()
        genreLabel.font = UIFont.systemFont(ofSize: 10)
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.numberOfLines = 3
        contentView.addSubview(genreLabel)
        
        posterImage = UIImageView()
        posterImage.contentMode = .scaleAspectFit
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(posterImage)
        
        NSLayoutConstraint.activate([
            originalTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            originalTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            originalTitleLabel.trailingAnchor.constraint(equalTo: posterImage.leadingAnchor, constant: -8),
            
            genreLabel.topAnchor.constraint(equalTo: originalTitleLabel.bottomAnchor, constant: 8),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            genreLabel.trailingAnchor.constraint(equalTo: posterImage.leadingAnchor, constant: -8),
            genreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            posterImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            posterImage.widthAnchor.constraint(equalToConstant: 70),
            posterImage.heightAnchor.constraint(equalToConstant: 96)
            
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
