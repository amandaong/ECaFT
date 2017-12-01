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

    override func viewDidLoad() { 
        super.viewDidLoad()
        
        let topHeight = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height)!
        let bottomHeight = tabBarController?.tabBar.frame.height != nil ? tabBarController?.tabBar.frame.height : 0
        let width = UIScreen.main.bounds.width
        let height = width * 1.29
        let y = (UIScreen.main.bounds.height - topHeight - bottomHeight!) / 2 - height / 2.0
        mapScrollView.frame = CGRect(x: 0, y: y, width: width, height: height)
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
