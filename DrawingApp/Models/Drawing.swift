//
//  Drawing.swift
//  DrawingApp
//
//  Created by Oniel Rosario on 11/30/19.
//  Copyright © 2019 Oniel Rosario. All rights reserved.
//

import UIKit

class Drawing: UIView {
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
