//
//  ResultsTableViewController.swift
//  AnimeApp
//
//  Created by Camilo Orjuela on 12/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var filteredAnimes: [Anime] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAnimes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = filteredAnimes[indexPath.row].title

        return cell
    }
}
