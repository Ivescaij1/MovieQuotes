//
//  MovieQuote.swift
//  MovieQuotes
//
//  Created by Junfei Cai on 5/6/20.
//  Copyright © 2020 Junfei Cai. All rights reserved.
//

import Foundation

class MovieQuote {
    var movie: String
    var quote: String
    
    init(quote: String, movie: String){
        self.movie = movie
        self.quote = quote
    }
}
