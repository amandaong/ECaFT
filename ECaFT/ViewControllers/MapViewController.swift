//
//  MapViewController.swift
//  ECaFT
//
//  Created by Emily Lien on 2/1/17.
//  Copyright © 2017 ECAFT. All rights reserved.
//

import UIKit
import ImageScrollView

class MapViewController: UIViewController {
    @IBOutlet weak var mapScrollView: ImageScrollView!
    @IBOutlet weak var mapImageView: UIImageView!
    private var rotateBtnItem: UIBarButtonItem = UIBarButtonItem()
    private var totalRot: CGFloat = 0 // Total rotation angle of scroll view
    private var viewHeight: CGFloat = 0 // Height of view (not including status bar, top & bottom nav bar)
    private var width: CGFloat = 0 // Width of scroll view frame
    private var height: CGFloat = 0 // Height of scroll view frame
    
    override func viewDidLoad() { 
        super.viewDidLoad()
        self.title = "Map"
        self.edgesForExtendedLayout = [] // View controller fits btwn top nav bar & bottom tab bar
        self.viewHeight = getViewHeight()
        self.height = viewHeight
        self.width = UIScreen.main.bounds.width
        
        makeRotateBtn()
        makeMapScrollView()
        makeScrollViewTapGesRecognizer()
    }

    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func rotateScrollView() {
        let rotation = CGFloat.pi / 2.0
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let sself = self else { return }
            sself.mapScrollView.transform = sself.mapScrollView.transform.rotated(by: rotation)
        }
        totalRot = (totalRot < 2.0 * .pi) ? totalRot + rotation : 0
        toggleFrame(given: totalRot)
    }
    
    private func toggleFrame(given totalRotation: CGFloat) {
        if(!isVertical(given: totalRotation)) {
            mapScrollView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            mapScrollView.center = CGPoint(x: UIScreen.main.bounds.width/2.0, y: viewHeight/2.0)
        } else {
            mapScrollView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            mapScrollView.center = CGPoint(x: UIScreen.main.bounds.width/2.0, y: viewHeight/2.0)
        }
    }
    
    private func isVertical(given rotation: CGFloat) -> Bool {
        return (rotation.truncatingRemainder(dividingBy: 180.0) == 0 ) ? true : false
    }
    
    private func makeMapScrollView() {
        mapScrollView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        mapScrollView.center = CGPoint(x: UIScreen.main.bounds.width/2.0, y: viewHeight/2.0)
        mapScrollView.display(image: #imageLiteral(resourceName: "ecaftmap"))
    }
    
    private func getViewHeight() -> CGFloat {
        let topHeight = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height)!
        let bottomHeight = (tabBarController?.tabBar.frame.height != nil) ? tabBarController?.tabBar.frame.height : 0
        let viewHeight = UIScreen.main.bounds.height - topHeight - bottomHeight!
        return viewHeight
    }
    
    private func makeRotateBtn() {
        let rotateBtn = UIButton(type: .custom)
        rotateBtn.setImage(UIImage(named: "rotateButton"), for: .normal)
        rotateBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rotateBtn.addTarget(self, action: #selector(rotateScrollView), for: .touchUpInside)
        rotateBtnItem = UIBarButtonItem(customView: rotateBtn)
        self.navigationItem.rightBarButtonItem = rotateBtnItem
    }
    
    private func makeScrollViewTapGesRecognizer() {
        let scrollViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rotateScrollView))
        scrollViewTapGestureRecognizer.numberOfTapsRequired = 1
        scrollViewTapGestureRecognizer.isEnabled = true
        scrollViewTapGestureRecognizer.cancelsTouchesInView = false
        mapScrollView.addGestureRecognizer(scrollViewTapGestureRecognizer)
    }
}
