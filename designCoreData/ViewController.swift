//
//  ViewController.swift
//  designCoreData
//
//  Created by Mars on 2019/7/1.
//  Copyright © 2019 drs24. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    var viewContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewContext = appdelegate.persistentContainer.viewContext
        
        print(NSPersistentContainer.defaultDirectoryURL())
        
        insertUserData()
//        queryUserData()
        
//        queryWithCondition()
        
        storeFetch()
    }
    
    func insertUserData(){
        var user = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: viewContext) as! UserData
        
        user.iid = "A01"
        user.cname = "王大明"
        
        user = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: viewContext) as! UserData
        
        user.iid = "A02"
        user.cname = "李大媽"
        
        appdelegate.saveContext()
    }
    
    func queryUserData() {
        do {
            let allUsers = try viewContext.fetch(UserData.fetchRequest())
            for user in allUsers as! [UserData]{
                print("\(user.iid), \(user.cname)")
            }
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func queryWithCondition() {
        let fetchRequest:NSFetchRequest<UserData> = UserData.fetchRequest()
        let predicate = NSPredicate(format: "cname like '王*'")
        fetchRequest.predicate = predicate
        
        let sort = NSSortDescriptor(key: "iid", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            let allUsers = try viewContext.fetch(fetchRequest)
            for user in allUsers {
                print("\(user.iid),\(user.cname)")
            }
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func storeFetch() {
        let model = appdelegate.persistentContainer.managedObjectModel
        
        if let fetchRequest = model.fetchRequestTemplate(forName:"Fetch_is_01") {
            do{
                let allUsers = try viewContext.fetch(fetchRequest)
                
                for user in allUsers as! [UserData]{
                    print("\(user.iid),\(user.cname)")
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteUserData_OneByOne() {
        do {
            let allUsers = try viewContext.fetch(UserData.fetchRequest())
            for user in allUsers as! [UserData] {
                viewContext.delete(user)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteUser_Batch() {
        let batch = NSBatchDeleteRequest(fetchRequest:UserData.fetchRequest())
        
        do {
            try appdelegate.persistentContainer.persistentStoreCoordinator.execute(batch, with:viewContext)
        } catch  {
            print(error.localizedDescription)
        }
    }


}

