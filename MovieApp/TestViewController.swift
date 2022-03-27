//
//  TestViewController.swift
//  MovieApp
//
//  Created by Jurica Mikulic on 22.03.2022..
//

import UIKit

class TestViewController: UIViewController {
    
    //movie details top view section
    private var movieDetailsTopView: UIView!
    private var userScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
//        UIFont.familyNames.forEach({ name in
//            for font_name in UIFont.fontNames(forFamilyName: name) {
//                print("\n\(font_name)")
//            }
//        })

        buildViews()
        
    }
    private func buildViews() {
    }
}


