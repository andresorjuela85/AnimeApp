//
//  DetailViewController.swift
//  AnimeApp
//
//  Created by Camilo Orjuela on 11/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import UIKit
import AlamofireImage
import SafariServices

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var premieredView: UIView! {
        didSet {
            premieredView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var premieredLabel: UILabel!
    @IBOutlet weak var statusView: UIView! {
        didSet {
            statusView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var animeImage: UIImageView! {
        didSet {
            animeImage.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = contentView.frame.size
        
        setupBindings()
        viewModel?.getDetailAnime()
    }
    
    private func setupBindings() {
        
        guard let viewModel = viewModel else { return }
        
        viewModel.loading = { [weak self] isLoading in
            if isLoading {
                self?.showLoader()
            } else {
                self?.removeLoader()
            }
        }
        
        viewModel.onGetDetailAnime = { [weak self] in
            self?.setupDetailView()
        }
    }
    
    private func setupDetailView() {
        
        titleLabel.text = viewModel?.detailAnime?.title
        premieredLabel.text = viewModel?.detailAnime?.premiered ?? "Not premiered"
        statusLabel.text = viewModel?.detailAnime?.status ?? "Not yet aired"
        
        if let imageURL = viewModel?.detailAnime?.imageURL,
            let url = URL(string: imageURL) {
            animeImage.af.setImage(withURL: url)
        }
        
        if let genres = viewModel?.detailAnime?.genres, genres.count > 0 {
            var genreText = ""
            
            for genre in genres {
                genreText = genreText + (genre.name ?? "") + " "
            }
            genreLabel.text = genreText
        } else {
            genreLabel.text = ""
        }
        
        durationLabel.text = viewModel?.detailAnime?.duration
        ratingLabel.text = viewModel?.detailAnime?.rating
        synopsisLabel.text = viewModel?.detailAnime?.synopsis
    }
    
    @IBAction func startWatchingAnime(_ sender: Any) {

        if let urlString = viewModel?.detailAnime?.trailerURL, let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            vc.modalPresentationStyle = .formSheet
            present(vc, animated: true)
        } else if let urlString = viewModel?.detailAnime?.url, let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            vc.modalPresentationStyle = .formSheet
            present(vc, animated: true)
        }
    }
}

extension DetailViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
