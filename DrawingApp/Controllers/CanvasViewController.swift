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
    @IBOutlet weak var changeBackgroundView: UIView!
    @IBOutlet weak var backgroundColorSelection: UIView!
    @IBOutlet weak var ColorStrokeSelection: UIView!
    @IBOutlet weak var backgroundPickerView: HSBColorPicker!
    private var colorSelection = false
    private var slideBackgroundColor = false
    private var slideMenu = false
    private var backgroundFill: UIColor?
    lazy var canvas = Canvas()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeSlideMenuColor()
        setupUI()
    }

    
    fileprivate func setupUI() {
        print(slideBackgroundColor)
        print(colorSelection)
        strokeWidthSlider.thumbTintColor = .black
        strokeWidthSlider.tintColor = .black
        canvas.backgroundColor = .white
        canvasView.addSubview(canvas)
        canvas.frame = canvasView.frame
        colorPickerView.delegate = self
        backgroundPickerView.delegate = self
    }
    
    @IBAction func undo(_ sender: UIButton) {
        canvas.undo()
    }
    
    @IBAction func clear(_ sender: UIButton) {
        showAlert(title: nil, message: "Do you want to erase all your  current progress?", style: .alert) { (Ok) in
            self.canvas.clear()
            self.strokeWidthSlider.thumbTintColor = .black
            self.strokeWidthSlider.tintColor = .black
            self.canvas.backgroundColor = .white
            self.backgroundColorSelection.backgroundColor = .white
            self.strokeWidthSlider.setValue(0.5, animated: true)
        }
    }
    
    @IBAction func changeBackgrounButton(_ sender: UIButton) {
        if colorSelection == false {
            popBackgroundColorChange()
        } else {
            popColorSelection()
            popBackgroundColorChange()
        }
    }
    
    
    @IBAction func selectBackgroundColor(_ sender: UIButton) {
        canvas.backgroundColor = backgroundColorSelection.backgroundColor
        popBackgroundColorChange()
    }
    
    @IBAction func colorSelection(_ sender: UIButton) {
        if slideBackgroundColor == false {
            popColorSelection()
        } else {
            popBackgroundColorChange()
            popColorSelection()
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
        showAlert(title: nil, message: "Do you want to save your photo?", style: .alert) { (ok) in
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            self.popMenu()
        }
    }
    
    @objc fileprivate func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription, actionTitle: "OK")
        } else {
            showAlert(title: "Saved!", message: nil, actionTitle: "OK")
        }
    }
    
    @IBAction func close(_ sender: UIButton) {
        popMenu()
    }
    
    @IBAction func taphandler(_ sender: UITapGestureRecognizer) {
        if slideMenu {
            popMenu()
        }
        if colorSelection {
            popColorSelection()
        }
    }
    
    fileprivate func popColorSelection() {
        colorSelection.toggle()
        if colorSelection {
            UIView.animate(withDuration: 0.3) {
                self.ColorStrokeSelection.center.y -= 400
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.ColorStrokeSelection.center.y += 400
            }
        }
    }
    
    fileprivate func popBackgroundColorChange() {
        slideBackgroundColor.toggle()
        if slideBackgroundColor {
            UIView.animate(withDuration: 0.3) {
                self.changeBackgroundView.center.x -= 350
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.changeBackgroundView.center.x += 350
            }
        }
    }
    
    
    fileprivate func popMenu() {
        if colorSelection  {
            popColorSelection()
        } else if slideBackgroundColor {
            popBackgroundColorChange()
        }
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
    
    //   working on this
    //    fileprivate func popView(toggle: inout Bool, customView: UIView, constant: CGFloat, optionalConstant: CGFloat? = 0, duration: Double) {
    //        toggle.toggle()
    //        if toggle {
    //            UIView.animate(withDuration: duration) {
    //
    //            }
    //        } else {
    //
    //        }
    //    }
    
    fileprivate func customizeSlideMenuColor() {
        let colors = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0, green: 0.7535731196, blue: 0, alpha: 1)]
        let color = colors.randomElement()
        self.view.backgroundColor = color
    }
}



extension CanvasViewController: HSBColorPickerDelegate {
    func HSBColorColorPickerTouched(sender: HSBColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizer.State) {
        if sender == backgroundPickerView {
            backgroundFill = color
            backgroundColorSelection.backgroundColor = color
        } else {
            strokeWidthSlider.tintColor = color
            strokeWidthSlider.thumbTintColor = color
            canvas.strokeColor = color
        }
    }
}
