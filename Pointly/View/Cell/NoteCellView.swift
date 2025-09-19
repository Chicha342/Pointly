//
//  NoteCellView.swift
//  Pointly
//
//  Created by Никита on 10.09.2025.
//

import SwiftUI

struct NoteCellView: View {
    @ObservedObject var note: NoteModelLocal
    @ObservedObject var viewModel: NotesViewModel
    
    var body: some View {
        VStack(alignment: .leading){
             
            HStack{
                RoundedRectangle(cornerRadius: 25)
                    .fill(priorityColor().opacity(note.isDone ? 0.3 : 1))
                    .frame(width: 25, height: 25)
                
                
                Text(note.text ?? "No data")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(note.isDone ? .gray : .black)
                
                Spacer()
                
                VStack(alignment: .trailing){
                    Text("Created at: \(note.time ?? "no data")")
                        .font(.system(size: 10))
                        .foregroundStyle(note.isDone ? .gray.opacity(0.2) : .black.opacity(0.6))
                    
                    Text("On date: \(note.day ?? "no data")")
                        .font(.system(size: 10))
                        .foregroundStyle(note.isDone ? .gray.opacity(0.2) : .black.opacity(0.6))
                }
                
            }
            
            Text(note.descr ?? "No data")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.secondary)
                .padding(.top, 5)
            
            Rectangle()
                .fill(Color.black)
                .frame(maxWidth: .infinity, maxHeight: 0.7)
            
            VStack{
                HStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(note.isDone ? Color.green : Color.clear)
                        .frame(width: 20, height: 20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        }
                    
                    Text(note.isDone ? "Completed" : "Mark as complited")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(note.isDone ? .green : .black)
                        .padding(.leading, 5)
                }
                .onTapGesture {
                    print("Tapped On CellView: \(note.id)")
                    withAnimation {
                        viewModel.coreDataManager.toggleDone(note)
                    }
                    
                }
                .padding(.top, 6)
            }
            
        }
        
        .padding()
        .background{
            Color.white.opacity(0.7)
                .blur(radius: 4)
                .cornerRadius(15)
        }
        .overlay {
            if note.isDone{
                RoundedRectangle(cornerRadius: 15)
                    .stroke(style: StrokeStyle(lineWidth: 1))
                    .fill(Color.green.opacity(0.8))
            }else{
                RoundedRectangle(cornerRadius: 15)
                    .stroke(style: StrokeStyle(lineWidth: 0.3))
                    .fill(LinearGradient(colors: [.blue.opacity(1), .clear], startPoint: .leading, endPoint: .trailing))
            }
        }
        
        
        
        
    }
    func priorityColor() -> Color {
        switch note.priority ?? "Low" {
        case "High":
            return .red
        case "Medium":
            return .yellow
        default:
            return .green
        }
    }
}

//#Preview {
//    let context = CoreDataManager.shared.context
//    let testNote = NoteModelLocal(context: context)
//    testNote.text = "Finish Homework"
//    testNote.descr = "Math and Physics"
//    testNote.day = "Monday"
//    testNote.priority = "High"
//    
//    NoteCellView(note: testNote, viewModel: NotesViewModel())
//}

#Preview {
    NoteCellView(note: NoteModelLocal(context: CoreDataManager.shared.context),
                 viewModel: NotesViewModel())
}
