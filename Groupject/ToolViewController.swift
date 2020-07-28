//
//  ToolViewController.swift
//  Groupject
//
//  Created by davy ngoma mbaku on 7/19/20.
//  Copyright © 2020 davyngoma. All rights reserved.
//

import UIKit

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
        tableVIew.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let selectedIndexPath = selectedIndexPath {
            tableVIew.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    @IBAction func createNewButton(_ sender: UIButton) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Create") as? CreateNewViewController {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
}


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
       let index = Model.sharedInstance.announcementsArray[indexPath.row]
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            viewController.index = DetailViewModel(value: index, indexPath: indexPath.row)
            selectedIndexPath = indexPath
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
}

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
        tableVIew.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
    }
}

