//
//  categoryVc.swift
//  grocery
//
//  Created by bhargava on 04/02/21.
//

import UIKit


class categoryVc: UICollectionViewController {
   // var actView: UIView = UIView()
    let THEME_COLOUR = UIColor.init(hue: 1, saturation: 0.4, brightness: 0.2, alpha: 1)
    //var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
   // var titleLabel: UILabel = UILabel()
    
    //var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    private let sectionInsects = UIEdgeInsets(top: 20, left: 10, bottom: 50, right: 10)
   // private let itemsPerRow : CGFloat = 3
    var categoryArray : [Category] = []
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
          loadCategoriesFrom()
    }

    // MARK: UICollectionViewDataSource

  


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categoryArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! categoryCell
        // Configure the cell
        let cateGoryDict = categoryArray[indexPath.row]
        cell.generateCell(cateGoryDict)
        cell.shadowDecorate(radius: 8)
//            cell.categoryImage.image = UIImage(named: cateGoryDict.imageName ?? "" )
//
//
//        cell.categoryNameLbl.text = cateGoryDict.name
        return cell
    }
    // MARK :- uicollectionView delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "categoryToItemsSegue", sender: categoryArray[indexPath.row])
    }
    // MARK :- Navigation to Another vc
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryToItemsSegue"{
            let destinationVc = segue.destination as! itemsvc
            destinationVc.category = sender as! Category
        }
    }
// MARK :- Download Categories
    private func loadCategoriesFrom(){
         showActivity()
        downloadcategoriesFromFirebase { (categoriesData) in
            print("We have\(categoriesData.count)")
            self.categoryArray = categoriesData
           
            self.collectionView.reloadData()
            self.removeActivity()
               }
           
    }
     func showActivity() {
        //creating view to background while displaying indicator
        let container: UIView = UIView()
        container.frame = self.view.frame
        container.center = self.view.center
        container.backgroundColor = UIColor.clear

        //creating view to display lable and indicator
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 118, height: 80)
        loadingView.center = self.view.center
        loadingView.backgroundColor = UIColor(white: 1, alpha: 0.1)
            
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        //Preparing activity indicator to load
        self.activityIndicator = UIActivityIndicatorView()
        self.activityIndicator.color = UIColor.red
        self.activityIndicator.frame = CGRect(x: 40, y: 12, width: 40, height: 40)
        self.activityIndicator.style = UIActivityIndicatorView.Style.large
        loadingView.addSubview(activityIndicator)

        //creating label to display message
        let label = UILabel(frame: CGRect(x: 5, y: 55,width: 120,height: 20))
        label.text = "Loading..."
        label.textColor = UIColor.white
        label.bounds = CGRect(x: 0, y: 0, width: loadingView.frame.size.width / 2, height: loadingView.frame.size.height / 2)
        label.font = UIFont.systemFont(ofSize: 12)
        loadingView.addSubview(label)
        container.addSubview(loadingView)
        self.view.addSubview(container)

        self.activityIndicator.startAnimating()
      
    }
    func removeActivity() {
        UIApplication.shared.endIgnoringInteractionEvents()
               self.activityIndicator.stopAnimating()
        ((self.activityIndicator.superview as UIView?)?.superview as UIView?)?.removeFromSuperview()
       
        
    }

}
extension categoryVc:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let paddingSpace = sectionInsects.left * (itemsPerRow + 1)
//        let availablWidth = view.frame.width - paddingSpace
//        let widthPerItem = availablWidth / itemsPerRow
        //let size = (collectionView.frame.size.width - 10) / 4
        let size = collectionView.frame.size.width
        return CGSize(width: (size - (3+1)*10) / 3, height: (size - (3+1)*10) / 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsects
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsects.left
    }
}
