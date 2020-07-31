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
    @IBOutlet weak var titleValue: UILabel!
    @IBOutlet weak var announcer: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var viewModel: showImageOnlyModel?
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Show Image"
        announcer.text = viewModel?.announcer
        titleValue.text = viewModel?.titleValue
        imagevIewA.image = viewModel?.getimage()
        timerLabel.text = "\(viewModel?.getTimer() ?? 1.0)"
    }
    
    override func viewWillDisappear (_ animated: Bool) {
        super.viewWillDisappear(animated)
        isTimerRunning = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isTimerRunning == false {
            runTimer()
        }
    }
}

// MARK: Handle timer
extension ShowImageViewController {
    func runTimer() {
        //first set the appropriate number of seconds according to the object
        seconds = Int((viewModel!.timerLabel ?? 0) * 60) //get the number of seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(DetailViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            timerLabel.textColor = .red
            DispatchQueue.main.async {
                self.alertView("Time is Up", title: "Cancel")
            }
        } else {
            seconds -= 1     //decrement(count down)the seconds
            timerLabel.text = timeString(time: TimeInterval(seconds)) //update the label
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    /// Description function to show alert
    ///
    /// - Parameter: - no param
    func alertView(_ message: String, title: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: title, style: .default, handler: { (alert: UIAlertAction!) in
        })
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
