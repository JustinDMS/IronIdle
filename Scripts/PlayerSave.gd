extends Resource

class_name Player

export var version = "1.1"

export var money : float
export var gym_units = ["None"]
export var gym_equipment = ["None"]
export var gym_supplements = ["None"]
export var strength_level = {
	"Chest" : 1,
	"Shoulders" : 1,
	"Back" : 1,
	"Core" : 1,
	"Quadriceps" : 1,
	"Hamstrings" : 1,
}
export var xp = {
	"Chest" : 0.0,
	"Shoulders" : 0.0,
	"Back" : 0.0,
	"Core" : 0.0,
	"Quadriceps" : 0.0,
	"Hamstrings" : 0.0,
}
export var xp_total = {
	"Chest" : 0.0,
	"Shoulders" : 0.0,
	"Back" : 0.0,
	"Core" : 0.0,
	"Quadriceps" : 0.0,
	"Hamstrings" : 0.0,
}
export var proficiency_level = {
	"Push-Up" : 1,
	"Sit-Up" : 1,
	"Bodyweight Squat" : 1,
	"Pull-Up" : 1,
	
	"Lateral Raise": 1,
	"Dumbbell Row": 1,
	"Goblet Squat": 1,
	"Dumbbell Deadlift": 1,
	"Dumbbell Bench Press": 1,
	"Dumbbell Press": 1,
	
	"Bench Press" : 1,
	"Barbell Press" : 1,
	"Barbell Row" : 1,
	"Barbell Squat" : 1,
	"Deadlift" : 1,
}
export var proficiency_xp = {
	"Push-Up" : 0.0,
	"Sit-Up" : 0.0,
	"Bodyweight Squat" : 0.0,
	"Pull-Up" : 0.0,
	
	"Lateral Raise": 0.0,
	"Dumbbell Row": 0.0,
	"Goblet Squat": 0.0,
	"Dumbbell Deadlift": 0.0,
	"Dumbbell Bench Press": 0.0,
	"Dumbbell Press": 0.0,
	
	"Bench Press" : 0.0,
	"Barbell Press" : 0.0,
	"Barbell Row" : 0.0,
	"Barbell Squat" : 0.0,
	"Deadlift" : 0.0,
}
export var proficiency_xp_total = {
	"Push-Up" : 0.0,
	"Sit-Up" : 0.0,
	"Bodyweight Squat" : 0.0,
	"Pull-Up" : 0.0,
	
	"Lateral Raise": 0.0,
	"Dumbbell Row": 0.0,
	"Goblet Squat": 0.0,
	"Dumbbell Deadlift": 0.0,
	"Dumbbell Bench Press": 0.0,
	"Dumbbell Press": 0.0,
	
	"Bench Press" : 0.0,
	"Barbell Press" : 0.0,
	"Barbell Row" : 0.0,
	"Barbell Squat" : 0.0,
	"Deadlift" : 0.0,
}
