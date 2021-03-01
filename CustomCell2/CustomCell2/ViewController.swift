//
//  ViewController.swift
//  CustomCell2
//
//  Created by duycuong on 1/15/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 0.2
            scrollView.maximumZoomScale = 3
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var nameImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    var dataTitleLabel: String?
    var dataTextLabel: String?
    var imageView: UIImage?
    var indexImage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dataTitleLabel = dataTitleLabel, let dataTextLabel = dataTextLabel, let imageView = imageView {
            titleLabel.text = dataTitleLabel
            textLabel.text = dataTextLabel
            nameImageView.image = imageView
        }
        
        //cấu hình lại ảnh đã tạo bằng outlet
        nameImageView.contentMode = .scaleToFill
        nameImageView.isUserInteractionEnabled = true
        nameImageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:))))
    }
    
    func createImage(number: Int) {
        let lightBulb = UIImageView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        var name: String = "lightBulb"
        if number % 2 == 0 {
            name = "sochan"
        }
        lightBulb.image = UIImage(named: name)
        lightBulb.contentMode = .scaleToFill
        lightBulb.isUserInteractionEnabled = true
        lightBulb.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:))))
        self.view.addSubview(lightBulb)
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        
        recognizer.setTranslation(.zero, in: self.view)
    }
    
}

extension ViewController: UIScrollViewDelegate {
    // MARK: - scrollView Delegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nameImageView
    }
}

extension ViewController {
    // MARK: - Action
    @IBAction func tapCreateImage(_ sender: Any) {
        indexImage += 1
        //tạo ảnh bằng code
        createImage(number: indexImage) //comment
    }
}
