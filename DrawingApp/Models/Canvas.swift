//
//  Canvas.swift
//  DrawingApp
//
//  Created by Oniel Rosario on 11/29/19.
//  Copyright © 2019 Oniel Rosario. All rights reserved.
//

import UIKit


class Canvas: UIView {
    var strokeColor: UIColor?
    private var line = [Line]()
    private var lines = [Line]()
    private var strokeWidth: CGFloat?
    
    public func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    public func clear() {
        lines.removeAll()
        setNeedsDisplay()
        strokeColor = UIColor.black
        strokeWidth = 0.5
    }
    
    public func getImageFromCanvas() -> UIImage {
       let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { context in
            layer.render(in: context.cgContext )
        }
    }
    
    public func setStrokeWidth(value: CGFloat) {
        strokeWidth = value
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineCap(.butt)
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(line.width)
            context.setLineCap(.round)
            for (i,p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line(points: [], color: strokeColor ?? UIColor.black, width: strokeWidth ?? 1.0))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
}

