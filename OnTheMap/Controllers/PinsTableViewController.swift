//
//  PinsTableViewController.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 31/03/21.
//

import UIKit

class PinsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let parentController = tabBarController as! OnTheMapTabViewController
        parentController.fetchLocations {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let parentController = tabBarController as! OnTheMapTabViewController
        return parentController.locationsResponse?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pinUserCell", for: indexPath)
        
        let parentController = tabBarController as! OnTheMapTabViewController
        let location = parentController.locationsResponse!.results[indexPath.row]
        cell.textLabel?.text = "\(location.firstName) \(location.lastName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let parentController = tabBarController as! OnTheMapTabViewController
        let location = parentController.locationsResponse!.results[indexPath.row]
        
        UIApplication.shared.open(URL(string: location.mediaURL)!, options: [:], completionHandler: nil)
    }
}
