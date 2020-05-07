//
//  MovieQuotesTableViewController.swift
//  MovieQuotes
//
//  Created by Junfei Cai on 5/6/20.
//  Copyright © 2020 Junfei Cai. All rights reserved.
//

import UIKit
import Firebase

class MovieQuotesTableViewController: UITableViewController {
    let movieQuoteCellIdentifer = "MovieQuoteCell"
    let detailSegueIdentifer = "DetailSegue"
    var movieQuotesRef: CollectionReference!
    var movieQuoteListener: ListenerRegistration!
    
    var movieQuotes = [MovieQuote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(showAddQuoteDialog))
        
//        movieQuotes.append(MovieQuote(quote: "Q1", movie: "M1"))
//        movieQuotes.append(MovieQuote(quote: "Q2", movie: "M2"))
        movieQuotesRef = Firestore.firestore().collection("MovieQuotes")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        movieQuoteListener = movieQuotesRef.order(by: "created", descending: true).limit(to: 50).addSnapshotListener {(querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.movieQuotes.removeAll()
                querySnapshot.documents.forEach { (documentSnapshot) in
//                    print(documentSnapshot.documentID)
//                    print(documentSnapshot.data())
                    self.movieQuotes.append(MovieQuote(documentSnapshot: documentSnapshot))
                }
                self.tableView.reloadData()
            } else {
                print("error getting movie quote \(error!)")
                return
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        movieQuoteListener.remove()
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
//                                                    let newMovieQuote = MovieQuote(quote: quoteTextField.text!,
//                                                                                   movie: movieTextField.text!)
//                                                    self.movieQuotes.insert(newMovieQuote, at: 0)
//                                                    self.tableView.reloadData()
                                                    self.movieQuotesRef.addDocument(data: [
                                                        "quote": quoteTextField.text!,
                                                        "movie": movieTextField.text!,
                                                        "created": Timestamp.init()
                                                    ])
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
//            movieQuotes.remove(at: indexPath.row)
//            tableView.reloadData()
            let movieQuoteToDelete = movieQuotes[indexPath.row]
            movieQuotesRef.document(movieQuoteToDelete.id!).delete()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == detailSegueIdentifer){
            if let indexPath = tableView.indexPathForSelectedRow {
//                (segue.destination as! MovieQuoteDetailViewController).movieQuote = movieQuotes[indexPath.row]
                (segue.destination as! MovieQuoteDetailViewController).movieQuoteRef = movieQuotesRef.document(movieQuotes[indexPath.row].id!)
                
            }
        }
    }
}
