;;; factorize
;;; n = p*q. p <> q, p and q is near prime number.
;;; e.g. 100000007 * 100000039 = 10000004600000273
;;; 1000037 * 100000039 = 100003739001443
;;; 1000000009 * 1000000063 = 1000000072000000567
;;; 10000000033 * 10000000019 = 100000000520000000627
;;; add option to (mp-part opt arg1 arg2 ... argn)
;;; mp-part option arder. in order if recieve not nil, return it and send ctrl+c to rest process.

;;para
(defun factors* (n)
    (let* ((limit (isqrt n))
           (span (+ (div limit 5) 1))
           (p (mp-part order (cofactor n 3 span)
                             (cofactor n (near-odd span) (* 2 span))
                             (cofactor n (near-odd (* 2 span)) (* 3 span))
                             (cofactor n (near-odd (* 3 span)) (* 4 span))
                             (cofactor n (near-odd (* 4 span)) (* 5 span)))))
                (list p (vid n p))))

(defun cofactor (n s e)
    (cond ((> s e) nil)
          ((= (mod n s) 0) s)
          (t (cofactor n (+ s 2) e))))

(defun near-odd (n)
    (if (= (mod n 2) 0)
        (- n 1)
        n))


;; sequence
(defun factors (n)
    (cond ((= (mod n 2) 0) (cons 2 (factors1 (div n 2) 3 (isqrt (div n 2)))))
          (t (factors1 n 3 (isqrt n)))))

(defun factors1 (n s e)
    (cond ((> s e) (list n))
          ((= (mod n s) 0) (cons s (factors1 (div n s) s (isqrt (div n s)))))
          (t (factors1 n (+ s 2) e))))
