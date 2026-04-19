;;||=======================================||;;
;;||   AG Layer Color Legend Generator v3  ||;;
;;||   www.LetsBIMtogether.com             ||;;
;;||=======================================||;;
;;||
;;||   Command: LayCL

(vl-load-com)

;;----------------------------------------------------------
;; Error handler (top level, NOT nested inside c:LayCL)
;;----------------------------------------------------------
(defun LayCL-error (msg)
  (if (not (member msg '("Function cancelled" "quit / exit abort")))
    (princ (strcat "\nError: " msg))
  )
  (setvar "CMDECHO" 1)
  (princ)
)

;;----------------------------------------------------------
;; Readable color label
;;----------------------------------------------------------
(defun LayCL-color-label (c)
  (cond
    ((= c 1)  "Color 1 - Red")
    ((= c 2)  "Color 2 - Yellow")
    ((= c 3)  "Color 3 - Green")
    ((= c 4)  "Color 4 - Cyan")
    ((= c 5)  "Color 5 - Blue")
    ((= c 6)  "Color 6 - Magenta")
    ((= c 7)  "Color 7 - White/Black")
    ((= c 8)  "Color 8 - Dark Gray")
    ((= c 9)  "Color 9 - Light Gray")
    (t        (strcat "Color " (itoa c)))
  )
)

;;----------------------------------------------------------
;; Command
;;----------------------------------------------------------
(defun c:LayCL ( / *error* pt lay-list lay-name lay-color
                   lay-desc text-height spacing line-length
                   counter y x-line-start x-line-end x-text
                   mid-y lbl label-str)

  (setq *error* LayCL-error)

  (setq pt (getpoint "\nPick legend start point (top-left of lines): "))
  (if (null pt) (exit))

  (setq text-height  3.0
        spacing      5.0
        line-length  200.0)

  (setq x-line-start (car pt)
        x-line-end   (+ (car pt) line-length)
        x-text       (+ (car pt) line-length 5.0))

  (setq lay-list '())
  (vlax-for lay
    (vla-get-layers
      (vla-get-activedocument (vlax-get-acad-object)))
    (setq lay-list
      (append lay-list
        (list
          (list
            (vla-get-name        lay)
            (vla-get-color       lay)
            (vla-get-description lay)
          )
        )
      )
    )
  )

  (setq lay-list
    (vl-sort lay-list
      (function (lambda (a b)
        (< (strcase (car a)) (strcase (car b)))
      ))
    )
  )

  (setq counter 0)
  (setvar "CMDECHO" 0)

  (foreach entry lay-list
    (setq lay-name  (nth 0 entry)
          lay-color (nth 1 entry)
          lay-desc  (nth 2 entry))

    (if (or (= lay-color 0) (= lay-color 256))
      (setq lay-color 7)
    )

    (setq y     (+ (cadr pt) (* counter (- spacing)))
          mid-y (+ y (/ text-height 2.0))
          lbl   (LayCL-color-label lay-color)
          label-str
            (if (and lay-desc (not (equal lay-desc "")))
              (strcat lay-name "  |  " lbl "  |  " lay-desc)
              (strcat lay-name "  |  " lbl)
            )
    )

    (entmake
      (list
        '(0 . "LINE")
        (cons 10 (list x-line-start mid-y 0.0))
        (cons 11 (list x-line-end   mid-y 0.0))
        '(62 . 256)
        (cons 8  lay-name)
      )
    )

    (entmake
      (list
        '(0 . "TEXT")
        (cons 10 (list x-text y 0.0))
        (cons 11 (list x-text y 0.0))
        (cons 40 text-height)
        (cons 1  label-str)
        '(62 . 256)
        '(7 . "Standard")
        '(72 . 0)
        '(73 . 0)
        (cons 8  lay-name)
      )
    )

    (setq counter (1+ counter))
  )

  (setvar "CMDECHO" 1)

  (princ "\n====================================================")
  (princ (strcat "\n  Legend complete. " (itoa counter) " layers listed."))
  (princ "\n  Line length : 16'8\" (200 units)")
  (princ "\n  Row spacing : 5 units")
  (princ "\n  All items placed on their own layer, color and linetype by layer.")
  (princ "\n====================================================\n")
  (princ)
)
