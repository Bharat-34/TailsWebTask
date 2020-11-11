//
//  ViewController.swift
//  TailsWebTask
//
//  Created by Bharat on 10/11/20.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var yesBackgroundView: UIView!
    @IBOutlet weak var trackingHistoryView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        yesBackgroundView.layer.masksToBounds = false
        yesBackgroundView.layer.borderWidth = 1
        yesBackgroundView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        yesBackgroundView.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        yesBackgroundView.layer.shadowOpacity = 0.5
        yesBackgroundView.layer.shadowOffset = .zero
        yesBackgroundView.layer.shadowRadius = 5
        
        trackingHistoryView.layer.masksToBounds = false
        trackingHistoryView.layer.borderWidth = 1
        trackingHistoryView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        trackingHistoryView.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        trackingHistoryView.layer.shadowOpacity = 0.5
        trackingHistoryView.layer.shadowOffset = .zero
        trackingHistoryView.layer.shadowRadius = 5
                
    }
    @IBAction func yesAction(_ sender: Any) {
        
        let TrackingVc = self.storyboard?.instantiateViewController(identifier: "TrackingViewController") as! TrackingViewController
        self.present(TrackingVc, animated: false, completion: nil)
        
    }
    
    @IBAction func trackingHistory(_ sender: UIButton) {
        
        let tableViewVc = self.storyboard?.instantiateViewController(identifier: "TableViewController") as! TableViewController
        self.present(tableViewVc, animated: false, completion: nil)
        
    }
    
}

