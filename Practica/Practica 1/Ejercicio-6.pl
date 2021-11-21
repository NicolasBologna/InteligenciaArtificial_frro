%vive_en_y_toca(persona,ciudad,tipo de musico)
vive_en_y_toca(carolina,rosario,guitarrista).
vive_en_y_toca(jose,rosario,guitarrista).
vive_en_y_toca(mariano,rosario,cantante).
vive_en_y_toca(laura,rosario,baterista).
vive_en_y_toca(miguel,funes,guitarrista).
vive_en_y_toca(silvia,funes,cantante).
vive_en_y_toca(mauro,funes,cantante).
vive_en_y_toca(eduardo,roldan,baterista).

puede_formar(Ciudad) :- vive_en_y_toca(_,Ciudad,guitarrista),vive_en_y_toca(_,Ciudad,cantante),vive_en_y_toca(_,Ciudad,baterista).