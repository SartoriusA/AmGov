//
//  Game.swift
//  amGov2022App
//
//  Created by Andrew J. Sartorius on 7/11/22.
//

import SwiftUI

struct Game: View {
    @EnvironmentObject var cv: CurrentView
    @ObservedObject var gameController: QuestionClass = QuestionClass()
    var body: some View {
        ZStack{
            switch gameController.correct{
            case 1:
                Rectangle()
                    .foregroundColor(.green)
                    .animation(.easeInOut, value: gameController.correct)
            case 2:
                Rectangle()
                    .foregroundColor(.red)
                    .animation(.easeInOut, value: gameController.correct)
            default:
                EmptyView()
            }
            
            VStack{
                ScoreBoard(gameController: gameController)
                    .padding()
                QuestionView(gameController: gameController)
                    .padding()
            }
        }
        .background(Color(white: 0.1))
        .sheet(isPresented: $gameController.gameOver) {
            EndGameView(gameController: gameController)
        }
    }
}

struct ScoreBoard : View{
    @ObservedObject var gameController: QuestionClass
    var body: some View{
        HStack{
            Text("Score: \(gameController.score)")
                .foregroundColor(.yellow)
            Spacer()
            Text("Question: \(gameController.numberOfQuestions)")
                .foregroundColor(.yellow)
            Spacer()
            Text("Time \(gameController.time)")
                .foregroundColor(.yellow)
        }
    }
}

struct QuestionView : View {
    @EnvironmentObject var cv: CurrentView
    @ObservedObject var gameController: QuestionClass
    @State private var selected: Int? = nil
    @State private var questions: [Question?] = [Question]()
    @State private var question: Question? = nil
    var body: some View {
        VStack{
            Spacer()
            Text(question?.question ?? "Question Loading")
                .font(.title)
                .foregroundColor(.yellow)
            Spacer()
            if question != nil {
                ForEach(1...question!.answers.count, id: \.self){ i in
                    Button(question!.answers[i-1], action: {
                        toggleSelection(i: i)
                    })
                    .foregroundColor(.yellow)
                    .padding()
                    .border(.yellow, width: 2)
                    .background((selected == i) ? .blue : Color(white: 0.1))
                    .animation(.easeInOut, value: selected)
                }
            } else {
                Text("Loading")
            }
            Spacer()
            Button("Submit") {
                testQuestion()
            }
            .font(.largeTitle)
            .foregroundColor(.yellow)
            .padding()
            .border(.yellow, width: 2)
        }
        .onAppear(){
            setUp()
        }
    }
    func toggleSelection(i: Int){
        if selected == i{
            selected = nil
        } else {
            selected = i
        }
    }
    func testQuestion(){
        guard selected != nil else {return}
        if gameController.questionAnsered(question: question!, answer: selected!-1) {
            gameController.correct = 1
            
        } else {
            gameController.correct = 2
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            gameController.correct = 0
            getQuestion()
            selected = nil
        }
    }
    func getQuestion(){
        let n = Int.random(in: 0...(questions.count-1))
        let item = questions[n]
        questions.remove(at: n)
        question = item!
        
    }
    func setUp(){
        gameController.score = 0
        gameController.numberOfQuestions = 0
        questions = [Question]()
        questions.append(contentsOf: gameController.questions)
        gameController.time = 30
        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ timer in
            if gameController.time > 0 {
                gameController.time -= 1
            } else {
                gameOver()
                timer.invalidate()
            }
        }
        getQuestion()
    }
    func gameOver(){
        gameController.gameOver.toggle()
    }
}

struct EndGameView: View{
    @EnvironmentObject var cv: CurrentView
    @ObservedObject var gameController: QuestionClass
    var body: some View{
        VStack{
            Text("Game Over")
                .font(.largeTitle)
                .foregroundColor(.yellow)
            Spacer()
            HStack{
                Spacer()
                VStack{
                    Text("Number of Questions:")
                        .font(.title)
                        .foregroundColor(.yellow)
                    Text(String(gameController.numberOfQuestions))
                        .font(.title)
                        .foregroundColor(.yellow)
                }
                Spacer()
                VStack{
                    Text("Score:")
                        .font(.title)
                        .foregroundColor(.yellow)
                    Text(String(gameController.score))
                        .font(.title)
                        .foregroundColor(.yellow)
                }
                Spacer()
            }
            Spacer()
            HStack{
                Spacer()
                VStack{
                    Text("Accuracy")
                        .font(.title)
                        .foregroundColor(.yellow)
                    Text("\(gameController.accuracy)%")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                }
                Spacer()
            }
            Spacer()
            Button("Finish") {
                cv.currentView = .home
            }
            .font(.largeTitle)
            .foregroundColor(.yellow)
            .padding()
            .border(.yellow, width: 2)
        }
        .background(Color(white: 0.1))
    }

}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
//        Game()
        EndGameView(gameController: QuestionClass())
    }
}
