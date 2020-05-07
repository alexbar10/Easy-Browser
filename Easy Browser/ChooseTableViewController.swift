//
//  ChooseTableViewController.swift
//  Easy Browser
//
//  Created by Alejandro Barranco on 07/05/20.
//  Copyright © 2020 Alejandro Barranco. All rights reserved.
//

import UIKit

class ChooseTableViewController: UITableViewController {
    
    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "websiteCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = websites[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Details") as? ViewController {
            vc.websiteDefault = websites[indexPath.row]
            present(vc, animated: true)
        }
    }

}
