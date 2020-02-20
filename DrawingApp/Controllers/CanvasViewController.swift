//
//  ViewController.swift
//  DrawingApp
//
//  Created by Oniel Rosario on 11/29/19.
//  Copyright © 2019 Oniel Rosario. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var colorPickerView: HSBColorPicker!
    @IBOutlet weak var strokeWidthSlider: UISlider!
    @IBOutlet weak var canvasTrailingC: NSLayoutConstraint!
    @IBOutlet weak var canvasLeadingC: NSLayoutConstraint!
    private var slideMenu = false
    
    lazy var canvas = Canvas()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeSlideMenuColor()
        setupUI()
    }
    
    fileprivate func setupUI() {
        strokeWidthSlider.thumbTintColor = .black
        strokeWidthSlider.tintColor = .black
        canvas.backgroundColor = .white
        canvasView.addSubview(canvas)
        canvas.frame = canvasView.frame
        colorPickerView.delegate = self
    }
    
    @IBAction func undo(_ sender: UIButton) {
        canvas.undo()
    }
    
    @IBAction func clear(_ sender: UIButton) {
        showAlert(title: nil, message: "So you want to erase all your progress?", style: .alert) { (Ok) in
            self.canvas.clear()
            self.strokeWidthSlider.thumbTintColor = .black
            self.strokeWidthSlider.tintColor = .black
            self.strokeWidthSlider.setValue(0.5, animated: true)
        }
    }
    
    @IBAction func setStrokeWidth(_ sender: UISlider) {
        canvas.setStrokeWidth(value: CGFloat(sender.value))
    }
    
    @IBAction func slideMenu(_ sender: UIButton) {
        popMenu()
    }
    
    @IBAction func saveAss(_ sender: UIButton) {
        let image = canvas.getImageFromCanvas()
        showAlert(title: nil, message: "Do you want to save your photo?", style: .alert) { _ in
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        popMenu()
    }
    
    @objc fileprivate func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
        
    }
    
    @IBAction func close(_ sender: UIButton) {
        popMenu()
    }
    
    @IBAction func taphandler(_ sender: UITapGestureRecognizer) {
        if slideMenu {
            popMenu()
        }
    }
    
    
    fileprivate func popMenu() {
        slideMenu.toggle()
        if slideMenu {
            UIView.animate(withDuration: 0.5) {
                self.canvasLeadingC.constant += 150
                self.canvasTrailingC.constant += 150
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.canvasLeadingC.constant = 0
                self.canvasTrailingC.constant = 0
            }
        }
    }
    
    fileprivate func customizeSlideMenuColor() {
        let colors = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0, green: 0.7535731196, blue: 0, alpha: 1)]
        let color = colors.randomElement()
        self.view.backgroundColor = color
    }
}



extension CanvasViewController: HSBColorPickerDelegate {
    func HSBColorColorPickerTouched(sender: HSBColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizer.State) {
        strokeWidthSlider.thumbTintColor = color
        strokeWidthSlider.tintColor = color
        canvas.strokeColor = color
    }
}
