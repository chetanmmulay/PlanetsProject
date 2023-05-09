//
//  ViewController.swift
//  PlanetsProject
//
//  Created by Chetan on 09/05/2023.
//

import UIKit



class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    
    var planetResults: PlanetResults?
    
    var planets: [Planet] = []
    
    @IBOutlet weak var tableViewPlanets: UITableView!
    
    struct Planet: Codable {
        let name: String
        let climate: String
        let terrain: String
        let population: String
    }

    // Define the data model for the top-level results object
    struct PlanetResults: Codable {
        let results: [Planet]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlanetCalling()
        tableViewPlanets.dataSource = self
        tableViewPlanets.delegate = self
        
        // Do any additional setup after loading the view.
    }

    
    func PlanetCalling()
    {
        // Define the URL for the API endpoint
        let apiUrlString = "https://swapi.dev/api/planets/"

        // Define the data model for a planet
        

        // Create a URL object from the URL string
        guard let apiUrl = URL(string: apiUrlString) else {
            print("Invalid URL: \(apiUrlString)")
            return
        }

        // Create a URLSession object
        let session = URLSession.shared

        // Create a data task to perform the API request
        let task = session.dataTask(with: apiUrl) { data, response, error in
            // Handle any errors that occurred during the request
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }

            // Ensure that we have received a valid response from the server
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response from server")
                return
            }

            // Ensure that we have received valid data from the server
            guard let jsonData = data else {
                print("Invalid data received from server")
                return
            }

            // Decode the JSON data into a PlanetResults object
            let decoder = JSONDecoder()
            guard let planetResults = try? decoder.decode(PlanetResults.self, from: jsonData) else {
                print("Error decoding JSON data")
                //print("planetResults",PlanetResults)
                return
            }
            
//            if let jsonString = String(data: jsonData, encoding: .utf8) {
//                   print("",jsonString)
//               } else {
//                   print("Error converting data to string")
//               }
            
            self.planetResults = planetResults
                        DispatchQueue.main.async {
                            self.tableViewPlanets.reloadData()
                        }

            // Print the name of each planet to the console
            for planet in planetResults.results {
                
                print("Planet Name",planet.name)
                print("Planet Name",planet.population)
            }
        }

        // Start the data task to perform the API request
        task.resume()

}
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetResults?.results.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell:PlanetsTableViewCell = self.tableViewPlanets.dequeueReusableCell(withIdentifier: "PlanetsTableViewCell",for: indexPath) as! PlanetsTableViewCell
        
        if let planet = planetResults?.results[indexPath.row] {
        
            print("PlanetSName",planet.name)
            cell.lblPlanetName.text = planet.name
            cell.lblClimateAns.text = planet.climate
        }
        
        
        return cell
        
    }
    
}

