//
//  POIDetail.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-17.
//

import SwiftUI

struct POIDetail: View {
  var poi: PointOfInterest
  var body: some View {
    Text(poi.name)
  }
}

#Preview {
  POIDetail(poi: PointOfInterest.sampleData)
}
