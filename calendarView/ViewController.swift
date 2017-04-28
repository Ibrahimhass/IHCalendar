//
//  ViewController.swift
//  calendarView
//
//  Created by Md Ibrahim Hassan on 28/04/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit
enum day {
    case Sunday, Monday, Teusday, Wednesday, Thursday, Friday, Saturday
}
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var numberOfEmptyCells : Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        let date =  Date().startOfMonth()
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "EEEE" //Wednesday, Mar 29, 2017
        let formattedDate1 = formatter1.string(from: date)
        print (formattedDate1)
        if (formattedDate1 == "Sunday") {
            numberOfEmptyCells = 0
        }
        if (formattedDate1 == "Monday") {
           numberOfEmptyCells = 1
        }
        if (formattedDate1 == "Tuesday") {
           numberOfEmptyCells = 2
        }
        if (formattedDate1 == "Wednesday") {
          numberOfEmptyCells = 3
        }
        if (formattedDate1 == "Thursday") {
           numberOfEmptyCells = 4
        }
        if (formattedDate1 == "Friday") {
           numberOfEmptyCells = 5
        }
        if (formattedDate1 == "Saturday") {
           numberOfEmptyCells = 6
        }
        print (numberOfEmptyCells)
    }

    var days: [String] {
        let calendar = Calendar.current
        let date = Date()
        let interval = calendar.dateInterval(of: .month, for: date)!
        let daysInMonth = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        var returnArray : [String] = []
        for i in 1...daysInMonth{
            returnArray.append(String(i))
        }
        var emptyArray : [String] = []
        if self.numberOfEmptyCells! > 0 {
            for _ in 0 ..< self.numberOfEmptyCells! {
                emptyArray.append(" ")
            }
            return (emptyArray + returnArray)
        }
        return (returnArray)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! collectionViewCell
        cell.collectionViewLabel.text = days[indexPath.item]
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    /*Reusable View*/
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoryMonthHeader", for: indexPath)
//        (reusableView as! CategoryMonthHeader).monthLabel.text = "April"
        return reusableView
    }
    
    
    /*Flow Layout Delegate*/
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var availableWidth : CGFloat!
        var numberOfCells : Int!
        numberOfCells = 7
        let padding = 2
        availableWidth = collectionView.frame.size.width - CGFloat(padding * (numberOfCells - 1))
        let dynamicCellWidth = availableWidth / CGFloat(numberOfCells)
        let cellHeight : CGFloat = collectionView.frame.size.height / 7
        let dynamicCellSize = CGSize.init(width: dynamicCellWidth, height: cellHeight)
        return (dynamicCellSize)
    }
    /*Height for Header*/
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.bounds.width, height: self.collectionView.frame.size.height/7)
    }
}


extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
 
//   func numberOfDay() -> Int {
//        
//    }
    /*let calendar = Calendar.current
     let date = Date()
     
     // Calculate start and end of the current year (or month with `.month`):
     let interval = calendar.dateInterval(of: .year, for: date)!
     
     // Compute difference in days:
     let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
     print(days)*/
}


class collectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var collectionViewLabel: UILabel!
}

class CategoryMonthHeader: UICollectionReusableView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        var days : [String] = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]
        var temp : CGFloat = 0.0
        for i in 0..<7 {
            var availableWidth : CGFloat!
            var numberOfCells : Int!
            numberOfCells = 7
            let padding = 2
            availableWidth = self.frame.size.width - CGFloat(padding * (numberOfCells - 1))
            let dynamicCellWidth = availableWidth / CGFloat(numberOfCells)
            let width = dynamicCellWidth
            let frame = CGRect.init(x: CGFloat(temp), y: self.frame.size.height/2, width: width, height: self.frame.size.height/2)
            let label : UILabel = UILabel.init(frame: frame)
            label.textAlignment = .center
            label.text = days[i]
            temp += width + 2.0
            label.backgroundColor = .white
            self.addSubview(label)
            
            let frame1 = CGRect.init(x: self.center.x - 50, y: 0, width: 100, height: self.frame.size.height / 2)
            let label1 = UILabel.init(frame: frame1)
            let date =  Date()
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "MMMM" //Wednesday, Mar 29, 2017
            let formattedDate1 = formatter1.string(from: date)
            label1.text = formattedDate1
            label1.textAlignment = .center
            self.addSubview(label1)
        }
    }
    
}
