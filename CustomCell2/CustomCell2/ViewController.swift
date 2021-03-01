//
//  ViewController.swift
//  CustomCell2
//
//  Created by duycuong on 1/15/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

enum ChooseColor {
    case blue
    case red
    case purple
    case yellow
    
    static let all = [blue, red, purple, yellow]
    
    var value: UIColor {
        get {
            switch self {
            case .blue:
                return .blue
            case .red:
                return .red
            case .purple:
                return .purple
            case .yellow:
                return .yellow
            }
        }
    }
}

struct MyInfo {
    private let add = "private"
    let string1 = "string1"
    let string2 = "string2"
}

class ViewController: UIViewController {
    //MARK: Properties
    
    @IBOutlet var buttons: [UIButton]!
    
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
    
    var color = ChooseColor.blue
    var dataTitleLabel: String?
    var dataTextLabel: String?
    var imageView: UIImage?
    var indexImage: Int = 0
    var saveView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let count = buttons.count
        for i in 0..<count {
            buttons[i].layer.cornerRadius = buttons[i].bounds.width / 2
            buttons[i].tag = i
        }
        let info = MyInfo()
        print(info)
        
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
    
    func createView() {
        indexImage += 10
        let width = UIScreen.main.bounds.width / 3
        let tempView = UIView(frame: CGRect(x: view.center.x - (width / 2), y: CGFloat(indexImage), width: width, height: width))
        tempView.layer.cornerRadius = width / 2
        setShadowView(view: tempView)
        
        tempView.backgroundColor = color.value
        tempView.isUserInteractionEnabled = true
        tempView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:))))
        saveView = tempView
        self.view.addSubview(tempView)
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        
        recognizer.setTranslation(.zero, in: self.view)
    }
    
    
    @IBAction func tapSelectColor(_ sender: UIButton) {
        color = ChooseColor.all[sender.tag]
        for item in buttons {
            if item == sender {
                item.alpha = 1
                setShadowButton(button: item, shadowOpacity: 2)
            } else {
                setShadowButton(button: item, shadowOpacity: 0)
                item.alpha = 0.75
            }
        }
        
        createView()
    }
    
    func setShadowView(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 1
    }
    
    func setShadowButton(button: UIButton, shadowOpacity: Float) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = shadowOpacity //0.8
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 1
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
