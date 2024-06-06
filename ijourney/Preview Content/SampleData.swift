//
//  SampleData.swift
//  ijourney
//
//  Created by LamboZhuang on 2024-05-21.
//

import Foundation

extension City {
  static let sampleData = [
    City(name: "Rome", countryCode: "IT", countryName: "Italy", description: "Rome, known as “The Eternal City,” is a captivating blend of ancient history and vibrant modernity. Walking through Rome is like stepping back in time, with its cobblestone streets leading to awe-inspiring landmarks such as the Colosseum, where gladiators once battled, and the Roman Forum, the heart of ancient Roman public life. The city is also home to the majestic Pantheon, with its magnificent dome, and the Vatican City, an independent city-state that houses St. Peter’s Basilica and the Sistine Chapel, adorned with Michelangelo’s masterpieces. Rome’s rich history is complemented by its bustling piazzas, like Piazza Navona and Campo de’ Fiori, where you can enjoy a lively atmosphere and delicious Italian cuisine. Whether exploring its countless historical sites, savoring authentic gelato by the Trevi Fountain, or wandering through charming neighborhoods like Trastevere, Rome offers an unforgettable journey through time and culture.", latitude: 41.893055555, longitude: 12.482777777),
    City(name: "Paris", countryCode: "FR", countryName: "France", description: "Paris, often referred to as “The City of Light,” is renowned for its romantic ambiance, rich history, and iconic landmarks. Nestled along the banks of the Seine River, Paris captivates visitors with its stunning architecture, from the majestic Eiffel Tower and the Gothic splendor of Notre-Dame Cathedral to the opulent halls of the Palace of Versailles. The city is a cultural treasure trove, housing world-class museums like the Louvre, home to the Mona Lisa, and the Musée d’Orsay, showcasing Impressionist masterpieces. Paris is also a culinary paradise, offering an array of exquisite dining experiences, from charming bistros to Michelin-starred restaurants. With its chic boutiques, vibrant cafés, and picturesque neighborhoods like Montmartre and Le Marais, Paris effortlessly combines old-world charm with modern elegance, making it a timeless destination for travelers.", latitude: 48.856666666, longitude: 2.352222222),
    City(name: "Stockholm", countryCode: "SE", countryName: "Sweden", description: "Stockholm, the capital of Sweden, is an enchanting city spread across 14 islands connected by over 50 bridges on the Baltic Sea. Known as the “Venice of the North,” Stockholm blends medieval history with modern design and technology. The heart of the city, Gamla Stan (Old Town), features cobblestone streets, colorful 17th-century buildings, and the majestic Royal Palace. The city is rich in culture, housing the Vasa Museum with its preserved 17th-century warship and the ABBA Museum. Stockholm’s archipelago offers stunning natural beauty, while modern districts like Södermalm and Östermalm boast trendy boutiques, chic cafes, and vibrant nightlife. The culinary scene is thriving, with traditional Swedish fare and innovative Michelin-starred restaurants. With its historic charm, natural splendor, and modern sophistication, Stockholm provides a unique and captivating experience for every visitor.", latitude: 59.329444444, longitude: 18.068611111),
    City(name: "Oslo", countryCode: "NO", countryName: "Norway", description: "Oslo, the capital of Norway, beautifully combines natural beauty with modern urban life, nestled between the Oslofjord and lush forests. The city boasts a stunning waterfront with the contemporary Opera House and cultural treasures like the Viking Ship Museum and the Munch Museum, home to “The Scream.” Visitors can enjoy the tranquil Vigeland Park, the world’s largest sculpture park by a single artist, or explore the vibrant culinary scene, featuring traditional Norwegian dishes and innovative gourmet cuisine. With its modern architecture, green spaces, efficient public transportation, and close proximity to nature, Oslo offers a perfect blend of urban sophistication and outdoor adventure, making it a captivating destination for all.", latitude: 59.913333333, longitude: 10.738888888),
    City(name: "London", countryCode: "UK", countryName: "United Kingdom", description: "London, the vibrant capital of the United Kingdom, is a city where history and modernity coexist harmoniously. The city’s iconic skyline is punctuated by landmarks such as the majestic Tower Bridge, the historic Tower of London, and the striking Houses of Parliament with Big Ben. London is a cultural hub, boasting world-renowned museums like the British Museum, the National Gallery, and the Tate Modern, which showcase a vast array of art and artifacts. The city’s diverse neighborhoods, from the chic boutiques of Chelsea to the bustling markets of Camden, offer a unique blend of experiences. Visitors can enjoy a stroll through the verdant expanses of Hyde Park, witness the Changing of the Guard at Buckingham Palace, or take in panoramic views from the London Eye. London’s culinary scene is equally diverse, with everything from traditional pub fare to gourmet dining from around the globe. Rich in history yet continually evolving, London provides a dynamic and unforgettable experience for all who visit.", latitude: 51.507222222, longitude: -0.1275)
  ]
}

extension Itinerary {
  static let sampleData: [Itinerary] = [
    Itinerary(cityName: "Rome", countryName: "Italy", days: [
      Day(dayNumber: 1, pointOfInterestList: [
        PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
        PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
      ]),
      Day(dayNumber: 2, pointOfInterestList: [
        PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
        PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
      ])
    ]),
    Itinerary(cityName: "Athens", countryName: "Greece", days: [
      Day(dayNumber: 1, pointOfInterestList: [
        PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
        PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
      ])
    ])
  ]
}

extension Day {
  static let sampleData = Day(dayNumber: 1, pointOfInterestList: [
    PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
    PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0),
  ])
}

extension PointOfInterest {
  static let sampleData = PointOfInterest(name: "Colosseum", imageURL: nil, type: .historical, latitude: 0, longitude: 0)
}

extension ItineraryViewModel {
  func loadItinerary(from url: URL) throws -> Itinerary {
    do {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      let decoded = try decoder.decode(Itinerary.self, from: data)
      return decoded
    } catch {
      throw ItineraryViewModelError.loadItineraryError
    }
  }
  
  func loadSampleData() async {
    
    var itineraries: [Itinerary] = []
    
    // Paris
    guard let url = Bundle.main.url(forResource: "example-itinerary-1", withExtension: "json") else {
      return
    }
    
    do {
      var itinerary = try loadItinerary(from: url)
      var dateComponents = DateComponents()
      dateComponents.day = 3
      let calendar = Calendar.current
      itinerary.startDate = .now
      itinerary.endDate = calendar.date(byAdding: dateComponents, to: itinerary.startDate!)
      itineraries.append(itinerary)
    } catch {
      print(error.localizedDescription)
    }
    
    // Rome
    guard let url = Bundle.main.url(forResource: "example-itinerary-2", withExtension: "json") else {
      return
    }
    do {
      var itinerary = try loadItinerary(from: url)
      var dateComponents = DateComponents()
      dateComponents.day = 3
      let calendar = Calendar.current
      itinerary.startDate = .now
      itinerary.endDate = calendar.date(byAdding: dateComponents, to: itinerary.startDate!)
      itineraries.append(itinerary)
    } catch {
      print(error.localizedDescription)
    }
    
    itineraryList = itineraries
  }
  
  enum ItineraryViewModelError: Error {
    case loadItineraryError
  }
}
