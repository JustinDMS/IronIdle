extends Resource

export var exercise_name : String
export(String, "All", "Calisthenic", "Weighted") var exercise_type
export var rep_time : float
export(String, "All", "Chest", "Shoulders", "Back", "Core", "Quadriceps", "Hamstrings") var muscle_groups
export(String, "None", "High Bar", "Bench", "Rack", "Deadlift Platform") var gym_req
export(String, "None", "Dumbbell", "Plates") var equipment_req
