extends Resource

export var exercise_name : String
export(String, "All", "Calisthenic", "Dumbbell", "Barbell") var exercise_type
export var rep_time : float
export var base_strength : float
export(String, "All", "Chest", "Shoulders", "Back", "Core", "Quadriceps", "Hamstrings") var muscle_groups
export var has_level_requirement : bool
export var level_requirement : int
export(String, "None", "Pull-Up Bar", "Bench", "Barbell Rack", "Deadlift Platform") var unit_req
export(String, "None", "Barbell", "Dumbbells") var equipment_req_1
export(String, "None", "Plates") var equipment_req_2
