//
//  DetailViewController.swift
//  SwiftUIWidget
//
//  Created by 이중엽 on 4/29/24.
//

import UIKit
import SwiftUI

struct LegacyViewController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        DetailViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class DetailViewController: UIViewController {
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        view.addSubview(button)
        
        button.backgroundColor = .blue
        button.setTitle("클릭", for: .normal)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    @objc func buttonClicked() {
        
        let vc = UIHostingController(rootView: ContentDetailView())
        
        present(vc, animated: true)
    }
}
