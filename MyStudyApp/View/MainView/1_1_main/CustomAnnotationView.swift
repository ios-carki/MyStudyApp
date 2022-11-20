//
//  CustomAnnotationView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/20.
//

import UIKit
import MapKit

final class CustomAnnotationView: MKAnnotationView {
    
    static let identifier = "CustomAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 40, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)

        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .clear
    }
}

final class CustomAnnotation: NSObject, MKAnnotation {
    let sesacImage: Int?
    let coordinate: CLLocationCoordinate2D
    
    init(sesacImage: Int?, coordinate: CLLocationCoordinate2D) {
        self.sesacImage = sesacImage
        self.coordinate = coordinate
        
        super.init()
    }
}
