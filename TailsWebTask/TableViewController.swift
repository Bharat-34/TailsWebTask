//
//  TableViewController.swift
//  TailsWebTask
//
//  Created by Bharat on 11/11/20.
//

import UIKit
import FirebaseFirestore

class TableViewController: UITableViewController {
    
    
    var db:Firestore!
    
    var locationsArray = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        loadData()
        checkForUpdates()
    }
    
    func loadData() {
        db.collection("locations").getDocuments() {
            querySnapshot, error in
            if let error = error {
                print("\(error.localizedDescription)")
            }else{
                self.locationsArray = querySnapshot!.documents.compactMap({Location(dictionary: $0.data())})
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        
    }
    
    func checkForUpdates() {
        db.collection("locations").whereField("timeStamp", isGreaterThan: Date())
            .addSnapshotListener {
                querySnapshot, error in
                
                guard let snapshot = querySnapshot else {return}
                
                snapshot.documentChanges.forEach {
                    diff in
                    
                    if diff.type == .added {
                        self.locationsArray.append(Location(dictionary: diff.document.data())!)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
                
            }
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return locationsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let location = locationsArray[indexPath.row]
        
//        Cell.textLabel?.text = "\(location.lattitude): \(location.longitude)"
//        Cell.detailTextLabel?.text = "\(location.timeStamp)"
       
        print("locationsssssssassasas \(location.timeStamp)")
        
        return Cell
    }
    
    
}
