;;multi-process

;(mp-create 3)

(defun foo (x y)
    (mp-call #'+ (fib x) (fib y)))

(defun bar (x y)
    (mp-exec (fib x) (fib y)))

(defun boo (x y)
    (mp-let ((a (fib x))
             (b (fib y)))
        (+ a b)))

(defun tarai* (x y z)
    (if (<= x y)
        y
        (mp-call #'tarai* (tarai (- x 1) y z) 
                          (tarai (- y 1) z x)
                          (tarai (- z 1) x y))))

(defun tarai (x y z)
    (if (<= x y)
        y
        (tarai (tarai (- x 1) y z)
               (tarai (- y 1) z x)
               (tarai (- z 1) x y))))



(defun fib* (n)
    (mp-call #'+ (fib (- n 1))
                 (fib (- n 2))))


(defun fib (n)
    (cond ((= n 1) 1)
          ((= n 2) 1)
          (t (+ (fib (- n 1)) (fib (- n 2)))) ))

;(mp-close)



