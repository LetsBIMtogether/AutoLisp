;|------------------------------|;
;|	  AG Room Dimensions V9		|;
;|	  www.LetsBIMtogether.com	|;
;|------------------------------|;

; Command: 	RMDM
; Note:		This AutoLisp routine will round up 11-1/2" to 1'-0".
;			11-1/4" will wound to 11"

;; Round  -  Lee Mac <3
;; Rounds 'n' to the nearest integer
(defun LM:round ( n )
    (fix (+ n (if (minusp n) -0.5 0.5)))
)


(prompt "\nLoaded AG Room Dimensions!")


(defun c:rmdm (/ pt1, pt2, pt3, txtpt, horizdist, vertdist, fthorizdist, inhorizdist, ftvertdist, invertdist, txtstr)
  
  (setq pt1 (getpoint "\nClick on the corner of the room 			-->"))
  (setq pt2 (getpoint "\nClick on the diagonally opposite corner of the room 	-->"))
  		      
  (setq pt3 (list (car pt1) (cadr pt2) 0.0))

  (setq txtpt (getpoint "\nClick where you want to place the label		-->"))

  (setq horizdist (abs (distance pt3 pt2)))
  (setq vertdist (abs (distance pt1 pt3)))

  (setq fthorizdist (fix (/ horizdist 12)))
  (setq inhorizdist (LM:round (rem horizdist 12)))
  
  ;; Fix for horizontal: if inches = 12, increment feet and set inches to 0
  (if (= inhorizdist 12)
	(progn
		(setq fthorizdist (1+ fthorizdist))
		(setq inhorizdist 0)
	)
  ) 
  
  (setq ftvertdist (fix (/ vertdist 12)))
  (setq invertdist (LM:round (rem vertdist 12)))
  
  ;; Fix for vertical: if inches = 12, increment feet and set inches to 0
  (if (= invertdist 12)
	(progn
	(setq ftvertdist (1+ ftvertdist))
        (setq invertdist 0)
	)
  )
		
  (setq txtstr (strcat (itoa fthorizdist) "'-" (itoa inhorizdist) "\"x" (itoa ftvertdist) "'-" (itoa invertdist) "\"" ))
  
  (vl-load-com)

  (setq mspace (vla-get-modelspace (vla-get-activedocument (vlax-get-acad-object))))
  
  (setq txtobj (vla-addtext mspace txtstr (vlax-3d-point txtpt) 9)) ; <-- TEXT HEIGHT HERE

  ;(vla-put-stylename txtobj "AG_text_style")
  ;(vla-put-scalefactor txtobj ".8")
)