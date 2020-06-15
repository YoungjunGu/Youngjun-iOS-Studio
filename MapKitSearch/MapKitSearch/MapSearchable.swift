//
//  MapSearchable.swift
//  MapKitSearch
//
//  Created by youngjun goo on 2020/06/15.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import Foundation
import MapKit

protocol MapSearchable: class {
    func dropPinZoomIn(placemark: MKPlacemark)
}
