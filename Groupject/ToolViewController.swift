//
//  ToolViewController.swift
//  Groupject
//
//  Created by davy ngoma mbaku on 7/19/20.
//  Copyright © 2020 davyngoma. All rights reserved.
//

import UIKit

class ToolViewController: UIViewController {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var createNewqButton: UIButton!
    @IBOutlet weak var tableVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIew.delegate = self
        tableVIew.dataSource = self
        tableVIew.tableFooterView = UIView()
        searchField.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        searchField.text = ""
        searchField.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func createNewButton(_ sender: UIButton) {
        
    }
    
}


extension ToolViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //use the array from core data once core data added
        return Model.sharedInstance.announcementsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomToolTableViewCell else {
            return UITableViewCell()
        }
        let index = Model.sharedInstance.announcementsArray[indexPath.row]
        
        cell.bind(label1: index.title, label2: index.announcer ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let index = Model.sharedInstance.announcementsArray[indexPath.row]
       let vc = DetailViewController()
        vc.index = index
       present(vc, animated: true, completion: nil)
    }
}

extension ToolViewController: UITextFieldDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let textFieldInfo = textField.text,  !textFieldInfo.isEmpty, textFieldInfo != "" else {
            return
        }
        
        tableVIew.reloadData()
    }
}

