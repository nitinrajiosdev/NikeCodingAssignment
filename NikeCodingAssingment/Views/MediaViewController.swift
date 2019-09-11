//
//  MediaViewController.swift
//  NikeCodingAssingment
//
//  Created by Nitin Pabba on 9/10/19.
//  Copyright © 2019 Nitin Pabba. All rights reserved.
//

import UIKit

class MediaViewController: UIViewController {
    
    var mainTableView = UITableView(frame: .zero)
    var viewModel = MediaViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellType = MediaTableViewCell.self
        mainTableView.register(cellType, forCellReuseIdentifier: String(describing: cellType))
        configureSubviews()
        mainTableView.dataSource = self
        mainTableView.delegate = self
        viewModel.notifyWhenDataComplete = { [weak self] in
            //Using weak here, because viewmodel has a strong reference to notifyWhenDataComplete
            DispatchQueue.main.async {
                self?.mainTableView.reloadData()
            }
        }
        viewModel.getMedia()
    }

}

//MARK: Private
extension MediaViewController {
    private func configureSubviews() {
        view.addSubview(mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        
        if let view = view {
            //constraint
            //Was going to forcefully unwrap, because we're sure to have a view, as we're carefully only calling this inside viewdidload. which means the view is already available to us, But the challenge asked not to forecefully unwrap
            let leadingConstraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: mainTableView, attribute: .leading, multiplier: 1.0, constant: 0)
            let trailingConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: mainTableView, attribute: .trailing, multiplier: 1.0, constant: 0)
            let topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: mainTableView, attribute: .top, multiplier: 1.0, constant: 0)
            let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: mainTableView, attribute: .bottom, multiplier: 1.0, constant: 0)
            
            view.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        }
        
    }
}

//MARK: UITableViewDataSource methods
extension MediaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mediaArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: MediaTableViewCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MediaTableViewCell else {
            fatalError("Illegal application state! A cell with identifier: \(identifier) needs to be registered with the tableview!")
        }
        cell.configure(withViewModel: self.viewModel, atIndexPath: indexPath)
        return cell
    }
}

extension MediaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let media = viewModel.getMedia(atIndexPath: indexPath)
        let mediaDetailViewController = MediaDetailViewController()
        mediaDetailViewController.correspondingMedia = media
        mediaDetailViewController.parentViewModel = viewModel
        navigationController?.pushViewController(mediaDetailViewController, animated: true)
    }
}
