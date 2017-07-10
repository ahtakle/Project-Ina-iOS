//
//  GlossaryTableViewController.swift
//  Ina
//
//  Created by Zachary Skemp on 5/25/17.
//  Copyright © 2017 ProjectIna. All rights reserved.
//

import UIKit
import QuickLook

class GlossaryTableViewController: UITableViewController, QLPreviewControllerDataSource {
    
    var glossarylist = [Glossary]()
    let ql = QLPreviewController()
    //Global var to select PDF by name
    var name = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data.
        loadGlossaryData()

        
        //Set up the PDF Viewer when clicking
        ql.dataSource  = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return glossarylist.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "GlossaryTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GlossaryTableViewCell
        
        // Fetches the appropriate term for the data source layout.
        let glossary = glossarylist[indexPath.row]
        cell?.termLabel.text = glossary.title
        cell?.termLabel.numberOfLines=0
        cell?.termLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell?.diamondImage.image = UIImage(named: "arrowhead")
        cell?.diamondImage.frame.size.width = 40
        cell?.diamondImage.frame.size.height = 40
        
        return cell!
    }
    
    //Set the height of each cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Changes variable to find correct PDF
        name = glossarylist[indexPath.row].title
        //Refreshes which PDF Quicklook should display
        ql.refreshCurrentPreviewItem()
        //Pushes new Quicklook preview over glossarylist (stays in same nav controller)
        navigationController?.pushViewController(ql, animated: true)
    }

    
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

    //Loads Glossary Data (Name should match PDF)
    private func loadGlossaryData() {
        let term1 = Glossary(title: "I am gonna write something really long and see what happens. There is no way a title would be this long right?")
        glossarylist.append(term1)
        let term2 = Glossary(title: "test1")
        glossarylist.append(term2)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
