//
//  TeachSensoring.swift
//  Teachify
//
//  Created by Christian Pöhlmann on 21.06.18.
//  Copyright © 2018 Christian Pfeiffer. All rights reserved.
//

import UIKit
import CoreMotion

class TeachSensoring: NSObject {
    
    var motion=CMMotionManager()
    var timer=Timer()
    var timer2=Timer()
    var aGame = NSObject()
    let aYMinnullPosition=0.4
    let aYMaxnullPosition=0.5
    var aX=0
    var aY=0
    var aNullposition=0.1
    var aReset=false
    
    override init() {
        super.init()
    }
    init(game :NSObject) {
        aGame=game
    }
    func setGame(game: NSObject){
        aGame=game
    }
    func startDeviceMotion() {
        if motion.isDeviceMotionAvailable {
            self.motion.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motion.showsDeviceMovementDisplay = true
            self.motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            
            self.timer = Timer(fire: Date(), interval: (1.0/60.0), repeats: true,
                               block: { (timer) in
                                if let data = self.motion.deviceMotion {
                                    let x = data.attitude.pitch
                                    let y = data.attitude.roll
                                    let z = data.attitude.yaw
                                    /*print("\tx: \(x)")
                                     print("\ty: \(y)")
                                     print("\tz: \(z)")*/
                                    if !self.aReset {
                                        self.setNullposition(y: y)}
                                    self.createFlight(x: x, y: y)
                                }
            })
            RunLoop.current.add(self.timer, forMode: .defaultRunLoopMode)
        }
    }
    func setNullposition(y:Double){
        aReset=true
        aNullposition = y
    }
    func createFlight(x:Double, y:Double){
        let mGame = self.aGame as! TeachGameScene
        let my = (aNullposition - y) * 100 - 0
        //print("x\(x) aN \(aNullposition) y\(y): MY\(my)")
        let mx = x * 100 * -1
        mGame.setBirdposition(xImpise: mx, yImpulse: my)
    }
    func stopDeviceMotion(){
        self.timer.invalidate()
        aReset=false
        print("----------->SOPP SENSOR <----------------")
    }
    func startBackgroound() {
        if motion.isDeviceMotionAvailable {
            self.motion.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motion.showsDeviceMovementDisplay = true
            self.motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            self.timer2 = Timer(fire: Date(), interval: (1.0/60.0), repeats: true,
                                block: { (timer) in
                                    if let data = self.motion.deviceMotion {
                                        let x = data.attitude.pitch
                                        let y = data.attitude.roll
                                        if !self.aReset {
                                            self.setNullposition(y: y)}
                                        self.moveBackground(x: x, y: y)
                                    }
            })
            RunLoop.current.add(self.timer2, forMode: .defaultRunLoopMode)
        }
    }
    func moveBackground(x: Double, y: Double){
        let mGame = self.aGame as! TeachGameScene
        mGame.moveBackground(x: x, y: y)
        let my = (aNullposition - y) * 40
        mGame.moveBackground(x: x*40, y: my)
    }
    func stopBackgroundMotion(){
        self.timer2.invalidate()
        aReset=false
        print("----------->SOPP SENSOR Background<----------------")
    }
}

