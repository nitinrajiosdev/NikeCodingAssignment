//
//  MediaDetailViewController.swift
//  NikeCodingAssingment
//
//  Created by Nitin Pabba on 9/10/19.
//  Copyright © 2019 Nitin Pabba. All rights reserved.
//

import UIKit

struct Constant {
    static let zero: CGFloat = 0.0
    static let twenty: CGFloat = 20.0
    static let twoHundred: CGFloat = 200.0
}

class MediaDetailViewController: UIViewController {
    var imageView = UIImageView(frame: .zero)
    var artistnameLabel = UILabel(frame: .zero)
    var albumNameLabel = UILabel(frame: .zero)
    var genreLabel = UILabel(frame: .zero)
    var releaseDateLabel = UILabel(frame: .zero)
    var copyrightLabel = UILabel(frame: .zero)
    
    var seeItunesButton = UIButton()
    
    var correspondingMedia: Media?
    var parentViewModel: MediaViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        configureSubviews()
        renderView()
        // Do any additional setup after loading the view.
    }
}

//MARK: Private
extension MediaDetailViewController {
    private func configureSubviews() {
        if let view = view {
            view.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            let horizontalConstraint = NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: Constant.zero)
            let verticalConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: Constant.twenty)
            
            let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: Constant.twoHundred)
            let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: Constant.twoHundred)
            view.addConstraints([horizontalConstraint, verticalConstraint, heightConstraint, widthConstraint])
            
            view.addSubview(artistnameLabel)
            artistnameLabel.translatesAutoresizingMaskIntoConstraints = false
            let artistNameLabelTopConstraint = NSLayoutConstraint(item: artistnameLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: Constant.twenty)
            let artistNameLabelHorizontalConstraint = NSLayoutConstraint(item: artistnameLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: Constant.zero)
            view.addConstraints([artistNameLabelTopConstraint, artistNameLabelHorizontalConstraint])
            
            view.addSubview(albumNameLabel)
            albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
            let albumNameLabelTopConstraint = NSLayoutConstraint(item: albumNameLabel, attribute: .top, relatedBy: .equal, toItem: artistnameLabel, attribute: .bottom, multiplier: 1.0, constant: Constant.twenty)
            let albumNameLabelHorizontalConstraint = NSLayoutConstraint(item: albumNameLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: Constant.zero)
            view.addConstraints([albumNameLabelTopConstraint, albumNameLabelHorizontalConstraint])
            
            view.addSubview(genreLabel)
            genreLabel.translatesAutoresizingMaskIntoConstraints = false
            let genreLabelTopConstraint = NSLayoutConstraint(item: genreLabel, attribute: .top, relatedBy: .equal, toItem: albumNameLabel, attribute: .bottom, multiplier: 1.0, constant: Constant.twenty)
            let genreLabelHorizontalConstraint = NSLayoutConstraint(item: genreLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: Constant.zero)
            view.addConstraints([genreLabelTopConstraint, genreLabelHorizontalConstraint])
            
            view.addSubview(releaseDateLabel)
            releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
            let releaseDateLabelTopConstraint = NSLayoutConstraint(item: releaseDateLabel, attribute: .top, relatedBy: .equal, toItem: genreLabel, attribute: .bottom, multiplier: 1.0, constant: Constant.twenty)
            let releaseDateLabelHorizontalConstraint = NSLayoutConstraint(item: releaseDateLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: Constant.zero)
            view.addConstraints([releaseDateLabelTopConstraint, releaseDateLabelHorizontalConstraint])
            
            view.addSubview(copyrightLabel)
            copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
            let copyrightLabelTopConstraint = NSLayoutConstraint(item: copyrightLabel, attribute: .top, relatedBy: .equal, toItem: releaseDateLabel, attribute: .bottom, multiplier: 1.0, constant: Constant.twenty)
            let copyrightLeftConstraint = NSLayoutConstraint(item: copyrightLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: Constant.twenty)
            let copyrightRightConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: copyrightLabel, attribute: .trailing, multiplier: 1, constant: Constant.twenty)
            view.addConstraints([copyrightLabelTopConstraint, copyrightLeftConstraint, copyrightRightConstraint])
            
            copyrightLabel.numberOfLines = 0
            copyrightLabel.lineBreakMode = .byWordWrapping
            
            view.addSubview(seeItunesButton)
            seeItunesButton.setTitleColor(.blue, for: .normal)
            seeItunesButton.translatesAutoresizingMaskIntoConstraints = false
            let seeItunesButtonBottomConstraint = NSLayoutConstraint(item: seeItunesButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: Constant.twenty)
            let seeItunesButtonLeadingConstraint = NSLayoutConstraint(item: seeItunesButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: Constant.twenty)
            let seeItunesButtonTrailingConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: seeItunesButton, attribute: .trailing, multiplier: 1.0, constant: Constant.twenty)
            view.addConstraints([seeItunesButtonBottomConstraint, seeItunesButtonLeadingConstraint, seeItunesButtonTrailingConstraint])
            
            seeItunesButton.addTarget(self, action: #selector(tappedSeeItunes), for: .touchUpInside)
            
        }
    }
    
    private func renderView() {
        parentViewModel?.getImage(forMedia: correspondingMedia, completion: { image in
            self.imageView.image = image
        })
        artistnameLabel.text = correspondingMedia?.artistName
        albumNameLabel.text = correspondingMedia?.name
        var genreString = ""
        if let genreArray = correspondingMedia?.genres, genreArray.count >= 1 {
            for genre in genreArray {
                if let last = genreArray.last, genre == last {
                    genreString += genre.name
                } else {
                    genreString += genre.name + ", "
                }
            }
        }
        genreLabel.text = genreString
        releaseDateLabel.text = correspondingMedia?.releaseDate
        copyrightLabel.text = correspondingMedia?.copyright
        seeItunesButton.setTitle("See Artist in Itunes", for: .normal)
    }
}

//MARK: Private
extension MediaDetailViewController {
    @objc private func tappedSeeItunes() {
        guard let urlString = correspondingMedia?.iTunesURL, let url = URL(string: urlString) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
