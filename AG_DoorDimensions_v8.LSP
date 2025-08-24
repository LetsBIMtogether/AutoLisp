;|------------------------------|;
;|	  AG Door Dimensions		|;
;|	  www.LetsBIMtogether.com	|;
;|------------------------------|;


; Command: DRD


(prompt "\nLoaded AG Room Dimensions!")

;; Round  -  Lee Mac <3
;; Rounds 'n' to the nearest integer
(defun LM:round ( n )
    (fix (+ n (if (minusp n) -0.5 0.5)))
)


(prompt "\nLoaded AG Door Dimensions!")


(defun c:drd(/ drlength drangle pt1 pt2 ft in drstr mspace l1 l2 l3 npt1 npt2 txtobj1 txtobj2 loop selection xselection)

  (setq pt1 (getpoint "\nClick door START point 		-->"))
  (setq pt2 (getpoint "\nClick door END point 			-->"))
  		      
  
  (setq  drlength (abs (distance pt1 pt2)))
  (setq drangle (angle pt1 pt2))
  (setq ft (fix(/ drlength 12)))
  (setq in (LM:round(rem drlength 12)))
  (setq drstr (strcat (itoa ft) "/" (itoa in) "x6/8")) ; <-- DOOR HEIGHT HERE

  
  (vl-load-com)

  (setq mspace (vla-get-modelspace (vla-get-activedocument (vlax-get-acad-object))))

  (setq l1 (vla-addline mspace (vlax-3d-point pt1) (vlax-3d-point pt2)))
  (setq l2 (car (vlax-invoke l1 'Offset 12)))
  (setq l3 (car (vlax-invoke l1 'Offset -5)))

  (setq npt1 (vlax-curve-getstartpoint l2))
  (setq npt2 (vlax-curve-getstartpoint l3))

  (vla-delete l1)
  (vla-delete l2)
  (vla-delete l3)

  (setq txtobj1 (vla-addmtext mspace (vlax-3d-point npt1) 0 drstr))
  (vla-put-rotation txtobj1 drangle)
  (vla-put-height txtobj1 6) ; <-- TEXT HEIGHT HERE
  
  ;(vla-put-StyleName txtobj1 "AG_text_style")

  (setq txtobj2 (vla-addmtext mspace (vlax-3d-point npt2) 0 drstr))
  (vla-put-rotation txtobj2 drangle)
  (vla-put-height txtobj2 6) ; <-- TEXT HEIGHT HERE
  
  ;(vla-put-StyleName txtobj2 "AG_text_style")

  
  (setq loop 1)


  (while (= loop 1)
    
    (setq selection (entsel "\nClick dimension you want to keep	-->"))
    
    	(if (/= selection nil)
	  	(progn
		  (setq xselection (vlax-ename->vla-object (car selection)))

			(if (eq (vlax-vla-object->ename xselection) (vlax-vla-object->ename txtobj1))
			  	(progn
				  	(prompt "\nDoor dimension created")
				  	(vla-delete txtobj2)
				  	(setq loop 0)
				)
			)
		  
			(if (eq (vlax-vla-object->ename xselection) (vlax-vla-object->ename txtobj2))
			  	(progn
				  	(vla-delete txtobj1)
				  	(setq loop 0)
				)
			)
		)
	)	
)
    
  (princ)

)