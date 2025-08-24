;|------------------------------|;
;|	  AG Room Dimensions		|;
;|	  (Metric Version			|;
;|	  www.LetsBIMtogether.com	|;
;|------------------------------|;

; Command: RMDM

(prompt "\nLoaded AG Room Dimensions!")

;; Round to the nearest hundredth (0.01) for metric precision
(defun LM:round ( n )
    (* (fix (+ (* n 100.0) (if (minusp n) -0.5 0.5))) 0.01)
)

(defun c:rmdm (/ pt1 pt2 pt3 txtpt horizdist vertdist txtstr)
  
  (setq pt1 (getpoint "\nClick on the corner of the room 			-->"))
  (setq pt2 (getpoint "\nClick on the diagonally opposite corner of the room 	-->"))
  		      
  (setq pt3 (list (car pt1) (cadr pt2) 0.0))

  (setq txtpt (getpoint "\nClick where you want to place the label		-->"))

  ; Convert distances from mm to m
  (setq horizdist (/ (abs (distance pt3 pt2)) 1000.0))
  (setq vertdist (/ (abs (distance pt1 pt3)) 1000.0))

  ; Convert metric distances to strings with 2 decimal places
  (setq txtstr (strcat 
                (rtos (LM:round horizdist) 2 2) "m x " 
                (rtos (LM:round vertdist) 2 2) "m" ))
  
  (vl-load-com)

  (setq mspace (vla-get-modelspace (vla-get-activedocument (vlax-get-acad-object))))
  
  (setq txtobj (vla-addtext mspace txtstr (vlax-3d-point txtpt) 0.25)) ; <-- TEXT HEIGHT HERE, adjust as needed
  
  ; You can uncomment the below lines if you want to set a specific text style or scale factor.
  ;(vla-put-stylename txtobj "AG_text_style")
  ;(vla-put-scalefactor txtobj ".8")
)
