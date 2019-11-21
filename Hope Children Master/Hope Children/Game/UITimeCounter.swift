//
//  UITimeCounter.swift
//  HOPE Children
//
//  Created by Antonyo Chavez Saucedo on 8/3/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation
import UIKit

open class UITimerProgress: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI(){
        //MARK: - Track Layer
        trackLayer = createCircleShapeLayer(strokeColor: trackStrokeColor, fillColor: trackFillColor)
        self.layer.addSublayer(trackLayer)
        
        //MARK: - Shape Layer
        shapeLayer = createCircleShapeLayer(strokeColor: progressColor, fillColor: .clear)
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        self.layer.addSublayer(shapeLayer)
        setupProgressLabel()
        
        textColor = UIColor.white
        font = UIFont(name: "HelveticaNeue-Bold", size: 24)!
        progressColor = UIColor.outlineStrokeColor
        trackStrokeColor = UIColor.trackStrokeColor
        trackFillColor = UIColor.backgroundColor
        progressLayerWidth = 20
        trackLayerWidth = 20
        //progressBar.pulseLayerWidth = 1.3
        shapeLayer.strokeEnd = 0
    }
    
    //MARK: - PROPERTIES
    /// Text Color of the progress label
    open var textColor: UIColor = UIColor.white {
        didSet {
            progressLabel.textColor = textColor
        }
    }
    /// Set the font for the progress label
    open var font: UIFont = UIFont.boldSystemFont(ofSize: 32) {
        didSet {
            progressLabel.font = font
        }
    }
    /// Set the text alignment for the progress label
    open var textAlignment: NSTextAlignment = NSTextAlignment.center {
        didSet {
            progressLabel.textAlignment = textAlignment
        }
    }
    /// Set stroke color for the track layer
    open var trackStrokeColor: UIColor = UIColor.trackStrokeColor {
        didSet {
            trackLayer.strokeColor = trackStrokeColor.cgColor
        }
    }
    /// Set fill color for the track layer
    open var trackFillColor: UIColor = UIColor.backgroundColor {
        didSet {
            trackLayer.fillColor = trackFillColor.cgColor
        }
    }
    /// Set the progress color
    open var progressColor: UIColor = UIColor.outlineStrokeColor {
        didSet {
            shapeLayer.strokeColor = progressColor.cgColor
        }
    }
    /// Set the width of the progress layer
    open var progressLayerWidth: CGFloat = 20 {
        didSet {
            shapeLayer.lineWidth = progressLayerWidth
        }
    }
    /// Set the width of the track layer
    open var trackLayerWidth: CGFloat = 20 {
        didSet {
            trackLayer.lineWidth = trackLayerWidth
        }
    }
    
    
    private let size = CGFloat(30)
    var timer = Timer()
    var seconds = 30
    let seconds_default = 30
    var isPaused = false
    
    public var shapeLayer: CAShapeLayer!
    public var trackLayer: CAShapeLayer!
    public var animation: CABasicAnimation!
    
    public lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor.white
        return label
    }()

    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: size, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 20
        layer.fillColor = fillColor.cgColor
        layer.lineCap = CAShapeLayerLineCap.round
        layer.position = self.center
        return layer
    }
    
    private func setupProgressLabel() {
        self.addSubview(progressLabel)
        progressLabel.frame = CGRect(x: 0, y: 0, width: size, height: size)
        progressLabel.center = self.center
    }
    
    public func run() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func reset(){
        isPaused = false
        timer.invalidate()
        seconds = seconds_default
        progressLabel.text = "\(self.seconds)"
    }
    
    func play(){
        self.timer.invalidate()
        self.run()
        isPaused = false
        shapeLayer.strokeEnd = 0
    }
    
    func pause(){
        timer.invalidate()
        isPaused = true
    }
    
    @objc func updateTimer() {
        if seconds <= 0 {
            timer.invalidate()
            gameOver()
        }else{
            seconds -= 1
            let percentage = CGFloat(seconds) / CGFloat(seconds_default)
            progressLabel.text = "\(self.seconds)"
            shapeLayer.strokeEnd = percentage
        }
    }
    func gameOver(){
        NotificationCenter.default.post(name: .GameOver, object: nil, userInfo: [:] )
    }
    
}
