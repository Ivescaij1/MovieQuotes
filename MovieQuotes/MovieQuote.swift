//
//  MovieQuote.swift
//  MovieQuotes
//
//  Created by Junfei Cai on 5/6/20.
//  Copyright © 2020 Junfei Cai. All rights reserved.
//

import Foundation
import Firebase

class MovieQuote {
    var movie: String
    var quote: String
    var id: String?
    var created: Date?
    
    init(quote: String, movie: String){
        self.movie = movie
        self.quote = quote
    }
    
    init(documentSnapshot: DocumentSnapshot){
        self.id = documentSnapshot.documentID
        let data = documentSnapshot.data()!
        self.quote = data["quote"] as! String
        self.movie = data["movie"] as! String
    }
}
