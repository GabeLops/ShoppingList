//
//  ViewController.swift
//  Challenge2
//
//  Created by Gabriel Lops on 12/7/19.
//  Copyright © 2019 Gabriel Lops. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var wishList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Christmas Wishlist!"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetScreen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptforAnswer))
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishList.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = wishList[indexPath.row]
        return cell
        
    }
    
    @objc func promptforAnswer() {
        let ac = UIAlertController(title: "Shopping List", message: "Add your desired item", preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        if answer.count >= 2{
        let lowerAnswer = answer.lowercased()
        wishList.insert(lowerAnswer, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        return
        }else{
            let Error = UIAlertController(title: "invalid" , message: "That is not a real Item", preferredStyle: .alert)
            Error.addAction(UIAlertAction(title: "Okay", style: .default))
            present(Error, animated: true)
            
        }
        
    }
    
    @objc func resetScreen() {
        let ac = UIAlertController(title: "New wish list", message: "Would you like to start a new wish list?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
        (action: UIAlertAction!) in
        return
        
            
        }))
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
        (action: UIAlertAction!) in
        self.wishList.removeAll()
        self.tableView.reloadData()
        }))
        present (ac, animated: true)

        
        
        
    }


}

