//
//  ViewController.swift
//  Moosic
//
//  Created by Oliver Green on 28/10/2018.
//  Copyright © 2018 Oliver Green. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundCorners(cornerRadius: Double) {
        
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = true
    }
}

// ERRORS

/*
 * 
 *
 * 
 * 
 * 
 *
 */

class ViewController: UIViewController {

    @IBOutlet weak var btnScan: UIButton!
    @IBOutlet weak var btnAlbumCover: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var lblTapToIdentify: UILabel!
    @IBOutlet weak var lblListening: UILabel!
    @IBOutlet weak var lblTapToCancel: UILabel!
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var lblArtistName: UILabel!
    
    @IBOutlet weak var imgSuccess: UIImageView!
    
    @IBOutlet weak var viewScanResult: UIView!
    @IBOutlet weak var viewDock: UIView!

    
    let myOrange = UIColor(red: 255/255.0, green: 81/255.0, blue: 45/255.0, alpha: 1).cgColor
    let myPink = UIColor(red: 255/255.0, green: 29/255.0, blue: 119/255.0, alpha: 1).cgColor
    
    var albumCoverY : Float = 0.0
    var songNameY : Float = 0.0
    var artistNameY : Float = 0.0
    var dockY : Float = 0.0
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        btnAlbumCover.center.y += 30
        btnAlbumCover.alpha = 0.0
        
        btnBack.center.x -= 30
        btnBack.alpha = 0.0
        
        lblTapToIdentify.center.y += 30
        lblTapToIdentify.alpha = 0.0
        animateText(label: lblTapToIdentify, amount: 30, alpha: 1.0)
        
        lblListening.center.y += 30
        lblListening.alpha = 0.0
        
        lblTapToCancel.alpha = 0.0
        
        lblSongName.alpha = 0.0
        lblSongName.center.y += 30
        
        lblArtistName.alpha = 0.0
        lblArtistName.center.y += 30
        
        imgSuccess.center.y -= 180
        imgSuccess.alpha = 0.0
        
        viewDock.roundCorners(cornerRadius: 20.0)
        viewDock.center.y += 115
        
        albumCoverY = Float(btnAlbumCover.center.y)
        songNameY = Float(lblSongName.center.y)
        artistNameY = Float(lblArtistName.center.y)
        dockY = Float(viewDock.center.y)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.addPulse(btn: self.btnScan)
        }
        
        //perform(#selector(addPulse), with: nil, afterDelay: 1)
    }
    
    func addPulse(btn : UIButton) {
        
        let pulse = Pulsing(numberOfPulses: 1, radius: 180, position: btn.center)
        
        pulse.animationDuration = 1.6
        pulse.colors = [myOrange, myPink]
        
        self.view.layer.insertSublayer(pulse, below: btn.layer)
    }
    
    func animateText(label: UILabel, amount: CGFloat, alpha: CGFloat) {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: ({
            
            label.center.y -= amount
            label.alpha = alpha
            
        }), completion: { (finished: Bool) in
            
            
        })
    }
    
    func animate() {
        
        let imgSuccessY = imgSuccess.center.y
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: ({
            
            self.btnScan.center.y += 180
            self.btnScan.alpha = 0.0
            self.imgSuccess.alpha = 1.0
            self.imgSuccess.center.y += 180
            
        }), completion: { (finished: Bool) in
            
            UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: ({
                
                self.imgSuccess.center.y += 180
                self.imgSuccess.alpha = 0.0
                
            }), completion: { (finished: Bool) in
                
                self.btnScan.center.y -= 150
                self.imgSuccess.center.y = imgSuccessY
                self.animateScannedTrack()
            })
        })
    }
    
    func animateScannedTrack() {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: ({
            
            self.btnAlbumCover.center.y -= 30
            self.btnAlbumCover.alpha = 1.0
            
            self.lblSongName.center.y -= 30
            self.lblSongName.alpha = 1.0
            
            self.lblArtistName.center.y -= 30
            self.lblArtistName.alpha = 1.0
            
        }), completion: { (finished: Bool) in
            
            self.animateDock()
            self.animateBackBtn()
        })
    }
    
    // when the scan view resets its poition, then assign the new Y values to all objects
    
    func animateDock() {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: ({
            
            self.viewDock.center.y -= 115
            self.viewDock.alpha = 1.0
            
        }), completion: { (finished: Bool) in
            
            
        })
    }
    
    func animateBackBtn() {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: ({
            
            self.btnBack.center.x += 30
            self.btnBack.alpha = 1.0
            
        }), completion: { (finished: Bool) in
            
            
        })
    }
    
    func dismissView(thisView: UIView) {
        
        let viewX = self.view.frame.origin.x
        let viewY = self.view.frame.origin.y
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: ({
            
            thisView.center.y += 670
            //thisView.alpha = 0.0
            
            self.btnAlbumCover.alpha = 0.0
            self.lblSongName.alpha = 0.0
            self.lblArtistName.alpha = 0.0
            
            self.btnBack.center.x -= 30
            self.btnBack.alpha = 0.0
            
        }), completion: { (finished: Bool) in
            
            thisView.frame.origin.x = viewX
            thisView.frame.origin.y = viewY
            thisView.alpha = 1.0
            
            self.btnAlbumCover.center.y = CGFloat(self.albumCoverY)
            self.lblSongName.center.y = CGFloat(self.songNameY)
            self.lblArtistName.center.y = CGFloat(self.artistNameY)
            self.viewDock.center.y = CGFloat(self.dockY)
            
            self.restart()
        })
    }
    
    func restart() {
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: ({
            
            self.btnScan.center.y -= 30
            self.btnScan.alpha = 1.0
            
            self.animateText(label: self.lblTapToIdentify, amount: 30, alpha: 1.0)
            
        }), completion: { (finished: Bool) in
            
            
        })
    }
    
    @IBAction func tapScan(_ sender: UIButton) {
        
        animateText(label: lblTapToIdentify, amount: -30, alpha: 0.0)
        animateText(label: lblListening, amount: 30, alpha: 1.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.addPulse(btn: self.btnScan)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.addPulse(btn: self.btnScan)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.addPulse(btn: self.btnScan)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.addPulse(btn: self.btnScan)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.animateText(label: self.lblListening, amount: -30, alpha: 0.0)
                            self.animate()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func btnAlbumCover(_ sender: UIButton) {
        
        
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        
        dismissView(thisView: viewScanResult)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}

