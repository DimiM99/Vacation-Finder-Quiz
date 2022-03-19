//
//  QuizModel.swift
//  Vacation Finder Quiz
//
//  Created by Dimi on 26.02.22.
//

import Foundation
import CoreText

struct Question {
    var text: String
    var type: ResponseType
    var answers = [Answer]()
    var status = false
    var viewed = false
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: Country
    var selected = false
}

enum Country: String {
    case IT, HR, FR, ES, TR
}


// Need to reset this crap after the round is done

var CountriesScores: [Country: Int] = [.TR: 0, .HR: 0, .FR: 0, .ES: 0, .IT: 0]
var userWelcomeInstroctionsDone = false
var savedRangeForQuestio = 0
var currentQuestion = 0
var questionsAnswered = 0
var savedRangeForQuestion = [Int: Int]()

var Questions = [
    Question(
        text: "Wich of these foods You like?", type: .multiple,
        answers: [
            Answer(text: "Pasta", type: .IT),
            Answer(text: "Pizza", type: .ES),
            Answer(text: "Croissant", type: .FR),
            Answer(text: "Sucuklu Yumurta", type: .TR)
        ]
    ),
    Question(
        text: "How Active you are?", type: .ranged,
        answers:[
            Answer(text: "I'm not that active", type: .FR),
            Answer(text: "Active enuogh", type: .HR),
            Answer(text: "Moovemet is life!!!!!", type: .TR)
        ]
    ),
    Question(
        text: "Who do you like to travel with? ", type: .single,
        answers: [
            Answer(text: "With my family", type: .ES),
            Answer(text: "Alone, or with my friends", type: .IT)
        ]
    ),
    Question(
        text: "How important are swimming activities for you on a vacation/journey? ", type: .ranged,
        answers: [
            Answer(text: "not at all/ don't care", type: .FR),
            Answer(text: "Nice to have", type: .IT),
            Answer(text: "Want to have", type: .ES),
        ]
    ),
    Question(
        text: "What would u plan if had only one day in a contry", type: .multiple,
        answers: [
            Answer(text: "Visit all museums", type: .FR),
            Answer(text: "Visit all Clubs", type: .HR),
            Answer(text: "Take shitt load of photos in beatifull places", type: .ES),
            Answer(text: "Wander around the old streets", type: .TR)
        ]
    ),
    Question(
        text: "R u interested in culture", type: .single,
        answers: [
            Answer(text: "not at all/ don't care", type: .ES),
            Answer(text: "Nice to have", type: .IT),
            Answer(text: "Want to have", type: .FR),
            Answer(text: "Need to have", type: .TR)
        ]
    ),
    Question(
        text: "Your favourite mealtime", type: .single,
        answers: [
            Answer(text: "Breakfast", type: .FR),
            Answer(text: "Supper", type: .IT),
            Answer(text: "Lunch", type: .TR)
        ]
    ),
    Question(
        text: "Your friends are going to Hike, What du you say?", type: .single,
        answers: [
            Answer(text: "nah", type: .FR),
            Answer(text: "I would live to try", type: .TR),
            Answer(text: "Le' gooo!", type: .HR)
        ]
    ),
    Question(
        text: "Coffee near the sea?", type: .single,
        answers: [
            Answer(text: "Nah, I'm good", type: .HR),
            Answer(text: "Yes Please!!", type: .TR)
        ]
    ),
    Question(
        text: "Waht's important for you in a country", type: .multiple,
        answers: [
            Answer(text: "Walks on the evening", type: .FR),
            Answer(text: "Fooood", type: .IT),
            Answer(text: "Rich Architecture", type: .ES),
            Answer(text: "Culture", type: .TR)
        ]
    ),
    Question(
        text: "How important are safety measure that the coutry you want to visit?", type: .ranged,
        answers: [
            Answer(text: "not at all/ don't care", type: .TR),
            Answer(text: "Nice to have", type: .IT),
            Answer(text: "Very Important", type: .ES),
        ]
    ),
    Question(
        text: "what countries you planned to visit, before you opened the app?", type: .multiple,
        answers: [
            Answer(text: "France", type: .FR),
            Answer(text: "Italy", type: .IT),
            Answer(text: "Spain", type: .ES),
            Answer(text: "Turkey", type: .TR),
            Answer(text: "Croatia", type: .HR)
        ]
    ),
    Question(
        text: "Don't think, WHERE TO???", type: .single,
        answers: [
            Answer(text: "France", type: .FR),
            Answer(text: "Italy", type: .IT),
            Answer(text: "Spain", type: .ES),
            Answer(text: "Turkey", type: .TR),
            Answer(text: "Croatia", type: .HR)
        ]
    ),
    Question(
        text: "what from this would you like to do?", type: .multiple,
        answers: [
            Answer(text: "Go to a museum", type: .FR),
            Answer(text: "Talk with random peaople", type: .IT),
            Answer(text: "Dancs", type: .ES),
            Answer(text: "Wander about old streets, and take photos", type: .TR),
            Answer(text: "Fly on parachute", type: .HR)
        ]
    ),
    Question(
        text: "Restuarant or homemade?", type: .single,
        answers: [
            Answer(text: "I'm a foodie", type: .FR),
            Answer(text: "Restaurant", type: .IT),
            Answer(text: "homemade", type: .TR)
        ]
    )
]






func FullReset() {
    Questions = [
        Question(
            text: "Wich of these foods You like?", type: .multiple,
            answers: [
                Answer(text: "Pasta", type: .IT),
                Answer(text: "Pizza", type: .ES),
                Answer(text: "Croissant", type: .FR),
                Answer(text: "Sucuklu Yumurta", type: .TR)
            ]
        ),
        Question(
            text: "How Active you are?", type: .ranged,
            answers:[
                Answer(text: "I'm not that active", type: .FR),
                Answer(text: "Active enuogh", type: .HR),
                Answer(text: "Moovemet is life!!!!!", type: .TR)
            ]
        ),
        Question(
            text: "Who do you like to travel with? ", type: .single,
            answers: [
                Answer(text: "With my family", type: .ES),
                Answer(text: "Alone, or with my friends", type: .IT)
            ]
        ),
        Question(
            text: "How important are swimming activities for you on a vacation/journey? ", type: .ranged,
            answers: [
                Answer(text: "not at all/ don't care", type: .FR),
                Answer(text: "Nice to have", type: .IT),
                Answer(text: "Want to have", type: .ES),
            ]
        ),
        Question(
            text: "What would u plan if had only one day in a contry", type: .multiple,
            answers: [
                Answer(text: "Visit all museums", type: .FR),
                Answer(text: "Visit all Clubs", type: .HR),
                Answer(text: "Take shitt load of photos in beatifull places", type: .ES),
                Answer(text: "Wander around the old streets", type: .TR)
            ]
        ),
        Question(
            text: "R u interested in culture", type: .single,
            answers: [
                Answer(text: "not at all/ don't care", type: .ES),
                Answer(text: "Nice to have", type: .IT),
                Answer(text: "Want to have", type: .FR),
                Answer(text: "Need to have", type: .TR)
            ]
        ),
        Question(
            text: "Your favourite mealtime", type: .single,
            answers: [
                Answer(text: "Breakfast", type: .FR),
                Answer(text: "Supper", type: .IT),
                Answer(text: "Lunch", type: .TR)
            ]
        ),
        Question(
            text: "Your friends are going to Hike, What du you say?", type: .single,
            answers: [
                Answer(text: "nah", type: .FR),
                Answer(text: "I would live to try", type: .TR),
                Answer(text: "Le' gooo!", type: .HR)
            ]
        ),
        Question(
            text: "Coffee near the sea?", type: .single,
            answers: [
                Answer(text: "Nah, I'm good", type: .HR),
                Answer(text: "Yes Please!!", type: .TR)
            ]
        ),
        Question(
            text: "Waht's important for you in a country", type: .multiple,
            answers: [
                Answer(text: "Walks on the evening", type: .FR),
                Answer(text: "Fooood", type: .IT),
                Answer(text: "Rich Architecture", type: .ES),
                Answer(text: "Culture", type: .TR)
            ]
        ),
        Question(
            text: "How important are safety measure that the coutry you want to visit?", type: .ranged,
            answers: [
                Answer(text: "not at all/ don't care", type: .TR),
                Answer(text: "Nice to have", type: .IT),
                Answer(text: "Very Important", type: .ES),
            ]
        ),
        Question(
            text: "what countries you planned to visit, before you opened the app?", type: .multiple,
            answers: [
                Answer(text: "France", type: .FR),
                Answer(text: "Italy", type: .IT),
                Answer(text: "Spain", type: .ES),
                Answer(text: "Turkey", type: .TR),
                Answer(text: "Croatia", type: .HR)
            ]
        ),
        Question(
            text: "Don't think, WHERE TO???", type: .single,
            answers: [
                Answer(text: "France", type: .FR),
                Answer(text: "Italy", type: .IT),
                Answer(text: "Spain", type: .ES),
                Answer(text: "Turkey", type: .TR),
                Answer(text: "Croatia", type: .HR)
            ]
        ),
        Question(
            text: "what from this would you like to do?", type: .multiple,
            answers: [
                Answer(text: "Go to a museum", type: .FR),
                Answer(text: "Talk with random peaople", type: .IT),
                Answer(text: "Dancs", type: .ES),
                Answer(text: "Wander about old streets, and take photos", type: .TR),
                Answer(text: "Fly on parachute", type: .HR)
            ]
        ),
        Question(
            text: "Restuarant or homemade?", type: .single,
            answers: [
                Answer(text: "I'm a foodie", type: .FR),
                Answer(text: "Restaurant", type: .IT),
                Answer(text: "homemade", type: .TR)
            ]
        )
    ]

    CountriesScores = [.TR: 0, .HR: 0, .FR: 0, .ES: 0, .IT: 0]
    userWelcomeInstroctionsDone = false
    savedRangeForQuestion = [:]
    currentQuestion = 0
    questionsAnswered = 0

}


