import UIKit

extension YMCalendar: UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isMinimum {
            return 7 * 2
        }
        else {
            return 7 * 6
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! YMCalendarCollectionViewCell
        
        if indexPath.row % rowCount == 0 {
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ja")
            cell.number.text = formatter.shortWeekdaySymbols[indexPath.row / rowCount]
            
            if indexPath.row / rowCount == 0
            {
                cell.type = .Holiday
            }
            else
            {
                cell.type = .Weekday
            }
        }
        else {
            
            let cal = Calendar.current
            let targetDate = getDate(indexPath: indexPath)
            
            cell.number.text = "\(cal.component(.day, from: targetDate))"
            
            if targetDate == selectedDate
            {
                cell.type = .SelectedDate
            }
            else if targetDate <= Date() {
                cell.type = .UnavailableDate
            }
            else {
                cell.type = .AvailableDate
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 7, height: collectionView.frame.height / CGFloat(rowCount))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = getDate(indexPath: indexPath)
        collectionView.reloadData()
    }
    
    func getDate(indexPath: IndexPath) -> Date
    {
        let line = indexPath.row % rowCount - 1
        let row = indexPath.row / rowCount
        let cal = Calendar.current
        
        if isMinimum {
            let year = cal.component(.year, from: Date())
            let month = cal.component(.month, from: Date())
            let startDay = cal.date(from: DateComponents(year: year, month: month, day: 1))!
            let startDayNumber = cal.component(.weekday, from: startDay) - 1
            return  cal.date(byAdding: .day, value: indexPath.section * 7 + row - startDayNumber, to: startDay)!
        } else {
            let year = (indexPath.section / 12) + cal.component(.year, from: Date())
            let month = indexPath.section + cal.component(.month, from: Date())
            let startDay = cal.date(from: DateComponents(year: year, month: month, day: 1))!
            let startDayNumber = cal.component(.weekday, from: startDay) - 1
            return  cal.date(byAdding: .day, value: line * 7 + row - startDayNumber, to: startDay)!
        }
       
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月"
        
        var row: Int?
        if isMinimum {
            row = 2
        }
        else {
            row = 37
        }
        
        title.text = formatter.string(from: getDate(indexPath: IndexPath(row: row!, section: Int(scrollView.contentOffset.x / scrollView.frame.width))))
    }
    
    func scrollTo(date: Date) {
        
        let firstDay = getDate(indexPath: IndexPath(row: 2, section: 0))
        
        if isMinimum {
            calendarCollectionView.scrollToItem(at: IndexPath(row: 0, section: Calendar.current.dateComponents([.weekOfMonth], from: firstDay, to: date).weekOfMonth!), at: .left, animated: false)
        } else {
            calendarCollectionView.scrollToItem(at: IndexPath(row: 0, section: Calendar.current.dateComponents([.month], from: firstDay, to: date).month!), at: .left, animated: false)
        }
    }

}
