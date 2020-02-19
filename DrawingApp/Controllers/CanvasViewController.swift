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
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var strokeWidthSlider: UISlider!
    @IBOutlet weak var canvasTrailingC: NSLayoutConstraint!
    @IBOutlet weak var canvasLeadingC: NSLayoutConstraint!
    private var slideMenu = false
    
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
    
    @IBAction func slideMenu(_ sender: UIButton) {
        popMenu()
    }
    
    
    @IBAction func saveAss(_ sender: UIButton) {
    }
    
    
    @IBAction func close(_ sender: UIButton) {
        popMenu()
    }
    
    fileprivate func popMenu() {
        slideMenu.toggle()
        if slideMenu {
            canvasLeadingC.constant += 150
            canvasTrailingC.constant += 150
        } else {
            canvasLeadingC.constant = 0
            canvasTrailingC.constant = 0
        }
    }
    
    
}



extension CanvasViewController: HSBColorPickerDelegate {
    func HSBColorColorPickerTouched(sender: HSBColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizer.State) {
        colorButton.backgroundColor = color
        canvas.strokeColor = color
    }
}
