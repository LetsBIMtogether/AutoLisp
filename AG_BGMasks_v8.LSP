;|------------------------------|;
;|	  AG Door Dimensions		|;
;|	  www.LetsBIMtogether.com	|;
;|------------------------------|;


;	Commands:
;	BGA - Add a background mask
;	BGR - Remove a background mask


(prompt "\nLoaded AG BG Masks!")

(defun c:bga()
  
  (vl-load-com)
  
  (while (= 1 1)
    
    (setq selection (entsel "\nSlect MTEXT you want to add a background mask to	-->"))
    
    (if (/= selection nil)
      (setq obj (vlax-ename->vla-object (car selection)))
      )

    (if (= (vla-get-ObjectName obj) "AcDbMText")
      (progn
	(vlax-put-property obj 'BackgroundFill :vlax-true)
	(setq ent (vlax-vla-object->ename obj))
	(setq elist (entget ent))
	(setq elist (subst (cons 45 1.25) (assoc 45 elist) elist))
	(entmod elist)
	);progn
      );if
    );while
  );end


(defun c:bgr()
  
  (vl-load-com)
  
  (while (= 1 1)
    
    (setq selection (entsel "\nSlect MTEXT you want to remove a background mask from -->"))
    
    (if (/= selection nil)
      (setq obj (vlax-ename->vla-object (car selection)))
      )

    (if (= (vla-get-ObjectName obj) "AcDbMText")
	(vlax-put-property obj 'BackgroundFill :vlax-false)
      );if
    );while
  );end
