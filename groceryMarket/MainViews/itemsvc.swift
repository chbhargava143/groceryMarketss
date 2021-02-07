//
//  itemsvc.swift
//  groceryMarket
//
//  Created by bhargava on 07/02/21.
//  Copyright © 2021 bhargava. All rights reserved.
//

import UIKit

class itemsvc: UITableViewController {
    var category : Category?
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("we have\(category?.name ?? "")")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemToAddItemSegue"{
            let destinationVc = segue.destination as! addItemVc
            destinationVc.category = category!
        }
    }


}
