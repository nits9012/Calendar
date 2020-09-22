
import UIKit

protocol CalendarDelegate: class {
    func getSelectedDate(_ date: String)
}

class CalendarView: UIView {

    @IBOutlet weak var monthAndYear: UILabel!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    
    private let cellID = "DayCell"
    weak var delegate: CalendarDelegate?
    
    var date = Date()
    var numberofDay = Int()
    var selectedIndexPath: IndexPath?


    //MARK:- Initialize calendar
    private func initialize() {
        let nib = UINib(nibName: self.cellID, bundle: nil)
        self.daysCollectionView.register(nib, forCellWithReuseIdentifier: self.cellID)
        self.daysCollectionView.delegate = self
        self.daysCollectionView.dataSource = self
    }
    
    //MARK:- Change month when left and right arrow button tapped
    @IBAction func arrowTapped(_ sender: UIButton) {
        
        if sender.tag == 0{
            date = Calendar.current.date(byAdding: .month, value: -1 , to:  date)!
        }
        
        if sender.tag == 1{
            date = Calendar.current.date(byAdding: .month, value: 1, to:  date)!
        }
        
        monthAndYear.text = date.monthAndYear
        self.getNumberDayFromSelectedMonth(value: date)
        self.daysCollectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),at: .left, animated: true)
    }
    
    func getNumberDayFromSelectedMonth(value:Date){
        self.selectedIndexPath = IndexPath(row: 0, section: 0)
        let monthRange = Calendar.current.range(of: .day, in: .month, for: value)!
        numberofDay = monthRange.count
        daysCollectionView.reloadData()
    }
    
}

//MARK:- Calendar collection view delegate and datasource methods
extension CalendarView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberofDay
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! DayCell
        cell.day.text = String(indexPath.row + 1)
        let value = "\(String(indexPath.row + 1)) \(monthAndYear.text!)"
        let date = convertStringDateFormatToDate(value: value, dateFormat: defaultDateFormat)
        cell.weekday.text = date.getDayInWeek()
        if self.selectedIndexPath != nil && indexPath == self.selectedIndexPath {
            cell.dayView.backgroundColor = UIColor.darkGray
        }else{
            cell.dayView.backgroundColor = nil
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.daysCollectionView.reloadData()
        self.delegate?.getSelectedDate("\(String(indexPath.row + 1)) \(monthAndYear.text!)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = nil
    }
    
}

//MARK:- Add calendar to the view
extension CalendarView {
    
    public class func addCalendar(_ superView: UIView) -> CalendarView? {
        var calendarView: CalendarView?
        if calendarView == nil {
            calendarView = UINib(nibName: "CalendarView", bundle: nil).instantiate(withOwner: self, options: nil).last as? CalendarView
            guard let calenderView = calendarView else { return nil }
            calendarView?.frame = CGRect(x: 0, y: 0, width: superView.bounds.size.width, height: superView.bounds.size.height)
            superView.addSubview(calenderView)
            calenderView.initialize()
            return calenderView
        }
        return nil
    }
    
}

