import Foundation

extension TimeInterval {
    var formatTimeInterval: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        if self < 3600 {
            // 如果时间少于1小时，只显示分秒
            formatter.allowedUnits = [.minute, .second]
        } else {
            // 否则显示时分秒
            formatter.allowedUnits = [.hour, .minute, .second]
        }
        
        if let formattedString = formatter.string(from: self) {
            return formattedString
        } else {
            return "00"
        }
    }
}
