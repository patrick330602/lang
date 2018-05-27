;; CS3500 HW#4
;; jwtxz Jinming Wu

(defun mylast (L)
    (if (cdr L)
        (mylast (cdr L))
        (car L)
    )
)

(defun myCount (X L)
    (if (eq X (car L))
        0
        (+ 1 (myCount X (cdr L)))
    )
)

(defun myMember (X L)
    (if L
        (if (eq X (car L))
            t
            (mymember X (cdr L))
        )
        nil
    )
)

(defun myPurge (L)
    (if L
        (if (myMember (car L) (cdr L))
            (myPurge (cdr L))
            (cons (car L) (myPurge (cdr L)))
        )
        ()
    )
)

(defun myCommon (L1 L2)
    (if L1
        (if (myMember (car L1) L2)
            (cons (car L1) (myCommon (cdr L1) L2))
            (myCommon (cdr L1) L2)
        )
        ()
    )
)

(defun myGen (X Y)
    (cond 
        ((> X Y) (cons X (myGen (+ X 1) Y)))
        ((= X Y) X)
        ((< X Y) ())
    )
)

(defun myMap (F L)
    (if L
        (cons (funcall F (car L)) (myMap F (cdr L)))
        ()
    )
)

(defun myReduce (F L)
    (if L
        (if (cdr L)
            (myReduce F
                (cons
                    (funcall F (car L) (car (cdr L)))
                    (cdr (cdr L))
                )
            )
            (car L)
        )
    )
)