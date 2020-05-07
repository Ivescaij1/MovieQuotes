//
//  MovieQuoteDetailViewController.swift
//  MovieQuotes
//
//  Created by Junfei Cai on 5/6/20.
//  Copyright © 2020 Junfei Cai. All rights reserved.
//

import UIKit

class MovieQuoteDetailViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    var movieQuote: MovieQuote?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    func updateView(){
        quoteLabel.text = movieQuote?.quote
        movieLabel.text = movieQuote?.movie
        
    }
}
