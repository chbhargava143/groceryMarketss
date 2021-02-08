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
    var itemsArray : [Item] = []
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("we have\(category?.name ?? "")")
        tableView.tableFooterView = UIView()
        self.title = category?.name
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if category != nil{
            // download category items
            loadItems()
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemsArray.count
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemToAddItemSegue"{
            let destinationVc = segue.destination as! addItemVc
            destinationVc.category = category!
        }
    }
// MARK: - Load items
    private func loadItems(){
        downloadItemsFromFirebase(withCategoryId: category!.id) { (allItems) in
            print("We have items\(allItems.count)")
            self.itemsArray = allItems
            self.tableView.reloadData()
        }
    }

}
