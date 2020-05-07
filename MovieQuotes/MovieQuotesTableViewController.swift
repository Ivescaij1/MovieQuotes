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
    let detailSegueIdentifer = "DetailSegue"
    
    var movieQuotes = [MovieQuote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(showAddQuoteDialog))
        
        movieQuotes.append(MovieQuote(quote: "Q1", movie: "M1"))
        movieQuotes.append(MovieQuote(quote: "Q2", movie: "M2"))
    }
    
    @objc func showAddQuoteDialog() {
        //print("+ Button")
        let alertController = UIAlertController(title: "Create new movie quote",
                                                message: "",
                                                preferredStyle: .alert)
        alertController.addTextField {(textField) in
            textField.placeholder = "Quote"
        }
        alertController.addTextField {(textField) in
            textField.placeholder = "Movie"
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        alertController.addAction(UIAlertAction(title: "Create",
                                                style: UIAlertAction.Style.default) { (action) in
                                                    //print("TODO: create")
                                                    let quoteTextField = alertController.textFields![0] as UITextField
                                                    let movieTextField = alertController.textFields![1] as UITextField
                                                    //print(quoteTextField.text!)
                                                    //print(movieTextField.text!)
                                                    let newMovieQuote = MovieQuote(quote: quoteTextField.text!,
                                                                                   movie: movieTextField.text!)
                                                    self.movieQuotes.insert(newMovieQuote, at: 0)
                                                    self.tableView.reloadData()
        })
        
        present(alertController, animated: true, completion: nil)
        
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            print("Delete")
            movieQuotes.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == detailSegueIdentifer){
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as! MovieQuoteDetailViewController).movieQuote = movieQuotes[indexPath.row]
                
            }
        }
    }
}
