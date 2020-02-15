//
//  ViewController.swift
//  DrawingApp
//
//  Created by Oniel Rosario on 11/29/19.
//  Copyright © 2019 Oniel Rosario. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var colorPickerView: HSBColorPicker!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var strokeWidthSlider: UISlider!
    
    lazy var canvas = Canvas()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        colorButton.layer.cornerRadius = colorButton.frame.height / 2
        colorButton.clipsToBounds = true
        canvas.backgroundColor = .white
        canvasView.addSubview(canvas)
        canvas.frame = canvasView.frame
        colorPickerView.delegate = self
    }
    
    @IBAction func undo(_ sender: UIButton) {
        canvas.undo()
    }
    @IBAction func clear(_ sender: UIButton) {
        canvas.clear()
        colorButton.backgroundColor = .black
        strokeWidthSlider.setValue(0.5, animated: true)
    }
    @IBAction func setStrokeWidth(_ sender: UISlider) {
        canvas.setStrokeWidth(value: CGFloat(sender.value))
    }
    
}



extension ViewController: HSBColorPickerDelegate {
    func HSBColorColorPickerTouched(sender: HSBColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizer.State) {
         colorButton.backgroundColor = color
        canvas.strokeColor = color
    }
}
