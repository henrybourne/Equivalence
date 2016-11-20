//
//  UnitView.swift
//  Equivalence
//
//  Created by Henry Bourne on 19/03/2016.
//  Copyright © 2016 Henry Bourne. All rights reserved.
//

import UIKit

@IBDesignable
class UnitView: UIControl {
    
    @IBOutlet weak var beforeLabel: UILabel!
    @IBOutlet weak var afterLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        view.isUserInteractionEnabled = false
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "UnitView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    override func draw(_ rect: CGRect) {
        let roundedRect: UIBezierPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: 4)
        UIColor.white.setFill()
        roundedRect.fill()
    }
    

    
}
