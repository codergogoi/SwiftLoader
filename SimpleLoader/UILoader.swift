//
//  UILoader.swift
//  Simple Loader
//
//  Created by MAC01 on 16/08/17.
//

import Foundation
import UIKit
import CoreGraphics

//REQUIRED LOADER IMAGE
// loader_glow or loader_normal

open class UILoader : UIView {
    
    var loaderView : UIView!
    let txtLoading: UILabel = {
       
        let lbl = UILabel(frame:CGRect(x: 0, y: 0, width: 200, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.text = "Loading..."
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        return lbl
    }()
    
    public override init(frame: CGRect) {
    
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.perform(#selector(self.initLoader), on: .main, with: nil, waitUntilDone: false)
        
     }
    
    public convenience init(frame: CGRect, title: String) {
        self.init(frame: frame)
        txtLoading.text = title
    }
    
    func dimBG(){
        
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                
                self.backgroundColor = self.appColor(0, g: 0, b: 0, a: 130)
                
            }, completion: nil)
            
        }
        
     }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func resizeIcons(xSize : CGFloat, ySize: CGFloat) -> CGAffineTransform{
        
        return CGAffineTransform(scaleX: xSize, y: ySize)
        
    }
    
    func setUpIconsSize(_ animDuratio : Float, view : UIView,size: CGFloat){
        
        UIView.animate(withDuration: TimeInterval(animDuratio), delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveLinear, animations: {
            
            view.transform = self.resizeIcons(xSize: size, ySize: size)
            
        }) { (finished) in
            
        }
        
    }
    
    @objc func initLoader(){
    
        self.dimBG()
        
        self.loaderView = UIView(frame: CGRect(x: Int(self.frame.width/2) - 40, y: Int(self.frame.height/2) - 40, width: 80, height: 80))
        self.loaderView.transform = resizeIcons(xSize: 0.01, ySize: 0.01)
        let imgView = UIImageView(frame: self.loaderView.bounds)
        
        let msgWidth = Int(self.frame.size.width - 200)
        self.txtLoading.frame = CGRect(x: 0, y: Int(self.loaderView.frame.origin.y + 40), width: msgWidth, height: 60)
        self.txtLoading.center = CGPoint(x: self.center.x, y: self.txtLoading.center.y)
        
        imgView.image = #imageLiteral(resourceName: "loader_glow")
        imgView.contentMode = .scaleAspectFit

        self.loaderView.addSubview(imgView)
        self.addSubview(self.loaderView)
        self.addSubview(txtLoading)
        DispatchQueue.main.async {
            self.txtLoading.blinkAnim()
        }
        DispatchQueue.main.async {
            self.setUpIconsSize(0.2, view: self.loaderView, size: 1)
        }
        
        self.showLoader()

     }
    
    
    
    func configureCircle(v : UIView){
        
         v.layer.cornerRadius = 15
        
    }
 
    func showLoader(){
        
        DispatchQueue.main.async {
            
            self.loaderView.rotate360Degrees()
        }
        
    }
    
     func appColor(_ r: Float, g: Float, b: Float, a: Float) -> UIColor {
        
        return UIColor.init(red: CGFloat(r/255), green:CGFloat(g/255), blue: CGFloat(b/255), alpha: CGFloat(a/255))
        
    }
    
    func finishLoading(){
        
        
        DispatchQueue.main.async {
            self.setUpIconsSize(0.1, view: self.loaderView, size: 0.2)
        }
        
        self.loaderView.layer.removeAllAnimations()
        self.removeFromSuperview()
        
    }

    
}


extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount=Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
    
    func blinkAnim(){
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2.0
        animation.repeatCount = Float.infinity
        self.layer.add(animation, forKey: nil)
 
    }
}

extension UIViewController{
    
    func showLoader(title: String){
        
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow{
                let loader = UILoader(frame: window.bounds, title: title)
                
                if window.subviews.contains(loader){
                    return
                }
                window.addSubview(loader)
                self.perform(#selector(self.hideLoader), with: nil, afterDelay: 60)
            }
        }
        
    }
    
    func showLoader(){
        
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow{
                let loader = UILoader(frame: window.bounds)
                
                if window.subviews.contains(loader){
                    return
                }
                window.addSubview(loader)
                self.perform(#selector(self.hideLoader), with: nil, afterDelay: 120)
            }
        }
        
        
    }
    
    @objc func hideLoader(){
        DispatchQueue.main.async {
            
            if let window = UIApplication.shared.keyWindow{
                let subViews = window.subviews
                for view in subViews{
                    if view is UILoader{
                        view.layer.removeAllAnimations()
                        view.removeFromSuperview()
                        return
                    }
                }
                
            }
            
        }
        
    }
    
}
