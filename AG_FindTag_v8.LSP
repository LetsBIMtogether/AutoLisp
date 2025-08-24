;|------------------------------|;
;|	  AG Door Dimensions		|;
;|	  www.LetsBIMtogether.com	|;
;|------------------------------|;


; 	Command: FindTag
; 	Format : <ATTRIBUTE 1>/<ATTRIBUTE 2>
; 	Example: FindTag <HIT ENTER> 3/A-5


; 	This Lisp routine will take a user input, and then extract 2 attributes out of it, seperated 
; 	by a '/' symbol. Then it will zoom to every detail tag that contains both of those attributes.


(prompt "\nLoaded AG FindTag!")

(defun c:FindTag
       (/ Str Str2 StrInput ObjType Obj Att Matches TotalFound)
  
(defun ZoomTo (Obj)
  (command "_.zoom" "_object" (vlax-vla-object->ename Obj) "")
  (while
    (/=	(getstring "\n\t\t\t\t\t\tPress enter to proceed to next tag\t\t\t -->") "")
  )					
);defun
  
(defun str->lst	(str del / len lst pos)
  (setq len (1+ (strlen del)))
  (while (setq pos (vl-string-search del str))
    (setq lst (cons (substr str 1 pos) lst)
	  str (substr str (+ pos len))
    )
  )
  (reverse (cons str lst))
);defun

  (setq TotalFound 0)

  (if (/= (setq	StrInput (strcase (getstring "\nEnter the detail to search for: (Example: 3/A-2, or 4/A1.00)\t\t  --> ")))"")
    (progn

      (setq Str (nth 0 (str->lst StrInput "/")))
      (setq Str2 (nth 1 (str->lst StrInput "/")))
      
      (vlax-for	Obj (vla-get-Block (vla-get-ActiveLayout (vla-get-ActiveDocument (vlax-get-Acad-Object))))
	
	(setq ObjType (vla-get-ObjectName Obj))
	(setq Matches 0)

	(if (= ObjType "AcDbBlockReference")
	  (foreach Att (vlax-invoke Obj 'GetAttributes)
	    (if	(or (= (strcase (vla-get-TextString Att)) Str)
		    (= (strcase (vla-get-TextString Att)) Str2))
	      (progn
		
		(setq Matches (+ Matches 1))

		(if (= Matches 2)
		  (progn
		    (princ "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t   Found tag!")
		    (setq TotalFound (+ TotalFound 1))
		    (ZoomTo Att)
		  );progn
		);if
	      );progn
	    );if
	  );foreach
	);if obj type
      );vlax-for
    );progn
  );if

  (prompt "\n")
  (prompt "\n------------------------------------------------------------------------------------------")
  (prompt "\n\t\t\t\t\t\tWent through all of the tags!")
  (princ (strcat "\n\t\t\t\t\t\tTotal Found: " (itoa TotalFound)))
  (prompt "\n------------------------------------------------------------------------------------------")
  (prompt "\n")
  (princ)
)