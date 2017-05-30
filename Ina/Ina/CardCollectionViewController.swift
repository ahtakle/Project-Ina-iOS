//
//  CardCollectionViewController.swift
//  Ina
//
//  Created by Zachary Skemp on 5/28/17.
//  Copyright © 2017 ProjectIna. All rights reserved.
//

import UIKit
import QuickLook

class CardCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, QLPreviewControllerDataSource {
    
    // MARK: - Properties
    let reuseIdentifier = "CardCollectionViewCell"
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    var resourcelist = [CardTerm]()
    let ql = QLPreviewController()
    //Global var to select PDF by name
    var name = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data.
        loadResourceData()
        
        //Set up the PDF Viewer when clicking
        ql.dataSource  = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes 
        //THIS WAS CAUSING A BUG SO THE INTERNET SAID TO COMMENT IT OUT :)
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //self.collectionView!.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return resourcelist.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cellIdentifier = "CardCollectionViewCell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCollectionViewCell
    
        let resource = resourcelist[indexPath.row]
        
        // Configure the cell
        cell.imageView.image = resource.image
        cell.textView.text = resource.title
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 shouldSelectItemAt indexPath: IndexPath) -> Bool {
        //Changes variable to find correct PDF
        name = resourcelist[indexPath.row].title
        //Refreshes which PDF Quicklook should display
        ql.refreshCurrentPreviewItem()
        //Pushes new Quicklook preview over glossarylist (stays in same nav controller)
        navigationController?.pushViewController(ql, animated: true)
        return false
    }
    
    //QL Protocol Methods
    
    func numberOfPreviewItems(in: QLPreviewController) -> Int{
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let mainbundle = Bundle.main
        //Picks file based on global var name which is changed in didSelectRowAt
        let url = mainbundle.path(forResource: name, ofType: "pdf")!
        let doc = NSURL(fileURLWithPath: url)
        return doc
    }
    
    // MARK: Load Data
    
    //Loads Resource Data (Name should match PDF)
    private func loadResourceData() {
        let term1 = CardTerm(title: "test2", image: UIImage(named: "coteau")!)
        resourcelist.append(term1)
        let term2 = CardTerm(title: "test1", image: UIImage(named: "coteau")!)
        resourcelist.append(term2)
        let term3 = CardTerm(title: "test3", image: UIImage(named: "coteau")!)
        resourcelist.append(term3)
        let term4 = CardTerm(title: "test4", image: UIImage(named: "coteau")!)
        resourcelist.append(term4)
    }
    

    // MARK: UICollectionViewDelegate

    //These methods overrdie the ViewDelegate protocol to shape the views into larger, 2-column cards
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */

}
