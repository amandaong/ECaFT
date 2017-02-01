//
//  MapViewController.swift
//  ECaFT
//
//  Created by Emily Lien on 2/1/17.
//  Copyright © 2017 loganallen. All rights reserved.
//

import UIKit
import ImageScrollView

class MapViewController: UIViewController {
    @IBOutlet weak var mapScrollView: ImageScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarHeight = tabBarItem.accessibilityFrame.height
        let backgroundHeight = view.frame.height - navBarHeight
        let backgroundImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: navBarHeight), size: CGSize(width: view.frame.width, height: backgroundHeight)))
        
        backgroundImageView.image = #imageLiteral(resourceName: "ecaftBackground")
        
        view.addSubview(backgroundImageView)
        view.sendSubview(toBack: backgroundImageView)

        mapScrollView.display(image: #imageLiteral(resourceName: "fair_maps"))
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Map"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
