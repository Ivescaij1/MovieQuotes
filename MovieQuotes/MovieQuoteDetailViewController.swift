//
//  MovieQuoteDetailViewController.swift
//  MovieQuotes
//
//  Created by Junfei Cai on 5/6/20.
//  Copyright © 2020 Junfei Cai. All rights reserved.
//

import UIKit
import Firebase

class MovieQuoteDetailViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    var movieQuote: MovieQuote?
    var movieQuoteRef: DocumentReference!
    var movieQuoteListner: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit,
                                                            target: self, action: #selector(showEditDialog))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//      updateView()
        movieQuoteListner = movieQuoteRef.addSnapshotListener { (documentSnapshot, error) in
            
        if let error = error {
            print ("Error getting movie quote \(error)")
            return
        }
            
        if documentSnapshot!.exists {
                
        } else {
            print("deleted")
        }
            
        self.movieQuote = MovieQuote(documentSnapshot: documentSnapshot!)
        self.updateView()
        
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        movieQuoteListner.remove()
    }
    
    @objc func showEditDialog(){
        let alertController = UIAlertController(title: "Edit this movie quote",
                                                message: "",
                                                preferredStyle: .alert)
        alertController.addTextField {(textField) in
            textField.placeholder = "Quote"
            textField.text = self.movieQuote?.quote
        }
        alertController.addTextField {(textField) in
            textField.placeholder = "Movie"
            textField.text = self.movieQuote?.movie
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        alertController.addAction(UIAlertAction(title: "Submit",
                                                style: UIAlertAction.Style.default) { (action) in
                                                    //print("TODO: create")
                                                    let quoteTextField = alertController.textFields![0] as UITextField
                                                    let movieTextField = alertController.textFields![1] as UITextField
//                                                    self.movieQuote?.quote = quoteTextField.text!
//                                                    self.movieQuote?.movie = movieTextField.text!
//                                                    self.updateView()
                                                    self.movieQuoteRef.updateData([
                                                        "quote": quoteTextField.text!,
                                                        "movie": movieTextField.text!
                                                    ])
        })
        
        present(alertController, animated: true, completion: nil)
    }
    
    func updateView(){
        quoteLabel.text = movieQuote?.quote
        movieLabel.text = movieQuote?.movie
        
    }
}
