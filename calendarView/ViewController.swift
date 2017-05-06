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
var valueMonth : Int = 0
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        print ("Go to previous Month")
        valueMonth -= 1
        self.refreshView()
    }
    
    @IBAction func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        print ("Load the next month")
        valueMonth += 1
        self.refreshView()
    }
    @IBOutlet weak var collectionView: UICollectionView!
    var numberOfEmptyCells : Int? = nil
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for v in view.subviews{
            if v.tag == 1001 {
                v.removeFromSuperview()
            }
        }
    }
    func refreshView()
    {
        let date1 =  Date().month(value: valueMonth)
        let date2 = date1.startOfMonth()
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "EEEE"
        let formattedDate1 = formatter1.string(from: date2)
        print (formattedDate1)
        if (formattedDate1 == "Sunday") {
            numberOfEmptyCells = 6
        }
        if (formattedDate1 == "Monday") {
            numberOfEmptyCells = 0
        }
        if (formattedDate1 == "Tuesday") {
            numberOfEmptyCells = 1
        }
        if (formattedDate1 == "Wednesday") {
            numberOfEmptyCells = 2
        }
        if (formattedDate1 == "Thursday") {
            numberOfEmptyCells = 3
        }
        if (formattedDate1 == "Friday") {
            numberOfEmptyCells = 4
        }
        if (formattedDate1 == "Saturday") {
            numberOfEmptyCells = 5
        }
        print(days)
        self.collectionView.reloadData()
        self.collectionView.reloadInputViews()
        self.collectionView.scrollToItem(at: IndexPath.init(row: 0, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshView()
        }
    var advanceArrayCount : Int = 0
    var days: [String] {
        let dateToShow = Date().month(value: valueMonth)
        let daysInMonth = dateToShow.numberOfDays()
        var returnArray : [String] = []
        for i in 1...daysInMonth{
            returnArray.append(String(i))
        }
        var emptyArray : [String] = []
        if self.numberOfEmptyCells! > 0 {
            for i in 0 ..< self.numberOfEmptyCells! {
                //Get the last months of the previous Month
                let date = Date().month(value: -1)
                let numberOfDays = date.numberOfDays()
                emptyArray.append("\(numberOfDays - i)")
            }
//            return (emptyArray.reversed() + returnArray)
        }
        var advanceArray : [String] = []
        if (returnArray.count + emptyArray.count > 35)
        {
            for i in (emptyArray.count + returnArray.count) ..< 42{
                advanceArray.append("\(i - emptyArray.count - returnArray.count + 1)")
            }
        }
        if (returnArray.count + emptyArray.count <= 35) {
            if (35 - returnArray.count + emptyArray.count >= 0){
                for i in (emptyArray.count + returnArray.count) ..< 35{
                    advanceArray.append("\(i - emptyArray.count - returnArray.count + 1)")
                }
            }
        }
     self.advanceArrayCount = advanceArray.count
     return (emptyArray.reversed() + returnArray + advanceArray)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! collectionViewCell
        cell.collectionViewLabel.textColor = .black
        
        if (indexPath.item < self.numberOfEmptyCells!){
            cell.backgroundView?.backgroundColor = .lightGray
            cell.collectionViewLabel.textColor = .gray
        }
        
        if (indexPath.item >= days.count - self.advanceArrayCount){
            cell.backgroundView?.backgroundColor = .lightGray
            cell.collectionViewLabel.textColor = .gray
        }
        cell.collectionViewLabel.text = days[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print ("You have selected \(days[indexPath.item])")
//        guard let validCell = collectionView.cellForItem(at: indexPath) as! collectionViewCell else {return}
        guard let validCell = collectionView.cellForItem(at: indexPath) as? collectionViewCell else {return}
        let point = validCell.center.y
        let upperY = point - validCell.frame.size.height / 2.0
        print (upperY)
        let grayView = UIView.init(frame: CGRect.init(x: 0, y: upperY + 100, width: collectionView.frame.size.width, height: validCell.frame.size.height))
        grayView.backgroundColor = .lightGray
        grayView.alpha = 0.5
        grayView.tag = 1001
        self.view.addSubview(grayView)

        
    }
    
    /*Reusable View*/
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoryMonthHeader", for: indexPath)
        for view in reusableView.subviews {
            view.removeFromSuperview()
        }
        var days : [String] = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"]
        var temp : CGFloat = 0.0
        for i in 0..<7 {
            var availableWidth : CGFloat!
            var numberOfCells : Int!
            numberOfCells = 7
            let padding = 2
            availableWidth = reusableView.frame.size.width - CGFloat(padding * (numberOfCells - 1))
            let dynamicCellWidth = availableWidth / CGFloat(numberOfCells)
            let width = dynamicCellWidth
            let frame = CGRect.init(x: CGFloat(temp), y: reusableView.frame.size.height/2, width: width, height: reusableView.frame.size.height/2)
            let label : UILabel = UILabel.init(frame: frame)
            label.textAlignment = .center
            label.text = days[i]
            if (label.text == "Sat" || label.text == "Sun"){
                label.textColor = .red
            }
            temp += width + 2.0
            label.backgroundColor = .white
            reusableView.addSubview(label)
            
            let frame1 = CGRect.init(x: reusableView.center.x - 75, y: 0, width: 150, height: reusableView.frame.size.height / 2)
            let label1 = UILabel.init(frame: frame1)
            let date =  Date().month(value: valueMonth)
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "MMMM yyy" //Wednesday, Mar 29, 2017
            let formattedDate1 = formatter1.string(from: date)
            label1.text = formattedDate1
            label1.textAlignment = .center
            label1.adjustsFontSizeToFitWidth = true
            reusableView.addSubview(label1)
        }
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
        var cellHeight : CGFloat = 0.0
        if (collectionView.numberOfItems(inSection: 0) == 42)
        {
            cellHeight = collectionView.frame.size.height / 8
        }
        if (collectionView.numberOfItems(inSection: 0) == 35){
            cellHeight = collectionView.frame.size.height / 7
        }
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
    
   func numberOfDays() -> Int {
    let calendar = Calendar.current
     let date = Date().month(value: valueMonth)
     // Calculate start and end of the current year (or month with `.month`):
     let interval = calendar.dateInterval(of: .month, for: date)!
     // Compute difference in days:
     let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
     return (days)
    }
    
    func month(value : Int) -> Date {
        let calendar1 = Calendar.current
          let twoDaysAgo = calendar1.date(byAdding: .month, value: value, to: Date())
            return (twoDaysAgo)!
    }
}


class collectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var collectionViewLabel: UILabel!
}

class CategoryMonthHeader: UICollectionReusableView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
//        var days : [String] = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]
//        var temp : CGFloat = 0.0
//        for i in 0..<7 {
//            var availableWidth : CGFloat!
//            var numberOfCells : Int!
//            numberOfCells = 7
//            let padding = 2
//            availableWidth = self.frame.size.width - CGFloat(padding * (numberOfCells - 1))
//            let dynamicCellWidth = availableWidth / CGFloat(numberOfCells)
//            let width = dynamicCellWidth
//            let frame = CGRect.init(x: CGFloat(temp), y: self.frame.size.height/2, width: width, height: self.frame.size.height/2)
//            let label : UILabel = UILabel.init(frame: frame)
//            label.textAlignment = .center
//            label.text = days[i]
//            temp += width + 2.0
//            label.backgroundColor = .white
//            self.addSubview(label)
//            
//            let frame1 = CGRect.init(x: self.center.x - 50, y: 0, width: 100, height: self.frame.size.height / 2)
//            let label1 = UILabel.init(frame: frame1)
//            let date =  Date().month(value: valueMonth)
//            let formatter1 = DateFormatter()
//            formatter1.dateFormat = "MMMM" //Wednesday, Mar 29, 2017
//            let formattedDate1 = formatter1.string(from: date)
//            label1.text = formattedDate1
//            label1.textAlignment = .center
//            self.addSubview(label1)
//        }
    }
}
