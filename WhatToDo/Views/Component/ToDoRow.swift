import SwiftUI

struct ToDoRow: View {
    var task: String
    var isThereDeadline: Bool
    var deadline: Date
    var notification: Bool
    var isCompleted: Bool
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var remainingTime: String = ""
    
    init(_ task: String, _ isThereDeadline: Bool, _ deadline: Date, _ notification: Bool, _ isCompleted: Bool) {
        self.task = task
        self.isThereDeadline = isThereDeadline
        self.deadline = deadline
        self.notification = notification
        self.isCompleted = isCompleted
        if isThereDeadline {
            self._remainingTime = State(initialValue: leftTime(deadline - Date()))
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle.fill")
                .foregroundColor(.midiumPurple)
                .font(.system(size: 10))
            
            Text(task)
                .font(Font.custom("EF_Diary", size: 20))
                .foregroundColor(.midiumPurple)
                .strikethrough(isCompleted, color: .midiumPurple)
            
            
            if notification {
                Image(systemName: "bell.fill")
                    .font(.system(size: 15))
                    .foregroundColor(.midiumPurple)
            }
            
            Spacer()
            
            if isThereDeadline {
                Text(remainingTime)
                    .font(Font.custom("EF_Diary", size: 15))
                    .foregroundColor(.midiumPurple)
                    .strikethrough(isCompleted, color: .midiumPurple)
                    .padding(.trailing, 20)
            }
        }
        .background(Color.spaceCadet)
        .onReceive(timer) { _ in
            remainingTime = leftTime(deadline - Date())
        }
    }
}

// 41분
