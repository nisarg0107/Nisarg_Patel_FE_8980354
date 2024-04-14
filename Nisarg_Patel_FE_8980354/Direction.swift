//
//  Direction.swift
//  Nisarg_Patel_FE_8980354
//
//  Created by user238292 on 4/13/24.
//

import UIKit

class Direction:UITableViewCell {
    
    @IBOutlet weak var lblCitynme: UILabel!
    @IBOutlet weak var lblTravel: UILabel!
    @IBOutlet weak var lblModeofTravel: UILabel!
    @IBOutlet weak var lblEndPoint: UILabel!
    @IBOutlet weak var lblStartPoint: UILabel!
    
    func setup(data: DirectionsData) {
        lblCitynme.text = data.cityName ?? ""
        lblTravel.text = data.distance ?? ""
        lblModeofTravel.text = data.method
        lblEndPoint.text = data.endPoint ?? ""
        lblStartPoint.text = data.startPoint ?? ""
    }
}
