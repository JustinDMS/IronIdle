extends Resource

class_name Player

export var version = "1.2"

export var money : float
export var gym_units = {
	"None" : true,
	"Pull-Up Bar" : false,
	"Bench" : false,
	"Barbell Rack" : false,
	"Deadlift Platform" : false,
}
export var gym_equipment = {
	"None" : true,
	"Barbell" : false,
	"Dumbbells" : false,
	"Plates" : false,
	"Ab Wheel" : false,
}
export var gym_supplements = {
	"Caffeine" : 0,
	"Creatine" : 0,
	"BCAA" : 0,
}
export var active_supplements = {
	"Caffeine" : 0,
	"Creatine" : 0,
	"BCAA" : 0,
}
export var supplements_used = {
	"Caffeine" : 0,
	"Creatine" : 0,
	"BCAA" : 0,
}
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
	"Dumbbell Bench Press" : 1,
	"Dumbbell Fly" : 1,
	"Bench Press" : 1,
	
	"Lateral Raise" : 1,
	"Dumbbell Press" : 1,
	"Arnold Press" : 1,
	"Barbell Press" : 1,
	
	"Dumbbell Row" : 1,
	"Pull-Up" : 1,
	"Landmine Row" : 1,
	"Barbell Row" : 1,
	
	"Sit-Up" : 1,
	"Lying Leg Raise" : 1,
	"Hanging Leg Raise" : 1,
	"Ab Wheel Rollout" : 1,
	
	"Bodyweight Squat" : 1,
	"Goblet Squat" : 1,
	"Barbell Squat" : 1,
	"Snatch" : 1,
	
	"Dumbbell Deadlift" : 1,
	"Romanian Deadlift" : 1,
	"Deadlift" : 1,
	"Power Clean" : 1,
}
export var proficiency_xp = {
	"Push-Up" : 0.0,
	"Dumbbell Bench Press" : 0.0,
	"Dumbbell Fly" : 0.0,
	"Bench Press" : 0.0,
	
	"Lateral Raise" : 0.0,
	"Dumbbell Press" : 0.0,
	"Arnold Press" : 0.0,
	"Barbell Press" : 0.0,
	
	"Dumbbell Row" : 0.0,
	"Pull-Up" : 0.0,
	"Landmine Row" : 0.0,
	"Barbell Row" : 0.0,
	
	"Sit-Up" : 0.0,
	"Lying Leg Raise" : 0.0,
	"Hanging Leg Raise" : 0.0,
	"Ab Wheel Rollout" : 0.0,
	
	"Bodyweight Squat" : 0.0,
	"Goblet Squat" : 0.0,
	"Barbell Squat" : 0.0,
	"Snatch" : 0.0,
	
	"Dumbbell Deadlift" : 0.0,
	"Romanian Deadlift" : 0.0,
	"Deadlift" : 0.0,
	"Power Clean" : 0.0,
}
export var proficiency_xp_total = {
	"Push-Up" : 0.0,
	"Dumbbell Bench Press" : 0.0,
	"Dumbbell Fly" : 0.0,
	"Bench Press" : 0.0,
	
	"Lateral Raise" : 0.0,
	"Dumbbell Press" : 0.0,
	"Arnold Press" : 0.0,
	"Barbell Press" : 0.0,
	
	"Dumbbell Row" : 0.0,
	"Pull-Up" : 0.0,
	"Landmine Row" : 0.0,
	"Barbell Row" : 0.0,
	
	"Sit-Up" : 0.0,
	"Lying Leg Raise" : 0.0,
	"Hanging Leg Raise" : 0.0,
	"Ab Wheel Rollout" : 0.0,
	
	"Bodyweight Squat" : 0.0,
	"Goblet Squat" : 0.0,
	"Barbell Squat" : 0.0,
	"Snatch" : 0.0,
	
	"Dumbbell Deadlift" : 0.0,
	"Romanian Deadlift" : 0.0,
	"Deadlift" : 0.0,
	"Power Clean" : 0.0,
}
export var challenge_progress = {
	"No Imbalances I" : false,
	"No Imbalances II" : false,
	"No Imbalances III" : false,
	"No Imbalances IV" : false,
	"No Imbalances V" : false,
	
	"Favorite Muscle I" : false,
	"Favorite Muscle II" : false,
	"Favorite Muscle III" : false,
	"Favorite Muscle IV" : false,
	"Favorite Muscle V" : false,
	
	"Favorite Exercise I" : false,
	"Favorite Exercise II" : false,
	"Favorite Exercise III" : false,
	"Favorite Exercise IV" : false,
	
	"Need a Boost I" : false,
	"Need a Boost II" : false,
	"Need a Boost III" : false,
	
	"Gain Train I" : false,
	"Gain Train II" : false,
	"Gain Train III" : false,
	
	"Focus on Form I" : false,
	"Focus on Form II" : false,
	"Focus on Form III" : false,
	
	"Sponsor Me I" : false,
	"Sponsor Me II" : false,
	"Sponsor Me III" : false,
}
export var supplement_challenge_claimed = {
	"Favorite Muscle I" : false,
	"Favorite Muscle II" : false,
	"Favorite Muscle III" : false,
	"Favorite Muscle IV" : false,
	"Favorite Muscle V" : false,
	
	"Favorite Exercise I" : false,
	"Favorite Exercise II" : false,
	"Favorite Exercise III" : false,
	"Favorite Exercise IV" : false,
}
export var equipment_tier = {
	"Dumbbells": 0,
	"Plates" : 0,
}
export var settings = {
	"Strength XP" : true,
	"Proficiency XP" : true,
	"Money" : true,
}
