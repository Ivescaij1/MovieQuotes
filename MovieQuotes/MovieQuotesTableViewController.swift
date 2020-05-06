//
//  MovieQuotesTableViewController.swift
//  MovieQuotes
//
//  Created by Junfei Cai on 5/6/20.
//  Copyright © 2020 Junfei Cai. All rights reserved.
//

import UIKit

class MovieQuotesTableViewController: UITableViewController {
    let movieQuoteCellIdentifer = "MovieQuoteCell"
    var movieQuotes = [MovieQuote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(showAddQuoteDialog))
        
        movieQuotes.append(MovieQuote(quote: "Q1", movie: "M1"))
        movieQuotes.append(MovieQuote(quote: "Q2", movie: "M2"))
    }
    
    @objc func showAddQuoteDialog() {
        print("+ Button")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieQuotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieQuoteCellIdentifer, for: indexPath)
        
        cell.textLabel?.text = movieQuotes[indexPath.row].quote
        cell.detailTextLabel?.text = movieQuotes[indexPath.row].movie
        
        return cell
    }
}
