//
//  SearchTableView.swift
//  MapKitSearch
//
//  Created by youngjun goo on 2020/06/15.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable: UITableViewController {
    
    weak var handleMapSearchDelegate: MapSearchable?
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView?
    
    // 주소검색 Parsing
    func parseAddress(selectedItem:MKPlacemark) -> String {
        
        let firstSpace = (selectedItem.subThoroughfare != nil &&
                            selectedItem.thoroughfare != nil) ? " " : ""
        
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) &&
                    (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil &&
                            selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        
        return addressLine
    }
}

extension LocationSearchTable : UISearchResultsUpdating {
    // location 결과 업데이트
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}
// MARK: - TableView Delegate & DataSource
/// 주소 검색 TableView 설정
extension LocationSearchTable {
    // 검색한 결과개수에 따라 Cell 개수 반환
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    // UITableViewCell 생성 후 주소 정보 담음
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
    }
    // Cell 선택했을때 다시 첫번째 VC로 가면서 dropPinZoonIn 실행
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
}
