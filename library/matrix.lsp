
(defmodule matrix
    (defpublic matrixp (x)
        (and (eq (class-of x) (class <general-array*>))
             (= (length (array-dimensions x)) 2)))

    (defpublic vectorp (x)
        (eq (class-of x) (class <general-vector>)))

    (defun matrix-add (x y)
        (let ((dx (array-dimensions x))
              (dy (array-dimensions y)) )
           (if (not (equal dx dy))
               (error "matrix-add: not adapted"))
           (let ((r (elt dx 0))
                 (c (elt dx 1))
                 (a (create-array dx)) )
              (for ((i 0 (+ i 1)))
                   ((= i r)
                    a )
                   (for ((j 0 (+ j 1)))
                        ((= j c))
                        (set-aref (+ (aref x i j) (aref y i j)) a i j))))))

    (defun matrix-sub (x y)
        (let ((dx (array-dimensions x))
              (dy (array-dimensions y)) )
           (if (not (equal dx dy))
               (error "matrix-sub: not adapted"))
           (let ((r (elt dx 0))
                 (c (elt dx 1))
                 (a (create-array dx)) )
              (for ((i 0 (+ i 1)))
                   ((= i r)
                    a )
                   (for ((j 0 (+ j 1)))
                        ((= j c))
                        (set-aref (- (aref x i j) (aref y i j)) a i j))))))

    (defun matrix-mult (x y)
        (let ((dx (array-dimensions x))
              (dy (array-dimensions y)) )
           (if (not (= (elt dx 1) (elt dy 0)))
               (error "matrix-nult: not adapted"))
           (let* ((r (elt dx 0))
                  (c (elt dy 1))
                  (m (elt dx 1))
                  (a (create-array (list r c))) )
               (for ((i 0 (+ i 1)))
                    ((= i r)
                     a )
                    (for ((j 0 (+ j 1)))
                         ((= j c))
                         (for ((k 0 (+ k 1))
                               (l 0) )
                              ((= k m)
                               (set-aref l a i j) )
                              (setq l (+ l (* (aref x i k) (aref y k j))))))))))

    

    (defpublic matrix-hadamard (x y)
        (let ((dx (array-dimensions x))
              (dy (array-dimensions y)) )
           (if (not (equal dx dy))
               (error "matrix-hadamard: not adapted"))
           (let ((r (elt dx 0))
                 (c (elt dx 1))
                 (a (create-array dx)) )
              (for ((i 0 (+ i 1)))
                   ((= i r)
                    a )
                   (for ((j 0 (+ j 1)))
                        ((= j c))
                        (set-aref (* (aref x i j) (aref y i j)) a i j))))))

    (defpublic matrix-transpose (x)
        (let* ((dx (array-dimensions x))
               (r (elt dx 0))
               (c (elt dx 1))
               (a (create-array (list c r))) )
            (for ((i 0 (+ i 1)))
                 ((= i r)
                  a )
                 (for ((j 0 (+ j 1)))
                      ((= j c))
                      (set-aref (aref x i j) a j i)))))

    (defpublic matrix-negate (x)
        (let* ((dx (array-dimensions x))
               (r (elt dx 0))
               (c (elt dx 1))
               (a (create-array dx)) )
            (for ((i 0 (+ i 1)))
                 ((= i r)
                  a )
                 (for ((j 0 (+ j 1)))
                      ((= j c))
                      (set-aref (* -1 (aref x i j)) a i j)))))

    (defpublic vector-dot (x y)
        (+ (* (elt x 0) (elt y 0))
           (* (elt x 1) (elt y 1))
           (* (elt x 2) (elt y 2))))

    (defpublic vector-cross (x y)
        (vector (- (* (elt x 1) (elt y 2)) (* (elt x 2) (elt y 1)))
                (- (* (elt x 2) (elt y 0)) (* (elt x 0) (elt y 2)))
                (- (* (elt x 0) (elt y 1)) (* (elt x 1) (elt y 0)))))

    
    (defun vector-add (x y)
        (let ((lx (length x))
              (ly (length y)))
            (if (/= lx ly) (error "vector-add not adapted"))
            (for ((i 0 (+ i 1))
                  (a (create-vector lx)))
                 ((= i lx) a)
                 (set-aref (+ (aref x i) (aref y i)) a i))))

    (defun vector-sub (x y)
        (let ((lx (length x))
              (ly (length y)))
            (if (/= lx ly) (error "vector-sub not adapted"))
            (for ((i 0 (+ i 1))
                  (a (create-vector lx)))
                 ((= i lx) a)
                 (set-aref (- (aref x i) (aref y i)) a i))))

    (defun vector-mult (s v)
        (let* ((l (length v))
               (a (create-vector l)))
            (for ((i 0 (+ i 1)))
                 ((= i l) a)
                 (set-aref (* s (aref v i)) a i))))

    (defpublic vector-norm (x)
        (sqrt (vectordot x x)))


    (defpublic matrix-elt (x i j)
        (aref x (- i 1) (- j 1)))

    (defpublic matrix-set-elt (v x i j)
        (set-aref v x (- i 1) (- j 1)))

    (defpublic add (x y)
        (cond ((and (matrixp x) (matrixp y)) (matrix-add x y))
              ((and (numberp x) (numberp y)) (+ x y))
              ((and (vectorp x) (vectorp y)) (vector-add x y))
              (t (error "add "))))

    (defpublic sub (x y)
        (cond ((and (matrixp x) (matrixp y)) (matrix-sub x y))
              ((and (numberp x) (numberp y)) (- x y))
              ((and (vectorp x) (vectorp y)) (vector-sub x y))
              (t (error "sub"))))

    (defpublic mult (x y)
        (cond ((and (matrixp x) (matrixp y)) (matrix-mult x y))
              ((and (numberp x) (numberp y)) (* x y))
              ((and (numberp x) (vectorp y)) (vector-mult x y))
              ((and (vectorp x) (numberp y)) (vector-mult y x))
              ((and (vectorp x) (matrixp y)) (matrix-mult (row-vector->matrix x) y))
              ((and (matrixp x) (vectorp y)) (matrix-mult x (column-vector->matrix y)))
              (t (error "mult"))))

    (defpublic rows (x)
        (let* ((dx (array-dimensions x))
               (r (elt dx 0))
               (c (elt dx 1))
               (a (create-vector r)) )
            (for ((i 0 (+ i 1)))
                 ((= i r)
                  a )
                 (for ((j 0 (+ j 1))
                       (v (create-vector c)) )
                      ((= j c)
                       (set-aref v a i) )
                      (set-aref (aref x i j) v j)))))

    (defpublic columns (x)
        (let* ((dx (array-dimensions x))
               (r (elt dx 0))
               (c (elt dx 1))
               (a (create-vector c)) )
            (for ((j 0 (+ j 1)))
                 ((= j c)
                  a )
                 (for ((i 0 (+ i 1))
                       (v (create-vector r)) )
                      ((= i r)
                       (set-aref v a j) )
                      (set-aref (aref x i j) v i)))))

    
    (defun row-vector->matrix (x)
        (let* ((l (length x))
               (a (create-array (list 1 l))))
            (for ((i 0 (+ i 1)))
                 ((= i l) a)
                 (set-aref (aref x i) a 0 i))))


    (defun column-vector->matrix (x)
        (let* ((l (length x))
               (a (create-array (list l 1))))
            (for ((i 0 (+ i 1)))
                 ((= i l) a)
                 (set-aref (aref x i) a i 0))))

    (defpublic square-matrix-p (x)
        (let ((dim (array-dimensions x)))
           (and (= (length dim) 2) (= (elt dim 0) (elt dim 1)))))

    ;;; calculate trace of matrix
    (defpublic matrix-tr (x)
        (unless (square-matrix-p x) (error "tr require square matrix" x))
        (let ((l (elt (array-dimensions x) 0)))
           (for ((i 1 (+ i 1))
                 (y 0) )
                ((> i l)
                 y )
                (setq y (+ (aref1 x i i) y)))))

    ;;; for determinant and inverse
    ;; original matrix
    (defglobal mat1 nil)
    ;; inverse matrix in inverse
    (defglobal mat2 nil)
    ;;; determinant of matrix
    (defpublic matrix-det (x)
        (det x))

    ;;; transform to upper triang and calculate product of diagonal
    (defun det (mat)
        (unless (square-matrix-p mat)
                (error "matrix-det not square matrix"))
        (let ((n (elt (array-dimensions mat) 0))
              (result 1) )
           (setq mat1 (rows mat))
           (setq mat2 (rows (ident n))) ; ignore mat2
           (exchange-zero-row n)
           (erase-lower-triang n)
           (for ((i 1 (+ i 1)))
                ((> i n)
                 (round result) )
                (setq result (* result (rowref1 mat1 i i))))))

    

    ;;; inverse Gauss sweep out method
    ;;; set element to matrix (index is start from 1)
    (defun set-aref1 (val mat i j)
        (set-aref val mat (- i 1) (- j 1)))

    ;;; get element from matrix (index is start from 1)
    (defun aref1 (mat i j)
        (aref mat (- i 1) (- j 1)))

    ;; access element (i,j) in rows matrix
    (defun rowref1 (mat i j)
        (elt (elt mat (- i 1)) (- j 1)))

    ;; ident matrix n*n
    (defun ident (n)
        (let ((mat (create-array (list n n) 0)))
           (for ((i 1 (+ i 1)))
                ((> i n)
                 mat )
                (set-aref1 1 mat i i))))

    ;; elementaly operations
    (defun exchange-row (i j)
        (let ((tmp1 (elt mat1 (- i 1)))
              (tmp2 (elt mat2 (- i 1))) )
           (set-elt (elt mat1 (- j 1)) mat1 (- i 1))
           (set-elt (elt mat2 (- j 1)) mat2 (- i 1))
           (set-elt tmp1 mat1 (- i 1))
           (set-elt tmp2 mat2 (- i 1))))

    ;; row(i) = row(i)-r*row(j)
    (defun sub-multed-row (i j r)
        (set-elt (sub (elt mat1 (- i 1)) (mult r (elt mat1 (- j 1))))
                 mat1
                 (- i 1))
        (set-elt (sub (elt mat2 (- i 1)) (mult r (elt mat2 (- j 1))))
                 mat2
                 (- i 1)))

    ;; row(i) = r*row(i)
    (defun mult-row (i r)
        (set-elt (mult r (elt mat1 (- i 1))) mat1 (- i 1))
        (set-elt (mult r (elt mat2 (- i 1))) mat2 (- i 1)))

    ;; inverse
    (defpublic matrix-inverse (mat)
        (inverse mat))

    (defun inverse (mat)
        (unless (square-matrix-p mat)
                (error "matrix-inverse not square matrix"))
        (let ((n (elt (array-dimensions mat) 0)))
           (setq mat1 (rows mat))
           (setq mat2 (rows (ident n)))
           (exchange-zero-row n)
           (erase-lower-triang n)
           (erase-upper-triang n)
           (normalize-diagonal n))
        (rows->matrix mat2))

    (defun exchange-zero-row (n)
        (for ((i 1 (+ i 1)))
             ((> i n))
             (if (= (rowref1 mat1 i i) 0)
                 (exchange-zero-row1 i n))))

    (defun exchange-zero-row1 (m n)
        (block exit
           (for ((i (+ m 1) (+ i 1)))
                ((> i n)
                 (error "matrix-inverse not regular matrix") )
                (cond ((/= (rowref1 mat1 i m) 0) (exchange-row i m) (return-from exit nil))))))

    

    (defun normalize-diagonal (n)
        (for ((i 1 (+ i 1)))
             ((> i n))
             (if (/= (rowref1 mat1 i i) 1)
                 (mult-row i (quotient 1 (rowref1 mat1 i i))))))

    (defun erase-lower-triang (n)
        (for ((i 1 (+ i 1)))
             ((> i n))
             (for ((j (+ i 1) (+ j 1)))
                  ((> j n))
                  (if (/= (rowref1 mat1 j i) 0)
                      (if (/= (rowref1 mat1 i i) 0)
                          (sub-multed-row j i (quotient (rowref1 mat1 j i) (rowref1 mat1 i i)))
                          (error "matrix-inverse not regular matrix"))))))

    (defun erase-upper-triang (n)
        (for ((i 2 (+ i 1)))
             ((> i n))
             (for ((j 1 (+ j 1)))
                  ((>= j i))
                  (if (/= (rowref1 mat1 j i) 0)
                      (if (/= (rowref1 mat1 i i) 0)
                          (sub-multed-row j i (quotient (rowref1 mat1 j i) (rowref1 mat1 i i)))
                          (error "matrix-inverse not regular matrix"))))))

    
)

