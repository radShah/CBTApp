//
//  ViewController.swift
//  CBTApp
//
//  Created by Radha on 11/22/15.
//  Copyright © 2015 TurnToTech. All rights reserved.
//

import UIKit
import CoreData

class ItemViewController: UIViewController {
    
    @IBOutlet weak var emotionTextView: UITextView!
    @IBOutlet weak var beliefTextView: UITextView!
    @IBOutlet weak var actionTextView: UITextView!
    @IBOutlet weak var activatingEventTextView: UITextView!
    @IBOutlet weak var thinkingErrorTextView: UITextView!
    
    var existingItem : NSManagedObject!
    var emotion : String = ""
    var action : String = ""
    var activatingEvent : String = ""
    var belief : String = ""
    var thinkingError : String = ""
    var standardUserDefaults : UserDefaults = UserDefaults.standard
    var index : Int = 0
    let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext?
    var en : NSEntityDescription?
    var keyboardShows : Bool = false


override func viewDidLoad() {
        if (existingItem != nil) {
            emotionTextView.text  = emotion
            actionTextView.text = action
            activatingEventTextView.text = activatingEvent
            thinkingErrorTextView.text = thinkingError
            beliefTextView.text = belief
        }
        context = appDel.managedObjectContext
        en = NSEntityDescription.entity(forEntityName: "Thoughts", in: context!)!
        super.viewDidLoad()
    
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ItemViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ItemViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)

    }
    
//    func keyboardWillShow(notification: NSNotification) {
//        if (!keyboardShows) {
//            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//                self.view.frame.origin.y -= keyboardSize.height
//                keyboardShows = true
//            }
//        }
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            self.view.frame.origin.y += keyboardSize.height
//        }
//    }

    @IBAction func cancelTapped(_ sender: AnyObject) {
        self.navigationController!.popToRootViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTapped(_ sender: AnyObject) {
        
        emotion = emotionTextView.text! as String
        action = actionTextView.text! as String
        thinkingError = self.thinkingErrorTextView.text! as String
        activatingEvent = activatingEventTextView.text! as String
        belief = beliefTextView.text! as String
        
        if existingItem != nil {
            existingItem.setValue(emotionTextView.text! as String, forKey:"emotion")
            existingItem.setValue(actionTextView.text! as String, forKey:"action")
            existingItem.setValue(beliefTextView.text! as String, forKey:"belief")
            existingItem.setValue(activatingEventTextView.text! as String, forKey:"activatingEvent")
            existingItem.setValue(thinkingErrorTextView.text! as String, forKey:"thinkingError")
        } else {
            let newItem : Model = Model(entity: en!, insertInto: context)
            newItem.emotion = emotion
            newItem.action = action
            newItem.activatingEvent = activatingEvent
            newItem.belief = belief
            newItem.thinkingError = thinkingError
            print("New Item details:  \(newItem.emotion), \(newItem.action), \(newItem.activatingEvent), \(newItem.belief), \(newItem.thinkingError)")
        }
       
        do {
            try context!.save()
        } catch let error as NSError {
            print (error.localizedDescription)
            abort()
        }
        
        print("Saved successfully:\(standardUserDefaults.synchronize())")
        self.navigationController!.popToRootViewController(animated: true)
        
    }
}
