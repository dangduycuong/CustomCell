//
//  ViewController.swift
//  CustomCell2
//
//  Created by duycuong on 1/15/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    //MARK: Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    var dataTitleLabel: String?
    var dataTextLabel: String?
    var imageView: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        if dataTitleLabel != nil && dataTextLabel != nil {
            titleLabel.text = dataTitleLabel
            textLabel.text = dataTextLabel
            nameImageView.image = imageView
        }
        // Do any additional setup after loading the view.
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 5
        return nameImageView
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
