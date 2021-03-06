//  PROGRAMMER: Davy Mbaku Ngoma, Alexandra Daglio, Rebecca Dupuis

//  PANTHERID: 6043597, 2254610, 6056552

//  CLASS: COP 465501 online

//  INSTRUCTOR: Steve Luis ECS 282

//  ASSIGNMENT: Group Project- Deliverable 2

//  DUE: Saturday 08/01/2020
//
//  ToolViewController.swift
//  Groupject
//
//  Created by davy ngoma mbaku on 7/19/20.
//  Copyright © 2020 davyngoma. All rights reserved.
//

import UIKit

//control button to show
enum Origin {
    case today
    case tool
    case none
}

class ToolViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var createNewqButton: UIButton!
    @IBOutlet weak var tableVIew: UITableView!
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIew.delegate = self
        tableVIew.dataSource = self
        tableVIew.tableFooterView = UIView()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "ReuseCell", bundle: nil)
        tableVIew.register(nib, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //set filter data
        Model.sharedInstance.sortData(by: .display)
        Model.sharedInstance.isFilter = false
        searchBar.placeholder = "Search By title"
        Model.sharedInstance.filterData = Model.sharedInstance.announcementsArray
        Model.sharedInstance.sortData(by: .filter)
        searchBar.resignFirstResponder()
        tableVIew.reloadData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //deselect row
        if let selectedIndexPath = selectedIndexPath {
            tableVIew.deselectRow(at: selectedIndexPath, animated: true)
        }
        searchBar.resignFirstResponder()
    }
    
    @IBAction func createNewButton(_ sender: UIButton) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Create") as? CreateNewViewController {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
}

// MARK - Handle UITableViewDataSource, UITableViewDelegate
extension ToolViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Model.sharedInstance.isFilter == true && searchBar.text != "" {
            return  Model.sharedInstance.filterData.count
        }
        return Model.sharedInstance.announcementsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomToolTableViewCell else {
            return UITableViewCell()
        }
        if Model.sharedInstance.isFilter == true && searchBar.text != "" {
            let index =  Model.sharedInstance.filterData[indexPath.row]
            cell.bind(label1: index.title ?? "", label2: index.announcer ?? "")
            return cell
        }
        let index = Model.sharedInstance.announcementsArray[indexPath.row]
        cell.bind(label1: index.title ?? "", label2: index.announcer ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //get item
       let index = Model.sharedInstance.announcementsArray[indexPath.row]
       //if picture exist show show imageView
       // if not picture show detail view
       if index.image != nil {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showImage") as? ShowImageViewController {
                viewController.viewModel = showImageOnlyModel(value: index)
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        } else {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                viewController.index = DetailViewModel(value: index, indexPath: indexPath.row)
                selectedIndexPath = indexPath
                viewController.origin = .tool
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
    }
}

// MARK - Handle UISearchBarDelegate
extension ToolViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let textFieldInfo = searchBar.text,  !textFieldInfo.isEmpty, textFieldInfo != "" else {
            //reset
            Model.sharedInstance.isFilter = false
            Model.sharedInstance.sortData(by: .display)
            tableVIew.reloadData()
            return
        }
        //filter result
        Model.sharedInstance.isFilter = true
        Model.sharedInstance.filterData = Model.sharedInstance.announcementsArray.filter {
            return ($0.title?.lowercased() as AnyObject).contains(textFieldInfo.lowercased())
        }
        Model.sharedInstance.sortData(by: .filter)
        tableVIew.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
        tableVIew.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}
