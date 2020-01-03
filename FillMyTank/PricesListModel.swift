//
//  PricesListModel.swift
//  FillMyTank
//
//  Created by user161495 on 12/30/19.
//  Copyright © 2019 MarouenAbdi. All rights reserved.


class PricesListModel {
    
    var Name : String?
    var Diesel: String?
    var Gasoline: String?
    var GPL: String?
    var Image: String?
      
      init(Name: String?, Diesel: String?, Gasoline: String?, GPL : String?, Image: String?){
          self.Name = Name
          self.Diesel = Diesel
          self.Gasoline = Gasoline
          self.GPL = GPL
          self.Image = Image
}
}
