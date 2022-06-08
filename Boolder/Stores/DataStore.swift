//
//  DataStore.swift
//  Boolder
//
//  Created by Nicolas Mondollot on 24/03/2020.
//  Copyright © 2020 Nicolas Mondollot. All rights reserved.
//


import MapKit
import CoreData

class DataStore : ObservableObject {
    var geoStore = GeoStore(areaId: 1)
    var topoStore = TopoStore(areaId: 1)
    
    var areaId: Int = 1 {
        didSet {
            if oldValue != areaId {
                self.geoStore = GeoStore(areaId: areaId)
                self.topoStore = TopoStore(areaId: areaId)
                self.refresh()
            }
        }
    }
    
    // custom wrapper instead of @Published, to be able to refresh data store everytime filters change
    var filters = Filters() {
        willSet { objectWillChange.send() }
        didSet { self.refresh() }
    }

    @Published var overlays = [MKOverlay]()
    @Published var problems = [Problem]()
    @Published var pois = [Poi]()
    @Published var sortedProblems = [Problem]()
    
    let areas = [
        Area(id: 1,  name: "Rocher Canon",                      problemsCount: 435, latitude: 48.46287503218,      longitude: 2.66519039601,       published: true),
        Area(id: 2,  name: "Cul de Chien",                      problemsCount: 244, latitude: 48.376182,           longitude: 2.521896,            published: true),
        Area(id: 4,  name: "Cuvier",                            problemsCount: 529, latitude: 48.44647203423,      longitude: 2.63799547881,       published: true),
        Area(id: 5,  name: "Franchard Isatis",                  problemsCount: 578, latitude: 48.41019265965,      longitude: 2.59939312398,       published: true),
        Area(id: 6,  name: "Cuvier Est",                        problemsCount: 123, latitude: 48.44577104156,      longitude: 2.64364420831,       published: true),
        Area(id: 7,  name: "Apremont",                          problemsCount: 385, latitude: 48.43522293535,      longitude: 2.62890814662,       published: true),
        Area(id: 8,  name: "Rocher Fin",                        problemsCount: 242, latitude: 48.37663469685,      longitude: 2.53519176364,       published: true),
        Area(id: 9,  name: "Éléphant",                          problemsCount: 270, latitude: 48.29379752069,      longitude: 2.59503185213,       published: true),
        Area(id: 10, name: "95.2",                              problemsCount: 332, latitude: 48.38611195852,      longitude: 2.52903341711,       published: true),
        Area(id: 11, name: "Franchard Cuisinière",              problemsCount: 459, latitude: 48.41008939449,      longitude: 2.6108837074,        published: true),
        Area(id: 12, name: "Roche aux Sabots",                  problemsCount: 237, latitude: 48.37518088148,      longitude: 2.51333176553,       published: true),
        Area(id: 13, name: "Canche aux Merciers",               problemsCount: 333, latitude: 48.39145906515,      longitude: 2.54881202638,       published: true),
        Area(id: 14, name: "Rocher du Potala",                  problemsCount: 328, latitude: 48.36755125228,      longitude: 2.53265439928,       published: true),
        Area(id: 15, name: "Gorge aux Châts",                   problemsCount: 214, latitude: 48.39888031517,      longitude: 2.51883566111,       published: true),
        Area(id: 16, name: "91.1",                              problemsCount: 262, latitude: 48.37634250895,      longitude: 2.51717805326,       published: true),
        Area(id: 17, name: "Rocher Guichot",                    problemsCount: 132, latitude: 48.36388748191,      longitude: 2.52628415555,       published: true),
        Area(id: 18, name: "Diplodocus",                        problemsCount: 107, latitude: 48.37110784942,      longitude: 2.53313183248,       published: true),
        Area(id: 19, name: "Rocher des Potets",                 problemsCount: 84,  latitude: 48.38323333672,      longitude: 2.52603470743,       published: true),
        Area(id: 20, name: "Apremont Ouest",                    problemsCount: 201, latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 21, name: "Bois Rond",                         problemsCount: 236, latitude: 48.39009651204,      longitude: 2.56303578481,       published: true),
        Area(id: 22, name: "Rocher des Souris",                 problemsCount: 71,  latitude: 48.38696696334,      longitude: 2.52318083704,       published: true),
        Area(id: 23, name: "Buthiers Piscine",                  problemsCount: 295, latitude: 48.29321041383,      longitude: 2.4363550517,        published: true),
        Area(id: 24, name: "Rocher Saint-Germain",              problemsCount: 187, latitude: 48.43963959475,      longitude: 2.68572270602,       published: true),
        Area(id: 25, name: "Roche aux Oiseaux",                 problemsCount: 164, latitude: 48.37782479619,      longitude: 2.50810145259,       published: true),
        Area(id: 26, name: "Drei Zinnen",                       problemsCount: 235, latitude: 48.39408432091,      longitude: 2.5576257652,        published: true),
        Area(id: 27, name: "Jean des Vignes",                   problemsCount: 71,  latitude: 48.38402069871,      longitude: 2.52459167898,       published: true),
        Area(id: 28, name: "La Ségognole",                      problemsCount: 147, latitude: 48.38038216187,      longitude: 2.50413246386,       published: true),
        Area(id: 29, name: "Beauvais Nainville",                problemsCount: 379, latitude: 48.50298942153,      longitude: 2.4803325507,        published: true),
        Area(id: 30, name: "J.A. Martin",                       problemsCount: 434, latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 31, name: "Franchard Cuisinière Crêtes Sud",   problemsCount: 77,  latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 32, name: "Petit Bois",                        problemsCount: 240, latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 33, name: "Rocher des Demoiselles",            problemsCount: 236, latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 34, name: "Franchard Sablons",                 problemsCount: 162, latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 35, name: "Rocher de la Cathédrale",           problemsCount: 70,  latitude: 48.36369858932,      longitude: 2.53304599643,       published: true),
        Area(id: 36, name: "Franchard Hautes Plaines",          problemsCount: 178, latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 37, name: "Franchard Meyer",                   problemsCount: 109, latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 38, name: "Franchard Sablons Carriers",        problemsCount: 45,  latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 39, name: "Franchard Raymond",                 problemsCount: 90,  latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 40, name: "Cuvier Merveille",                  problemsCount: 43,  latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 41, name: "Maunoury",                          problemsCount: 275, latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 42, name: "Dame Jouanne",                      problemsCount: 509, latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 43, name: "Cuvier Ouest",                      problemsCount: 132, latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 44, name: "Cuvier Nord (+Est)",                problemsCount: 223, latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 45, name: "Cuvier Bellevue",                   problemsCount: 211, latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 46, name: "Apremont Bizons",                   problemsCount: 349, latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 47, name: "Rocher Canon Ouest",                problemsCount: 89,  latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 48, name: "Apremont Butte aux Dames",          problemsCount: 300, latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 49, name: "Apremont Solitude",                 problemsCount: 105, latitude: 0,                   longitude: 0,                   published: false),
        Area(id: 50, name: "Rocher d'Avon",                     problemsCount: 0,   latitude: 0,                   longitude: 0,                   published: false)
    ]

    init() {
        refresh()
    }
    
    func area(withId id: Int) -> Area? {
        areas.first(where:  { area in
            area.id == id
        })
    }
    
    func refresh() {
        overlays = geoStore.boulderOverlays
        
        if let circuitOverlay = circuitOverlay() {
            overlays.append(circuitOverlay)
        }
        
        overlays.append(contentsOf: geoStore.poiRouteOverlays)
        
        problems = filteredProblems()
        setBelongsToCircuit()
        createSortedProblems()
        
        pois = geoStore.pois
    }
    
    private func filteredProblems() -> [Problem] {
        return geoStore.problems.filter { problem in
            if(filters.circuitId == nil || problem.circuitId == filters.circuitId) {
                if isGradeOk(problem)  {
                    if isSteepnessOk(problem) {
                        if filters.photoMissing == false || (problem.mainTopoPhoto == nil) {
                            if filters.lineMissing == false || (problem.mainTopoPhoto != nil && problem.lineFirstPoint() == nil) {
                                if isHeightOk(problem) {
                                    if filters.favorite == false || problem.isFavorite()  {
                                        if filters.ticked == false || problem.isTicked()  {
                                            if filters.risky == true || !problem.isRisky()  {
                                                if isMapMakerModeOk(problem) {
                                                    return true
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return false
        }
    }
    
    private func isMapMakerModeOk(_ problem: Problem) -> Bool {
        filters.mapMakerModeEnabled == false || !problem.isFavorite()
    }
    
    private func isHeightOk(_ problem: Problem) -> Bool {
        if filters.heightMax == Int.max { return true }
        
        if let height = problem.height {
            return (height <= filters.heightMax)
        }
        else {
            return false
        }
    }
    
    private func isGradeOk(_ problem: Problem) -> Bool {
        if let range = filters.gradeRange {
            return range.contains(problem.grade)
        }
        else {
            return true
        }
    }
    
    private func isSteepnessOk(_ problem: Problem) -> Bool {
        if filters.steepness.isEmpty {
            return true
        }
        
        return filters.steepness.contains(problem.steepness)
    }
    
    private func circuitOverlay() -> CircuitOverlay? {
        if let circuitId = filters.circuitId {
            if let circuit = circuit(withId: circuitId) {
                return circuit.overlay
            }
        }
        
        return nil
    }
    
    func circuit(withId id: Int) -> Circuit? {
        geoStore.circuits.first { $0.id == id }
    }
    
    private func createSortedProblems() {
        sortedProblems = problems
        sortedProblems.sort { (lhs, rhs) -> Bool in
            if lhs.circuitNumber == rhs.circuitNumber {
                return lhs.grade < rhs.grade
            }
            else {
                return lhs.circuitNumberComparableValue() < rhs.circuitNumberComparableValue()
            }
        }
    }
    
    private func setBelongsToCircuit() {
        for problem in problems {
            problem.belongsToCircuit = (filters.circuitId != nil && filters.circuitId == problem.circuitId)
        }
    }
    
    func favorites() -> [Favorite] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.sortDescriptors = []
        
        do {
            return try context.fetch(request)
        } catch {
            fatalError("Failed to fetch favorites: \(error)")
        }
    }
    
    func ticks() -> [Tick] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request: NSFetchRequest<Tick> = Tick.fetchRequest()
        request.sortDescriptors = []
        
        do {
            return try context.fetch(request)
        } catch {
            fatalError("Failed to fetch ticks: \(error)")
        }
    }
}
