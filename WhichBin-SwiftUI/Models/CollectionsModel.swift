////
////  CollectionsModel.swift
////  WhichBin-SwiftUI
////
////  Created by Shane Whitehead on 13/1/2024.
////
//
//import Foundation
//import CoreLocation
//import Contacts
//import SwiftUI
//
///*
// The initial intention is to make use of the users current location and then load
// the collection details based on it.
// 
// Because this is a limited test concept, the actual location is only relevent to the
// local municipality which we support, otherwise we need to have several other lookup
// mechanisms to find the municipality as well.
// 
// Future improvements would include the ability to define locations manually and store
// them.  This would reduce some of the load as we don't need to look for the users
// current location
// 
// The core concept would be to:
// * Find user location
// * Find the user's municipality
// * Find the user's collection details
// 
// The "problem" - there really isn't a easy to use API to do this from.  In the sample
// workflow, the collection details are loaded from known URL/data set which was manually
// sourced.
// */
//
//// Manage:
//// * aquiring the location
//// * reverse geo lookup for address
//// * load the appropriate data set
//
//protocol CollectionsModel: ObservableObject {
//    // May support setting in the future
//    var currentLocation: CLLocationCoordinate2D? { get }
//    var currentLocationAddress: String? { get }
//    
//    var hasErrorOccured: Bool { get set }
//    // var hasErrorOccured: Binding<Bool> { get }
//    var lastError: Error? { get }
//    
//    // The (main) reason this isn't async, is that teh CLLocationManager
//    // still relies on the delegate and we need to perform some additional
//    // computation tasks determine if the range is appropriate
//    func aquireCurrentLocation()
//}
//
//class DefaultCollectionsModel: NSObject, CollectionsModel, CLLocationManagerDelegate {
//    @Published var currentLocation: CLLocationCoordinate2D?
//    @Published var currentLocationAddress: String?
//    
//    @Published var hasErrorOccured: Bool = false {
//        didSet { objectWillChange.send() }
//    }
//    var lastError: Error?
//    
//    private var postalAddressFormatter: AnyStreetAddressFormatter<CNPostalAddress>
//    
//    private let locationManager = CLLocationManager()
//    private var lastKnownLocation: CLLocation?
//    
//    convenience override init() {
//        self.init(postalAddressFormatter: CNPostalAddressFormatter())
//    }
//    
//    init<Formatter: StreetAddressFormatter>(postalAddressFormatter: Formatter) where Formatter.Address == CNPostalAddress {
//        self.postalAddressFormatter = AnyStreetAddressFormatter<CNPostalAddress>(postalAddressFormatter)
//        super.init()
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//    }
//    
//    func aquireCurrentLocation() {
//        locationManager.startUpdatingLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let newLocation = locations.last else { return }
//        guard let lastKnownLocation else {
//            lastKnownLocation = newLocation
//            return
//        }
//        let distance = lastKnownLocation.distance(from: newLocation)
//        // Is the accuracy within 10 meters
//        guard distance <= 10 else { return }
//        
//        Task {
//            await MainActor.run {
//                currentLocation = newLocation.coordinate
//            }
//            let placeMarkers = try await CLGeocoder().reverseGeocodeLocation(newLocation)
//            guard let placeMarker = placeMarkers.first, let address = placeMarker.postalAddress else {
//                return
//            }
//            await MainActor.run {
//                currentLocationAddress = postalAddressFormatter.string(from: address)
//            }
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        lastError = error
//        hasErrorOccured.toggle()
//    }
//}
//
//class StaticCollectionsModel: CollectionsModel {
//    @Published var currentLocation: CLLocationCoordinate2D? 
//    @Published var currentLocationAddress: String?
//
//    @Published var hasErrorOccured: Bool = false
//    var lastError: Error?
//    
//    private var staticLocation: CLLocationCoordinate2D
//    private var postalAddressFormatter: AnyStreetAddressFormatter<CNPostalAddress>
//    
//    convenience init(location: CLLocationCoordinate2D) {
//        self.init(location: location, postalAddressFormatter: CNPostalAddressFormatter())
//    }
//    
//    init<Formatter: StreetAddressFormatter>(location: CLLocationCoordinate2D, postalAddressFormatter: Formatter) where Formatter.Address == CNPostalAddress {
//        // We don't set the `currentLocation` here, as the contract
//        // requires the caller to call `aquireCurrentLocation` when
//        // they are ready
//        staticLocation = location
//        self.postalAddressFormatter = AnyStreetAddressFormatter<CNPostalAddress>(postalAddressFormatter)
//    }
//    
//    func aquireCurrentLocation() {
//        Task {
//            print("Did set location")
//            await MainActor.run {
//                currentLocation = staticLocation
//            }
//            let placeMarkers = try await CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: staticLocation.latitude, longitude: staticLocation.longitude))
//            guard let placeMarker = placeMarkers.first, let address = placeMarker.postalAddress else {
//                return
//            }
//            print("Did set Address")
//            await MainActor.run {
//                currentLocationAddress = postalAddressFormatter.string(from: address)
//            }
//        }
//    }
//}
