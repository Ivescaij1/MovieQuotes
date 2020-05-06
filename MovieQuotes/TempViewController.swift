//
//  TempViewController.swift
//  MovieQuotes
//
//  Created by Junfei Cai on 5/6/20.
//  Copyright © 2020 Junfei Cai. All rights reserved.
//

import UIKit

class TempViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tempCellIdentifer = "TempCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tempCellIdentifer, for: indexPath)
        cell.textLabel?.text = "Thisis row \(indexPath.row)"
        
        
        return cell
    }
    
    
    
}
