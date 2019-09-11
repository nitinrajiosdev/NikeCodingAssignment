//
//  MediaTableViewCell.swift
//  NikeCodingAssingment
//
//  Created by Nitin Pabba on 9/10/19.
//  Copyright © 2019 Nitin Pabba. All rights reserved.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    
    private weak var titleLabel: UILabel?
    private weak var subtitleLabel: UILabel?
    private weak var mediaImageView: UIImageView?
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    // MARK: - Public
    
    func configure(withViewModel viewModel: MediaViewModel, atIndexPath indexPath: IndexPath) -> Void {
        let media = viewModel.getMedia(atIndexPath: indexPath)
        if indexPath.row == 0 {
            print("breakpoint")
        }
        self.titleLabel?.text = media?.name
        self.subtitleLabel?.text = media?.artistName
        viewModel.getImage(forMedia: media, completion: { [weak self] image in
            self?.mediaImageView?.image = image
        })
    }
    
    // MARK: - Private
    
    private func setupUI() -> Void {
        let imageView = UIImageView.init(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        self.contentView.addSubview(imageView)
        self.mediaImageView = imageView
        
        let titleLabel = UILabel.init(frame: .zero)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = .systemFont(ofSize: 16.0)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentHuggingPriority(.init(250.0), for: .vertical)
        self.contentView.addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        let subtitleLabel = UILabel.init(frame: .zero)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.font = .systemFont(ofSize: 14.0)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.setContentHuggingPriority(.init(251.0), for: .vertical)
        self.contentView.addSubview(subtitleLabel)
        self.subtitleLabel = subtitleLabel
        
        // Adding visual constraints to show the ability to use both types
        let views = ["imageView": imageView,
                     "title": titleLabel,
                     "subtitle": subtitleLabel]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[imageView(100)]-12-[title]-16-|",
                                                         options: [],
                                                         metrics: nil,
                                                         views: views)
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:[imageView]-12-[subtitle]-16-|",
                                                                      options: [],
                                                                      metrics: nil,
                                                                      views: views))
        constraints.append(NSLayoutConstraint.init(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1.0, constant: 0.0))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[imageView]-(>=16)-|",
                                                                      options: [],
                                                                      metrics: nil,
                                                                      views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[title]-12-[subtitle]-16@500-|",
                                                                      options: [],
                                                                      metrics: nil,
                                                                      views: views))
        constraints.append(NSLayoutConstraint.init(item: imageView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .top, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint.init(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: subtitleLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraints(constraints)
    }
    
}
