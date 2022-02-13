//
//  DiscoverViewController.swift
//  AnimeApp
//
//  Created by Camilo Orjuela on 10/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

    @IBOutlet weak var seasonTableView: UITableView!
    @IBOutlet weak var topCollectionView: UICollectionView!
    
    let viewModel = DiscoverViewModel()
    
    var searchController: UISearchController!
    private var resultsViewController: ResultsTableViewController!
    private var searchFilterSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearch()
        setupTable()
        setupBindings()
        viewModel.getAnimes()
        
        self.topCollectionView.register(UINib(nibName: "TopCell", bundle: nil), forCellWithReuseIdentifier: "reuse")
        
        self.seasonTableView.register(UINib(nibName: "SeasonCell", bundle: nil), forCellReuseIdentifier: "reuseCell")
        
    }
    private func setupTable() {
        seasonTableView.dataSource = self
        seasonTableView.delegate = self
        topCollectionView.dataSource = self
        topCollectionView.delegate = self
        topCollectionView.collectionViewLayout = ZoomAndSnapFlowLayout()
        topCollectionView.contentInsetAdjustmentBehavior = .always
    }
    
    private func setupBindings() {
        
        viewModel.loading = { [weak self] isLoading in
            if isLoading {
                self?.showLoader()
            } else {
                self?.removeLoader()
            }
        }
        
        viewModel.onGetSeasonAnimes = { [weak self]  in
            DispatchQueue.main.async {
                self?.seasonTableView.reloadData()
            }
        }
        
        viewModel.onGetTopAnimes = { [weak self]  in
            DispatchQueue.main.async {
                self?.topCollectionView.reloadData()
            }
        }
        
    }
    
    private func goToDetail(animeId: Int) {
        let detailViewModel = DetailViewModel(selectedID: animeId)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            nextViewController.viewModel = detailViewModel
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    private func setupSearch() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        resultsViewController = storyBoard.instantiateViewController(withIdentifier: "ResultsTableViewController") as? ResultsTableViewController
        resultsViewController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        searchController.searchBar.scopeButtonTitles = ["Top", "Recently added"]
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        let isSearchBarEmpty = searchController.searchBar.text?.isEmpty ?? true
        
        if searchFilterSelected == 0 {
            resultsViewController.filteredAnimes = viewModel.topAnimes.filter({ (anime) -> Bool in
                if isSearchBarEmpty {
                    return false
                } else {
                    return anime.title?.lowercased().contains(searchText.lowercased()) ?? false
                }
            })
        } else {
            resultsViewController.filteredAnimes = viewModel.seasonAnimes.filter({ (anime) -> Bool in
                if isSearchBarEmpty {
                    return false
                } else {
                    return anime.title?.lowercased().contains(searchText.lowercased()) ?? false
                }
            })
        }
        
        resultsViewController.tableView.reloadData()
    }
}

extension DiscoverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.seasonAnimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as? SeasonCell else {
            return UITableViewCell()
        }
        
        cell.configure(anime: viewModel.seasonAnimes[indexPath.row])
        return cell
    }
    
}

extension DiscoverViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView == self.seasonTableView {
            let selectedSeasonAnime = viewModel.seasonAnimes[indexPath.row].malID
            goToDetail(animeId: selectedSeasonAnime)
        } else {
            let selectedSeasonAnime = resultsViewController.filteredAnimes[indexPath.row].malID
            goToDetail(animeId: selectedSeasonAnime)
        }
    }
}

extension DiscoverViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.topAnimes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuse", for: indexPath) as? TopCell else {
        return UICollectionViewCell()
        }
        
        cell.configure(anime: viewModel.topAnimes[indexPath.row])
        return cell
       
    }
}

extension DiscoverViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedTopAnime = viewModel.topAnimes[indexPath.row].malID
        goToDetail(animeId: selectedTopAnime)
    }
}

extension DiscoverViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(collectionView.frame.height - 80)
        return CGSize(width: ZoomAndSnapFlowLayout.cellWidth, height: collectionView.frame.height - 80)
    }
}

extension DiscoverViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchFilterSelected = selectedScope
        filterContentForSearchText(searchBar.text ?? "")
    }
}

extension DiscoverViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text ?? "")
    }
}
