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

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemsArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! itemCell
        cell.generateCell(itemsArray[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        let itemVcS = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "itemViewController") as! itemViewController
        itemVcS.items = itemsArray[indexPath.row]
        
        self.navigationController?.pushViewController(itemVcS, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemToAddItemSegue" {
            let destinationVc = segue.destination as! addItemVc
            destinationVc.category = category!
        }
       
    }
// MARK: - Load items
    
    private func loadItems(){
        downloadItemsFromFirebase(category?.id ?? "") { (allItems) in
            
            print("whe have all ITems-----\(allItems.count)")
            self.itemsArray = allItems
            self.tableView.reloadData()
        }
    }
    

}
