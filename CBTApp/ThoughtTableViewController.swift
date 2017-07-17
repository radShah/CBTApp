//
//  ThoughtTableViewController.swift
//  CBTApp
//
//  Created by Radha on 5/12/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

import UIKit
import CoreData

class ThoughtTableViewController: UITableViewController {
    
    
     var myList : [AnyObject] = []
     var standardUserDefaults : UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

     override func viewWillAppear(_ animated: Bool) {
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Thoughts")
         
         myList = try! context.fetch(fetchRequest)
         tableView.reloadData()
     }
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "thoughtCell", for: indexPath)
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        let data: NSManagedObject = myList[indexPath.row] as! NSManagedObject
        print(data)
        let emotion = data.value(forKey: "emotion") as! String
        cell.textLabel!.text = emotion
        
        let action = data.value(forKey: "action") as! String
        let belief = data.value(forKey: "belief")  as! String
        
        
        if (standardUserDefaults.object(forKey: emotion) != nil) {
            let colorData : Data = standardUserDefaults.object(forKey: emotion) as! Data
            let color : UIColor = NSKeyedUnarchiver.unarchiveObject(with: colorData) as! UIColor
            cell.backgroundColor = color
            cell.textLabel!.backgroundColor = UIColor.clear
            cell.detailTextLabel!.backgroundColor = UIColor.clear
        }
        
         cell.detailTextLabel!.text = "\(action) \(belief)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath : IndexPath) {
        
        let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        if editingStyle == .delete {
            context.delete(myList[indexPath.row] as! NSManagedObject)
            myList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                try context.save()
            } catch let error1 as NSError {
                print (error1.localizedDescription)
                abort()
            }
        }
        
    }

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            if segue.identifier == "Update" {
                let indexPath = self.tableView.indexPath(for: cell)
                let selectedItem:NSManagedObject = myList[indexPath!.row] as! NSManagedObject
                let itemViewController : ItemViewController = segue.destination as! ItemViewController
                itemViewController.emotion = selectedItem.value(forKey: "emotion") as! String
                itemViewController.action = selectedItem.value(forKey: "action") as! String
                itemViewController.activatingEvent = selectedItem.value(forKey: "activatingEvent") as! String
                itemViewController.thinkingError = selectedItem.value(forKey: "thinkingError") as! String
                itemViewController.belief = selectedItem.value(forKey: "belief") as! String
                itemViewController.existingItem = selectedItem
            }
        }
    }

}
