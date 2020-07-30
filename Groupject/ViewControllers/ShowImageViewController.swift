//
//  ShowImageViewController.swift
//  Groupject
//
//  Created by davy ngoma mbaku on 7/29/20.
//  Copyright © 2020 davyngoma. All rights reserved.
//

import UIKit

class ShowImageViewController: UIViewController {
    var image: UIImage?
    @IBOutlet weak var imagevIewA: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Show Image"
        // Do any additional setup after loading the view.
        imagevIewA.image = image
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
