;; simple calculator function generator

;;power function
(defun pwr (a b)
    (if (eq b 0)
      1 (* a (pwr a (- b 1))))
)

;;exponential function
(defun expo (a b)
    (* a (pwr 10 b))
)

;;calc helper
(defun calchlp (a)
    (cond 
        ((= a 1) '(lambda (b c) (+ b c)))
        ((= a 2) '(lambda (b c) (- b c)))
        ((= a 3) '(lambda (b c) (/ b c)))
        ((= a 4) '(lambda (b c) (* b c)))
        ((= a 5) '(lambda (b c) (pwr b c)))
        ((= a 6) '(lambda (b c) (expo b c)))
    )
)

(defun calc (a b c)
    (funcall (calchlp a) b c)
)
