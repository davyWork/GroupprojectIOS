//  PROGRAMMER: Davy Mbaku Ngoma, Alexandra Daglio, Rebecca Dupuis

//  PANTHERID: 6043597, 2254610, 6056552

//  CLASS: COP 465501 online

//  INSTRUCTOR: Steve Luis ECS 282

//  ASSIGNMENT: Group Project- Deliverable 2

//  DUE: Saturday 08/01/2020
//
//  ViewController.swift
//  Groupject
//
//  Created by davy ngoma mbaku on 7/19/20.
//  Copyright © 2020 davyngoma. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segementController: UISegmentedControl!
    var index: Model.Announcement?
    var selectedIndexPath: IndexPath?
    enum Sections: Int, CaseIterable {
        case Annoucement = 0
        case essentials = 1
    }
    //array of essentials
    var essentials: [Model.Announcement]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    //array annoucement
    var annoucement: [Model.Announcement]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "ReuseCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        tableView.tableFooterView = UIView()
        switch segementController.selectedSegmentIndex {
        case 0:
            annoucement = Model.sharedInstance.dataByCategories(category: .annoucement)
        case 1:
            essentials = Model.sharedInstance.dataByCategories(category: .essentials)
        default:
            break;
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let selectedIndexPath = selectedIndexPath {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            annoucement = Model.sharedInstance.dataByCategories(category: .annoucement)
        case 1:
            essentials = Model.sharedInstance.dataByCategories(category: .essentials)
        default:
            break;
        }
    }
}

extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segementController.selectedSegmentIndex {
        case 0:
            return annoucement?.count ?? 0
        case 1:
            return essentials?.count ?? 0
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomToolTableViewCell else {
            return UITableViewCell()
        }
        switch segementController.selectedSegmentIndex {
        case 0:
            let index = annoucement?[indexPath.row]
            cell.bind(label1: index?.title ?? "", label2: index?.announcer ?? "")
        case 1:
            let index = essentials?[indexPath.row]
            cell.bind(label1: index?.title ?? "", label2: index?.announcer ?? "")
        default: return CustomToolTableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segementController.selectedSegmentIndex {
        case 0:
            index = annoucement?[indexPath.row]
        case 1:
             index = essentials?[indexPath.row]
        default:
            break;
        }
        guard let _index = index else {
            return
        }
        
        if index?.image != nil {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showImage") as? ShowImageViewController {
                viewController.viewModel = showImageOnlyModel(value: _index)
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        } else {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                viewController.index = DetailViewModel(value: _index, indexPath: indexPath.row)
                selectedIndexPath = indexPath
                viewController.origin = .today
                if let navigator = navigationController {
                    navigator.pushViewController(viewController, animated: true)
                }
            }
        }
    }
}

