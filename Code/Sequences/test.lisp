(in-package #:sicl-sequences-test)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Objects that can be used in various tests.

;;; Define large integers, the point being that bignums that are eql
;;; might not be eq, allowing us to distinguish those two cases.

;;; Define a large value, hopefully a bignum.
(defparameter *i01* #.(expt 10 100))

;;; Define the same large value, hoping that the compiler
;;; will keep them apart, so they aren't eq.  Tests won't
;;; fail if that is not true, but they might give false positives. 
(defparameter *i02* #.(expt 10 100))

;;; Define a few more large distinct values

(defparameter *i1* #.(+ (expt 10 100) 1))
(defparameter *i2* #.(+ (expt 10 100) 2))
(defparameter *i3* #.(+ (expt 10 100) 3))
(defparameter *i4* #.(+ (expt 10 100) 4))
(defparameter *i5* #.(+ (expt 10 100) 5))
(defparameter *i6* #.(+ (expt 10 100) 6))
(defparameter *i7* #.(+ (expt 10 100) 7))
(defparameter *i8* #.(+ (expt 10 100) 8))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function find

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eql key=identity 1a|
  (let ((element '(1)))
    (assert-equal
     nil
     (find element '()))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eql key=identity 1b|
  (let ((element '(1)))
    (assert-equal
     nil
     (find element '() :test #'eql))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eql key=identity 1c|
  (let ((element '(1)))
    (assert-equal
     nil
     (find element '() :test 'eql))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eql key=identity 2a|
  (assert-equal
   1
   (find 1 '(0 1 2))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eql key=identity 2b|
  (assert-equal
   1
   (find 1 '(0 1 2) :test #'eql)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eql key=identity 2c|
  (assert-equal
   1
   (find 1 '(0 1 2) :test 'eql)))

(define-test |find seq-type=list start=error from-end=nil test=eql key=identity 2a|
  (assert-error 'type-error
		(find 1 '(0 1 2) :start 'a)))

(define-test |find seq-type=list start=error from-end=nil test=eql key=identity 2b|
  (assert-error 'type-error
		(find 1 '(0 1 2) :test #'eql :start 4)))

(define-test |find seq-type=list start=error from-end=nil test=eql key=identity 2c|
  (assert-error 'type-error
		(find 1 '(0 1 2) :test #'eql :start -1)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eql key=other 1a|
  (let ((element '(1)))
    (assert-equal
     nil
     (find element '() :key #'1+))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eql key=other 1b|
  (let ((element '(1)))
    (assert-equal
     nil
     (find element '() :test #'eql :key #'1+))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eql key=other 1c|
  (let ((element '(1)))
    (assert-equal
     nil
     (find element '() :test 'eql :key #'1+))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eql key=other 2a|
  (assert-equal
   1
   (find 2 '(0 1 2) :key #'1+)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eql key=other 2b|
  (assert-equal
   1
   (find 2 '(0 1 2) :test #'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eql key=other 2a|
  (assert-equal
   1
   (find 2 '(0 1 2) :test 'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eql key=identity error 1a|
  (assert-error 'type-error
		(find 3 '(0 1 . 2))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eql key=identity error 1b|
  (assert-error 'type-error
		(find 3 '(0 1 . 2) :test #'eql)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eql key=identity error 1c|
  (assert-error 'type-error
		(find 3 '(0 1 . 2) :test 'eql)))

(define-test |find seq-type=list start=other from-end=nil test=eql key=identity error 1a|
  (assert-error 'type-error
		(find 3 '(0 1 . 2) :start 2)))

(define-test |find seq-type=list start=other from-end=nil test=eql key=identity error 1b|
  (assert-error 'type-error
		(find 3 '(0 1 . 2) :start 2 :test #'eql)))

(define-test |find seq-type=list start=other from-end=nil test=eql key=identity error 1c|
  (assert-error 'type-error
		(find 3 '(0 1 . 2) :start 2 :test 'eql)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eq key=identity error 1a|
  (let ((element '(a)))
    (assert-eq
     nil
     (find element '() :test #'eq))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eq key=identity 1b|
  (let ((element '(a)))
    (assert-eq
     nil
     (find element '() :test 'eq))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eq key=identity 2|
  (let ((element (copy-tree '(a))))
    (assert-eq
     nil
     (find element '((a)) :test #'eq))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eq key=identity 3|
  (let ((element (copy-tree '(a))))
    (assert-eq
     element
     (find element (list '(a) element '(a)) :test #'eq))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test=eq key=identity 4|
  (let ((element (copy-tree '(a))))
    (assert-error
     'type-error
     (find element (list* '(a) '(a) '(a) 'b) :test #'eq))))

(define-test |find seq-type=list start=other from-end=nil test=eq key=identity 1|
  (let ((element (copy-tree '(a))))
    (assert-eq
     element
     (find element (list '(a) element '(a)) :test #'eq :start 1))))

(define-test |find seq-type=list start=other from-end=nil test=eq key=identity 2|
  (let ((element (copy-tree '(a))))
    (assert-eq
     element
     (find element (list '(a) element '(a)) :test #'eq :start 1))))

(define-test |find seq-type=list start=other from-end=nil test=eq key=identity 3|
  (let ((element (copy-tree '(a))))
    (assert-error
     'type-error
     (find element (list* '(a) element '(a)  'b) :test #'eq :start 2))))

(define-test |find seq-type=list start=other from-end=nil test=eq key=other 1|
  (let ((element (copy-tree '(a))))
    (assert-eq
     element
     (car (find element (list '((a)) (list element) '((a)))
		:test #'eq :start 1 :key #'car)))))

(define-test |find seq-type=list start=other from-end=nil test=eq key=other 2|
  (let ((element (copy-tree '(a))))
    (assert-eq
     element
     (car (find element (list '((a)) (list element) '((a)))
		:test #'eq :start 1 :key #'car)))))

(define-test |find seq-type=list start=other from-end=nil test=eq key=other 3|
  (let ((element (copy-tree '(a))))
    (assert-error
     'type-error
     (car (find element (list* '((a)) (list element) '((a)) 'b)
		:test #'eq :start 2 :key #'car)))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eql key=identity 1a|
  (assert-equal
   1
   (find 0 '(0 1 2) :test-not #'eql)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eql key=identity 1b|
  (assert-equal
   1
   (find 0 '(0 1 2) :test-not 'eql)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eql key=identity 2a|
  (assert-equal
   nil
   (find 0 '(0 0 0) :test-not #'eql)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eql key=identity 2b|
  (assert-equal
   nil
   (find 0 '(0 0 0) :test-not 'eql)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eql key=other 1a|
  (assert-equal
   1
   (find 1 '(0 1 2) :test-not #'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eql key=other 1b|
  (assert-equal
   1
   (find 1 '(0 1 2) :test-not 'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eql key=other 2a|
  (assert-equal
   nil
   (find 1 '(0 0 0) :test-not #'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eql key=other 2b|
  (assert-equal
   nil
   (find 1 '(0 0 0) :test-not 'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eq key=identity 1a|
  (assert-equal
   'a
   (find 'z '(z a b) :test-not #'eq)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eq key=identity 1b|
  (assert-equal
   'a
   (find 'z '(z a b) :test-not 'eq)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eq key=identity 2a|
  (assert-equal
   nil
   (find 'z '(z z z) :test-not #'eq)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eq key=identity 2b|
  (assert-equal
   nil
   (find 'z '(z z z) :test-not 'eq)))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eq key=other 1a|
  (assert-equal
   'a
   (find 'a '(z a b) :test-not #'eq :key (lambda (x) (case x (z 'a) (a 'b) (b 'c))))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eq key=other 1b|
  (assert-equal
   'a
   (find 'a '(z a b) :test-not 'eq :key (lambda (x) (case x (z 'a) (a 'b) (b 'c))))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eq key=other 2a|
  (assert-equal
   nil
   (find 'a '(z z z) :test-not #'eq :key (lambda (x) (case x (z 'a) (a 'b) (b 'c))))))

(define-test |find seq-type=list start=0 end=nil from-end=nil test-not=eq key=other 2b|
  (assert-equal
   nil
   (find 'a '(z z z) :test-not 'eq :key (lambda (x) (case x (z 'a) (a 'b) (b 'c))))))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eql key=identity 1a|
  (assert-equal
   nil
   (find 1 '(0 1 2) :end 1)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eql key=identity 1b|
  (assert-equal
   nil
   (find 1 '(0 1 2) :end 1 :test #'eql)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eql key=identity 1c|
  (assert-equal
   nil
   (find 1 '(0 1 2) :end 1 :test 'eql)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eql key=identity 2a|
  (assert-equal
   1
   (find 1 '(0 1 2) :end 2)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eql key=identity 2b|
  (assert-equal
   1
   (find 1 '(0 1 2) :end 2 :test #'eql)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eql key=identity 2c|
  (assert-equal
   1
   (find 1 '(0 1 2) :end 2 :test 'eql)))

(define-test |find seq-type=list start=0 end=error from-end=nil test=eql key=identity 1a|
  (assert-error 'type-error
		(find 3 '(0 1 2) :end 4)))

(define-test |find seq-type=list start=0 end=error from-end=nil test=eql key=identity 1b|
  (assert-error 'type-error
		(find 3 '(0 1 2) :end 4 :test #'eql)))

(define-test |find seq-type=list start=0 end=error from-end=nil test=eql key=identity 1c|
  (assert-error 'type-error
		(find 3 '(0 1 2) :end 4 :test 'eql)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eql key=other 1a|
  (assert-equal
   nil
   (find 2 '(0 1 2) :end 1 :key #'1+)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eql key=other 1b|
  (assert-equal
   nil
   (find 2 '(0 1 2) :end 1 :test #'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eql key=other 1c|
  (assert-equal
   nil
   (find 2 '(0 1 2) :end 1 :test 'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eql key=other 2a|
  (assert-equal
   1
   (find 2 '(0 1 2) :end 2 :key #'1+)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eql key=other 2b|
  (assert-equal
   1
   (find 2 '(0 1 2) :end 2 :test #'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eql key=other 2c|
  (assert-equal
   1
   (find 2 '(0 1 2) :end 2 :test 'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=error from-end=nil test=eql key=other 1a|
  (assert-error 'type-error
		(find 4 '(0 1 2) :end 4 :key #'1+)))

(define-test |find seq-type=list start=0 end=error from-end=nil test=eql key=other 1b|
  (assert-error 'type-error
		(find 4 '(0 1 2) :end 4 :test #'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=error from-end=nil test=eql key=other 1c|
  (assert-error 'type-error
		(find 4 '(0 1 2) :end 4 :test 'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eq key=identity 1b|
  (assert-equal
   nil
   (find 'b '(a b c) :end 1 :test #'eq)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eq key=identity 1c|
  (assert-equal
   nil
   (find 'b '(a b c) :end 1 :test 'eq)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eq key=identity 2b|
  (assert-equal
   'b
   (find 'b '(a b c) :end 2 :test #'eq)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eq key=identity 2c|
  (assert-equal
   'b
   (find 'b '(a b c) :end 2 :test 'eq)))

(define-test |find seq-type=list start=0 end=error from-end=nil test=eq key=identity 1b|
  (assert-error 'type-error
		(find 'd '(a b c) :end 4 :test #'eq)))

(define-test |find seq-type=list start=0 end=error from-end=nil test=eq key=identity 1c|
  (assert-error 'type-error
		(find 'd '(a b c) :end 4 :test 'eq)))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eq key=other 1b|
  (assert-equal
   nil
   (find 'c '(a b c) :end 1 :test #'eq :key (lambda (x) (case x (a 'b) (b 'c) (c 'd))))))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eq key=other 1c|
  (assert-equal
   nil
   (find 'c '(a b c) :end 1 :test 'eq :key (lambda (x) (case x (a 'b) (b 'c) (c 'd))))))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eq key=other 2b|
  (assert-equal
   'b
   (find 'c '(a b c) :end 2 :test #'eq :key (lambda (x) (case x (a 'b) (b 'c) (c 'd))))))

(define-test |find seq-type=list start=0 end=other from-end=nil test=eq key=other 2c|
  (assert-equal
   'b
   (find 'c '(a b c) :end 2 :test 'eq :key (lambda (x) (case x (a 'b) (b 'c) (c 'd))))))

(define-test |find seq-type=list start=0 end=error from-end=nil test=eq key=other 1b|
  (assert-error 'type-error
		(find 'e '(a b c) :end 4 :test #'eq :key (lambda (x) (case x (a 'b) (b 'c) (c 'd))))))

(define-test |find seq-type=list start=0 end=error from-end=nil test=eq key=other 1c|
  (assert-error 'type-error
		(find 'e '(a b c) :end 4 :test 'eq :key (lambda (x) (case x (a 'b) (b 'c) (c 'd))))))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eql key=identity 1a|
  (assert-equal
   nil
   (find '1 '(1 1 1) :end 2 :test-not #'eql)))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eql key=identity 1b|
  (assert-equal
   nil
   (find '1 '(1 1 1) :end 2 :test-not 'eql)))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eql key=identity 2a|
  (assert-equal
   2
   (find '1 '(1 2 1) :end 2 :test-not #'eql)))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eql key=identity 2b|
  (assert-equal
   2
   (find '1 '(1 2 1) :end 2 :test-not 'eql)))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eql key=other 1a|
  (assert-equal
   nil
   (find '2 '(1 1 1) :end 2 :test-not #'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eql key=other 1b|
  (assert-equal
   nil
   (find '2 '(1 1 1) :end 2 :test-not 'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eql key=other 2a|
  (assert-equal
   2
   (find '2 '(1 2 1) :end 2 :test-not #'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eql key=other 2b|
  (assert-equal
   2
   (find '2 '(1 2 1) :end 2 :test-not 'eql :key #'1+)))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eq key=identity 1a|
  (assert-equal
   nil
   (find 'a '(a a a) :end 2 :test-not #'eq)))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eq key=identity 1b|
  (assert-equal
   nil
   (find 'a '(a a a) :end 2 :test-not 'eq)))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eq key=identity 2a|
  (assert-equal
   'b
   (find 'a '(a b a) :end 2 :test-not #'eq)))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eq key=identity 2b|
  (assert-equal
   'b
   (find 'a '(a b a) :end 2 :test-not 'eq)))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eq key=other 1a|
  (assert-equal
   nil
   (find 'b '(a a a) :end 2 :test-not #'eq :key (lambda (x) (case x (a 'b) (b 'c))))))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eq key=other 1b|
  (assert-equal
   nil
   (find 'b '(a a a) :end 2 :test-not 'eq :key (lambda (x) (case x (a 'b) (b 'c))))))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eq key=other 2a|
  (assert-equal
   'b
   (find 'b '(a b a) :end 2 :test-not #'eq :key (lambda (x) (case x (a 'b) (b 'c))))))

(define-test |find seq-type=list start=0 end=other from-end=nil test-not=eq key=other 2b|
  (assert-equal
   'b
   (find 'b '(a b a) :end 2 :test-not 'eq :key (lambda (x) (case x (a 'b) (b 'c))))))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eql key=identity 1a|
  (let ((element '(1)))
    (assert-equal
     nil
     (find element #()))))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eql key=identity 1b|
  (let ((element '(1)))
    (assert-equal
     nil
     (find element #() :test #'eql))))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eql key=identity 1c|
  (let ((element '(1)))
    (assert-equal
     nil
     (find element #() :test 'eql))))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eql key=identity 2a|
  (assert-equal
   1
   (find 1 #(0 1 2))))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eql key=identity 2b|
  (assert-equal
   1
   (find 1 #(0 1 2) :test #'eql)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eql key=identity 2c|
  (assert-equal
   1
   (find 1 #(0 1 2) :test 'eql)))

(define-test |find seq-type=vector start=error from-end=nil test=eql key=identity 2a|
  (assert-error 'type-error
		(find 1 #(0 1 2) :start 'a)))

(define-test |find seq-type=vector start=error from-end=nil test=eql key=identity 2b|
  (assert-error 'type-error
		(find 1 #(0 1 2) :test #'eql :start 4)))

(define-test |find seq-type=vector start=error from-end=nil test=eql key=identity 2c|
  (assert-error 'type-error
		(find 1 #(0 1 2) :test #'eql :start -1)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eql key=other 1a|
  (let ((element '(1)))
    (assert-equal
     nil
     (find element #() :key #'1+))))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eql key=other 1b|
  (let ((element '(1)))
    (assert-equal
     nil
     (find element #() :test #'eql :key #'1+))))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eql key=other 1c|
  (let ((element '(1)))
    (assert-equal
     nil
     (find element #() :test 'eql :key #'1+))))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eql key=other 2a|
  (assert-equal
   1
   (find 2 #(0 1 2) :key #'1+)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eql key=other 2b|
  (assert-equal
   1
   (find 2 #(0 1 2) :test #'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eql key=other 2a|
  (assert-equal
   1
   (find 2 #(0 1 2) :test 'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eq key=identity error 1a|
  (let ((element '(a)))
    (assert-eq
     nil
     (find element #() :test #'eq))))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eq key=identity 1b|
  (let ((element '(a)))
    (assert-eq
     nil
     (find element #() :test 'eq))))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eq key=identity 2|
  (let ((element (copy-tree '(a))))
    (assert-eq
     nil
     (find element #((a)) :test #'eq))))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test=eq key=identity 3|
  (let ((element (copy-tree '(a))))
    (assert-eq
     element
     (find element (vector '(a) element '(a)) :test #'eq))))

(define-test |find seq-type=vector start=other from-end=nil test=eq key=identity 1|
  (let ((element (copy-tree '(a))))
    (assert-eq
     element
     (find element (vector '(a) element '(a)) :test #'eq :start 1))))

(define-test |find seq-type=vector start=other from-end=nil test=eq key=identity 2|
  (let ((element (copy-tree '(a))))
    (assert-eq
     element
     (find element (vector '(a) element '(a)) :test #'eq :start 1))))

(define-test |find seq-type=vector start=other from-end=nil test=eq key=other 1|
  (let ((element (copy-tree '(a))))
    (assert-eq
     element
     (car (find element (vector '((a)) (list element) '((a)))
		:test #'eq :start 1 :key #'car)))))

(define-test |find seq-type=vector start=other from-end=nil test=eq key=other 2|
  (let ((element (copy-tree '(a))))
    (assert-eq
     element
     (car (find element (vector '((a)) (list element) '((a)))
		:test #'eq :start 1 :key #'car)))))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eql key=identity 1a|
  (assert-equal
   1
   (find 0 #(0 1 2) :test-not #'eql)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eql key=identity 1b|
  (assert-equal
   1
   (find 0 #(0 1 2) :test-not 'eql)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eql key=identity 2a|
  (assert-equal
   nil
   (find 0 #(0 0 0) :test-not #'eql)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eql key=identity 2b|
  (assert-equal
   nil
   (find 0 #(0 0 0) :test-not 'eql)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eql key=other 1a|
  (assert-equal
   1
   (find 1 #(0 1 2) :test-not #'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eql key=other 1b|
  (assert-equal
   1
   (find 1 #(0 1 2) :test-not 'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eql key=other 2a|
  (assert-equal
   nil
   (find 1 #(0 0 0) :test-not #'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eql key=other 2b|
  (assert-equal
   nil
   (find 1 #(0 0 0) :test-not 'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eq key=identity 1a|
  (assert-equal
   'a
   (find 'z #(z a b) :test-not #'eq)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eq key=identity 1b|
  (assert-equal
   'a
   (find 'z #(z a b) :test-not 'eq)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eq key=identity 2a|
  (assert-equal
   nil
   (find 'z #(z z z) :test-not #'eq)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eq key=identity 2b|
  (assert-equal
   nil
   (find 'z #(z z z) :test-not 'eq)))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eq key=other 1a|
  (assert-equal
   'a
   (find 'a #(z a b) :test-not #'eq :key (lambda (x) (case x (z 'a) (a 'b) (b 'c))))))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eq key=other 1b|
  (assert-equal
   'a
   (find 'a #(z a b) :test-not 'eq :key (lambda (x) (case x (z 'a) (a 'b) (b 'c))))))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eq key=other 2a|
  (assert-equal
   nil
   (find 'a #(z z z) :test-not #'eq :key (lambda (x) (case x (z 'a) (a 'b) (b 'c))))))

(define-test |find seq-type=vector start=0 end=nil from-end=nil test-not=eq key=other 2b|
  (assert-equal
   nil
   (find 'a #(z z z) :test-not 'eq :key (lambda (x) (case x (z 'a) (a 'b) (b 'c))))))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eql key=identity 1a|
  (assert-equal
   nil
   (find 1 #(0 1 2) :end 1)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eql key=identity 1b|
  (assert-equal
   nil
   (find 1 #(0 1 2) :end 1 :test #'eql)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eql key=identity 1c|
  (assert-equal
   nil
   (find 1 #(0 1 2) :end 1 :test 'eql)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eql key=identity 2a|
  (assert-equal
   1
   (find 1 #(0 1 2) :end 2)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eql key=identity 2b|
  (assert-equal
   1
   (find 1 #(0 1 2) :end 2 :test #'eql)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eql key=identity 2c|
  (assert-equal
   1
   (find 1 #(0 1 2) :end 2 :test 'eql)))

(define-test |find seq-type=vector start=0 end=error from-end=nil test=eql key=identity 1a|
  (assert-error 'type-error
		(find 3 #(0 1 2) :end 4)))

(define-test |find seq-type=vector start=0 end=error from-end=nil test=eql key=identity 1b|
  (assert-error 'type-error
		(find 3 #(0 1 2) :end 4 :test #'eql)))

(define-test |find seq-type=vector start=0 end=error from-end=nil test=eql key=identity 1c|
  (assert-error 'type-error
		(find 3 #(0 1 2) :end 4 :test 'eql)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eql key=other 1a|
  (assert-equal
   nil
   (find 2 #(0 1 2) :end 1 :key #'1+)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eql key=other 1b|
  (assert-equal
   nil
   (find 2 #(0 1 2) :end 1 :test #'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eql key=other 1c|
  (assert-equal
   nil
   (find 2 #(0 1 2) :end 1 :test 'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eql key=other 2a|
  (assert-equal
   1
   (find 2 #(0 1 2) :end 2 :key #'1+)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eql key=other 2b|
  (assert-equal
   1
   (find 2 #(0 1 2) :end 2 :test #'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eql key=other 2c|
  (assert-equal
   1
   (find 2 #(0 1 2) :end 2 :test 'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=error from-end=nil test=eql key=other 1a|
  (assert-error 'type-error
		(find 4 #(0 1 2) :end 4 :key #'1+)))

(define-test |find seq-type=vector start=0 end=error from-end=nil test=eql key=other 1b|
  (assert-error 'type-error
		(find 4 #(0 1 2) :end 4 :test #'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=error from-end=nil test=eql key=other 1c|
  (assert-error 'type-error
		(find 4 #(0 1 2) :end 4 :test 'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eq key=identity 1b|
  (assert-equal
   nil
   (find 'b #(a b c) :end 1 :test #'eq)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eq key=identity 1c|
  (assert-equal
   nil
   (find 'b #(a b c) :end 1 :test 'eq)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eq key=identity 2b|
  (assert-equal
   'b
   (find 'b #(a b c) :end 2 :test #'eq)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eq key=identity 2c|
  (assert-equal
   'b
   (find 'b #(a b c) :end 2 :test 'eq)))

(define-test |find seq-type=vector start=0 end=error from-end=nil test=eq key=identity 1b|
  (assert-error 'type-error
		(find 'd #(a b c) :end 4 :test #'eq)))

(define-test |find seq-type=vector start=0 end=error from-end=nil test=eq key=identity 1c|
  (assert-error 'type-error
		(find 'd #(a b c) :end 4 :test 'eq)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eq key=other 1b|
  (assert-equal
   nil
   (find 'c #(a b c) :end 1 :test #'eq :key (lambda (x) (case x (a 'b) (b 'c) (c 'd))))))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eq key=other 1c|
  (assert-equal
   nil
   (find 'c #(a b c) :end 1 :test 'eq :key (lambda (x) (case x (a 'b) (b 'c) (c 'd))))))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eq key=other 2b|
  (assert-equal
   'b
   (find 'c #(a b c) :end 2 :test #'eq :key (lambda (x) (case x (a 'b) (b 'c) (c 'd))))))

(define-test |find seq-type=vector start=0 end=other from-end=nil test=eq key=other 2c|
  (assert-equal
   'b
   (find 'c #(a b c) :end 2 :test 'eq :key (lambda (x) (case x (a 'b) (b 'c) (c 'd))))))

(define-test |find seq-type=vector start=0 end=error from-end=nil test=eq key=other 1b|
  (assert-error 'type-error
		(find 'e #(a b c) :end 4 :test #'eq :key (lambda (x) (case x (a 'b) (b 'c) (c 'd))))))

(define-test |find seq-type=vector start=0 end=error from-end=nil test=eq key=other 1c|
  (assert-error 'type-error
		(find 'e #(a b c) :end 4 :test 'eq :key (lambda (x) (case x (a 'b) (b 'c) (c 'd))))))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eql key=identity 1a|
  (assert-equal
   nil
   (find '1 #(1 1 1) :end 2 :test-not #'eql)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eql key=identity 1b|
  (assert-equal
   nil
   (find '1 #(1 1 1) :end 2 :test-not 'eql)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eql key=identity 2a|
  (assert-equal
   2
   (find '1 #(1 2 1) :end 2 :test-not #'eql)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eql key=identity 2b|
  (assert-equal
   2
   (find '1 #(1 2 1) :end 2 :test-not 'eql)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eql key=other 1a|
  (assert-equal
   nil
   (find '2 #(1 1 1) :end 2 :test-not #'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eql key=other 1b|
  (assert-equal
   nil
   (find '2 #(1 1 1) :end 2 :test-not 'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eql key=other 2a|
  (assert-equal
   2
   (find '2 #(1 2 1) :end 2 :test-not #'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eql key=other 2b|
  (assert-equal
   2
   (find '2 #(1 2 1) :end 2 :test-not 'eql :key #'1+)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eq key=identity 1a|
  (assert-equal
   nil
   (find 'a #(a a a) :end 2 :test-not #'eq)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eq key=identity 1b|
  (assert-equal
   nil
   (find 'a #(a a a) :end 2 :test-not 'eq)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eq key=identity 2a|
  (assert-equal
   'b
   (find 'a #(a b a) :end 2 :test-not #'eq)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eq key=identity 2b|
  (assert-equal
   'b
   (find 'a #(a b a) :end 2 :test-not 'eq)))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eq key=other 1a|
  (assert-equal
   nil
   (find 'b #(a a a) :end 2 :test-not #'eq :key (lambda (x) (case x (a 'b) (b 'c))))))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eq key=other 1b|
  (assert-equal
   nil
   (find 'b #(a a a) :end 2 :test-not 'eq :key (lambda (x) (case x (a 'b) (b 'c))))))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eq key=other 2a|
  (assert-equal
   'b
   (find 'b #(a b a) :end 2 :test-not #'eq :key (lambda (x) (case x (a 'b) (b 'c))))))

(define-test |find seq-type=vector start=0 end=other from-end=nil test-not=eq key=other 2b|
  (assert-equal
   'b
   (find 'b #(a b a) :end 2 :test-not 'eq :key (lambda (x) (case x (a 'b) (b 'c))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function find-if

(define-test find-if-list.1
  (assert-equal 'nil
                (find-if #'identity ())))

(define-test find-if-list.2
  (assert-equal 'a
                (find-if #'identity '(a))))

(define-test find-if-list.2a
  (assert-equal 'a
                (find-if 'identity '(a))))

(define-test find-if-list.3
  (assert-equal '2
                (find-if #'evenp '(1 2 4 8 3 1 6 7))))

(define-test find-if-list.4
  (assert-equal '6
                (find-if #'evenp '(1 2 4 8 3 1 6 7) :from-end t)))

(define-test find-if-list.5
  (assert-equal '(2 2 4 8 6 6 6 nil)
                (loop for i from 0 to 7 collect
                  (find-if #'evenp '(1 2 4 8 3 1 6 7) :start i))))

(define-test find-if-list.6
  (assert-equal '(2 2 4 8 6 6 6 nil)
                (loop for i from 0 to 7 collect
                  (find-if #'evenp '(1 2 4 8 3 1 6 7) :start i :end nil))))

(define-test find-if-list.7
  (assert-equal '(6 6 6 6 6 6 6 nil)
                (loop for i from 0 to 7 collect
                  (find-if #'evenp '(1 2 4 8 3 1 6 7) :start i :from-end t))))

(define-test find-if-list.8
  (assert-equal '(6 6 6 6 6 6 6 nil)
                (loop for i from 0 to 7 collect
                  (find-if #'evenp '(1 2 4 8 3 1 6 7) :start i :end nil :from-end t))))

(define-test find-if-list.9
  (assert-equal '(nil nil 2 2 2 2 2 2 2)
                (loop for i from 0 to 8 collect
                  (find-if #'evenp '(1 2 4 8 3 1 6 7) :end i))))

(define-test find-if-list.10
  (assert-equal '(nil nil 2 4 8 8 8 6 6)
                (loop for i from 0 to 8 collect
                  (find-if #'evenp '(1 2 4 8 3 1 6 7) :end i :from-end t))))

(define-test find-if-list.11
  (assert-equal '((nil 2 2 2 2 2 2 2)
                  (2 2 2 2 2 2 2)
                  (4 4 4 4 4 4)
                  (8 8 8 8 8)
                  (nil nil 6 6)
                  (nil 6 6)
                  (6 6)
                  (nil))
                (loop for j from 0 to 7
                      collect
                   (loop for i from (1+ j) to 8 collect
                     (find-if #'evenp '(1 2 4 8 3 1 6 7) :start j :end i)))))

(define-test find-if-list.12
  (assert-equal '((nil 2 4 8 8 8 6 6)
                  (2 4 8 8 8 6 6)
                  (4 8 8 8 6 6)
                  (8 8 8 6 6)
                  (nil nil 6 6)
                  (nil 6 6)
                  (6 6)
                  (nil))
                (loop for j from 0 to 7
                      collect
                   (loop for i from (1+ j) to 8 collect
                     (find-if #'evenp '(1 2 4 8 3 1 6 7) :start j :end i
                          :from-end t)))))

(define-test find-if-list.13
  (assert-equal '(1 11 11 45 45 71 nil)
                (loop for i from 0 to 6
                      collect
                   (find-if #'evenp '(1 6 11 32 45 71 100) :key #'1+ :start i))))

(define-test find-if-list.14
  (assert-equal '(71 71 71 71 71 71 nil)
                (loop for i from 0 to 6
                      collect
                   (find-if #'evenp '(1 6 11 32 45 71 100) :key '1+ :start i :from-end t))))

(define-test find-if-list.15
  (assert-equal '(nil 1 1 1 1 1 1 1)
                (loop for i from 0 to 7
                      collect
                   (find-if #'evenp '(1 6 11 32 45 71 100) :key #'1+ :end i))))

(define-test find-if-list.16
  (assert-equal '(nil 1 1 11 11 45 71 71)
                (loop for i from 0 to 7
                      collect
                   (find-if #'evenp '(1 6 11 32 45 71 100) :key '1+ :end i :from-end t))))

(define-test find-if-list.17
  (assert-equal '((nil 2 2 2 2 2 2 2)
                  (2 2 2 2 2 2 2)
                  (4 4 4 4 4 4)
                  (8 8 8 8 8)
                  (nil nil 6 6)
                  (nil 6 6)
                  (6 6)
                  (nil))
                (loop for j from 0 to 7
                      collect
                   (loop for i from (1+ j) to 8 collect
                     (find-if #'oddp '(1 2 4 8 3 1 6 7) :start j :end i :key #'1-)))))

(define-test find-if-list.18
  (assert-equal '((nil 2 4 8 8 8 6 6)
                  (2 4 8 8 8 6 6)
                  (4 8 8 8 6 6)
                  (8 8 8 6 6)
                  (nil nil 6 6)
                  (nil 6 6)
                  (6 6)
                  (nil))
                (loop for j from 0 to 7
                      collect
                   (loop for i from (1+ j) to 8 collect
                     (find-if #'oddp '(1 2 4 8 3 1 6 7) :start j :end i
                          :from-end t :key #'1+)))))

;;; tests for vectors

(define-test find-if-vector.1
  (assert-equal 'nil
                (find-if #'identity #())))

(define-test find-if-vector.2
  (assert-equal 'a
                (find-if #'identity #(a))))

(define-test find-if-vector.2a
  (assert-equal 'a
                (find-if 'identity #(a))))

(define-test find-if-vector.3
  (assert-equal '2
                (find-if #'evenp #(1 2 4 8 3 1 6 7))))

(define-test find-if-vector.4
  (assert-equal '6
                (find-if #'evenp #(1 2 4 8 3 1 6 7) :from-end t)))

(define-test find-if-vector.5
  (assert-equal '(2 2 4 8 6 6 6 nil)
                (loop for i from 0 to 7 collect
                  (find-if #'evenp #(1 2 4 8 3 1 6 7) :start i))))

(define-test find-if-vector.6
  (assert-equal '(2 2 4 8 6 6 6 nil)
                (loop for i from 0 to 7 collect
                  (find-if #'evenp #(1 2 4 8 3 1 6 7) :start i :end nil))))

(define-test find-if-vector.7
  (assert-equal '(6 6 6 6 6 6 6 nil)
                (loop for i from 0 to 7 collect
                  (find-if #'evenp #(1 2 4 8 3 1 6 7) :start i :from-end t))))

(define-test find-if-vector.8
  (assert-equal '(6 6 6 6 6 6 6 nil)
                (loop for i from 0 to 7 collect
                  (find-if #'evenp #(1 2 4 8 3 1 6 7) :start i :end nil :from-end t))))

(define-test find-if-vector.9
  (assert-equal '(nil nil 2 2 2 2 2 2 2)
                (loop for i from 0 to 8 collect
                  (find-if #'evenp #(1 2 4 8 3 1 6 7) :end i))))

(define-test find-if-vector.10
  (assert-equal '(nil nil 2 4 8 8 8 6 6)
                (loop for i from 0 to 8 collect
                  (find-if #'evenp #(1 2 4 8 3 1 6 7) :end i :from-end t))))

(define-test find-if-vector.11
  (assert-equal '((nil 2 2 2 2 2 2 2)
                  (2 2 2 2 2 2 2)
                  (4 4 4 4 4 4)
                  (8 8 8 8 8)
                  (nil nil 6 6)
                  (nil 6 6)
                  (6 6)
                  (nil))
                (loop for j from 0 to 7
                      collect
                   (loop for i from (1+ j) to 8 collect
                     (find-if #'evenp #(1 2 4 8 3 1 6 7) :start j :end i)))))

(define-test find-if-vector.12
  (assert-equal '((nil 2 4 8 8 8 6 6)
                  (2 4 8 8 8 6 6)
                  (4 8 8 8 6 6)
                  (8 8 8 6 6)
                  (nil nil 6 6)
                  (nil 6 6)
                  (6 6)
                  (nil))
                (loop for j from 0 to 7
                      collect
                   (loop for i from (1+ j) to 8 collect
                     (find-if #'evenp #(1 2 4 8 3 1 6 7) :start j :end i
                          :from-end t)))))

(define-test find-if-vector.13
  (assert-equal '(1 11 11 45 45 71 nil)
                (loop for i from 0 to 6
                      collect
                   (find-if #'evenp #(1 6 11 32 45 71 100) :key #'1+ :start i))))

(define-test find-if-vector.14
  (assert-equal '(71 71 71 71 71 71 nil)
                (loop for i from 0 to 6
                      collect
                   (find-if #'evenp #(1 6 11 32 45 71 100) :key '1+ :start i :from-end t))))

(define-test find-if-vector.15
  (assert-equal '(nil 1 1 1 1 1 1 1)
                (loop for i from 0 to 7
                      collect
                   (find-if #'evenp #(1 6 11 32 45 71 100) :key #'1+ :end i))))

(define-test find-if-vector.16
  (assert-equal '(nil 1 1 11 11 45 71 71)
                (loop for i from 0 to 7
                      collect
                   (find-if #'evenp #(1 6 11 32 45 71 100) :key '1+ :end i :from-end t))))

(define-test find-if-vector.17
  (assert-equal '((nil 2 2 2 2 2 2 2)
                  (2 2 2 2 2 2 2)
                  (4 4 4 4 4 4)
                  (8 8 8 8 8)
                  (nil nil 6 6)
                  (nil 6 6)
                  (6 6)
                  (nil))
                (loop for j from 0 to 7
                      collect
                   (loop for i from (1+ j) to 8 collect
                     (find-if #'oddp #(1 2 4 8 3 1 6 7) :start j :end i :key #'1-)))))

(define-test find-if-vector.18
  (assert-equal '((nil 2 4 8 8 8 6 6)
                  (2 4 8 8 8 6 6)
                  (4 8 8 8 6 6)
                  (8 8 8 6 6)
                  (nil nil 6 6)
                  (nil 6 6)
                  (6 6)
                  (nil))
                (loop for j from 0 to 7
                      collect
                   (loop for i from (1+ j) to 8 collect
                     (find-if #'oddp #(1 2 4 8 3 1 6 7) :start j :end i
                          :from-end t :key #'1+)))))

(define-test find-if-vector.19
  (let ((a (make-array '(10) :initial-contents '(1 2 3 4 5 6 7 8 9 10)
		       :fill-pointer 5)))
     (assert-equal 2 (find-if #'evenp a))
     (assert-equal 4 (find-if #'evenp a :from-end t))
     (assert-equal 1 (find-if #'oddp a))
     (assert-equal 5 (find-if #'oddp a :from-end t))))

;;; Tests for bit vectors

(define-test find-if-bit-vector.1
  (assert-equal 'nil
                (find-if #'identity #*)))

(define-test find-if-bit-vector.2
  (assert-equal '1
                (find-if #'identity #*1)))

(define-test find-if-bit-vector.3
  (assert-equal '0
                (find-if #'identity #*0)))

(define-test find-if-bit-vector.4
  (assert-equal '((nil 0 0 0 0 0 0 0)
                  (nil nil nil 0 0 0 0)
                  (nil nil 0 0 0 0)
                  (nil 0 0 0 0)
                  (nil nil nil 0)
                  (nil nil 0)
                  (nil 0))
                (loop for i from 0 to 6
                      collect (loop for j from i to 7
                                    collect (find-if #'evenp #*0110110 :start i :end j)))))

(define-test find-if-bit-vector.5
  (assert-equal '((nil 0 0 0 0 0 0 0)
                  (nil nil nil 0 0 0 0)
                  (nil nil 0 0 0 0)
                  (nil 0 0 0 0)
                  (nil nil nil 0)
                  (nil nil 0)
                  (nil 0))
                (loop for i from 0 to 6
                      collect (loop for j from i to 7
                                    collect (find-if #'evenp #*0110110 :start i :end j
                                                 :from-end t)))))

(define-test find-if-bit-vector.6
  (assert-equal '((nil 0 0 0 0 0 0 0)
                  (nil nil nil 0 0 0 0)
                  (nil nil 0 0 0 0)
                  (nil 0 0 0 0)
                  (nil nil nil 0)
                  (nil nil 0)
                  (nil 0))
                (loop for i from 0 to 6
                      collect (loop for j from i to 7
                                    collect (find-if #'oddp #*0110110 :start i :end j
                                                 :from-end t :key #'1+)))))

(define-test find-if-bit-vector.7
  (assert-equal '((nil 0 0 0 0 0 0 0)
                  (nil nil nil 0 0 0 0)
                  (nil nil 0 0 0 0)
                  (nil 0 0 0 0)
                  (nil nil nil 0)
                  (nil nil 0)
                  (nil 0))
                (loop for i from 0 to 6
                      collect (loop for j from i to 7
                                    collect (find-if #'oddp #*0110110 :start i :end j
                                                 :key '1-)))))

;;; Tests for strings

(define-test find-if-string.1
  (assert-equal 'nil
                (find-if #'identity "")))

(define-test find-if-string.2
  (assert-equal '#\a
                (find-if #'identity "a")))

(define-test find-if-string.2a
  (assert-equal '#\a
                (find-if 'identity "a")))

(defun evendigitp (digit)
  (member digit '(#\0 #\2 #\4 #\6 #\8)))

(defun odddigitp (digit)
  (member digit '(#\1 #\3 #\5 #\7 #\9)))

(define-test find-if-string.3
  (assert-equal '#\2
                (find-if #'evendigitp "12483167")))
  
(define-test find-if-string.3a
  (assert-equal '#\2
                (find-if #'evenp "12483167" :key #'(lambda (c) (read-from-string (string c))))))

(define-test find-if-string.4
  (assert-equal '#\6
                (find-if #'evendigitp "12483167" :from-end t)))

(define-test find-if-string.5
  (assert-equal '(#\2 #\2 #\4 #\8 #\6 #\6 #\6 nil)
                (loop for i from 0 to 7 collect
                  (find-if #'evendigitp "12483167" :start i))))

(define-test find-if-string.6
  (assert-equal '(#\2 #\2 #\4 #\8 #\6 #\6 #\6 nil)
                (loop for i from 0 to 7 collect
                  (find-if #'evendigitp "12483167" :start i :end nil))))

(define-test find-if-string.7
  (assert-equal '(#\6 #\6 #\6 #\6 #\6 #\6 #\6 nil)
                (loop for i from 0 to 7 collect
                  (find-if #'evendigitp "12483167" :start i :from-end t))))

(define-test find-if-string.8
  (assert-equal '(#\6 #\6 #\6 #\6 #\6 #\6 #\6 nil)
                (loop for i from 0 to 7 collect
                  (find-if #'evendigitp "12483167" :start i :end nil :from-end t))))

(define-test find-if-string.9
  (assert-equal '(nil nil #\2 #\2 #\2 #\2 #\2 #\2 #\2)
                (loop for i from 0 to 8 collect
                  (find-if #'evendigitp "12483167" :end i))))

(define-test find-if-string.10
  (assert-equal '(nil nil #\2 #\4 #\8 #\8 #\8 #\6 #\6)
                (loop for i from 0 to 8 collect
                  (find-if #'evendigitp "12483167" :end i :from-end t))))

(define-test find-if-string.11
  (assert-equal '((nil #\2 #\2 #\2 #\2 #\2 #\2 #\2)
                  (#\2 #\2 #\2 #\2 #\2 #\2 #\2)
                  (#\4 #\4 #\4 #\4 #\4 #\4)
                  (#\8 #\8 #\8 #\8 #\8)
                  (nil nil #\6 #\6)
                  (nil #\6 #\6)
                  (#\6 #\6)
                  (nil))
                (loop for j from 0 to 7
                      collect
                   (loop for i from (1+ j) to 8 collect
                     (find-if #'evendigitp "12483167" :start j :end i)))))

(define-test find-if-string.12
  (assert-equal '((nil #\2 #\4 #\8 #\8 #\8 #\6 #\6)
                  (#\2 #\4 #\8 #\8 #\8 #\6 #\6)
                  (#\4 #\8 #\8 #\8 #\6 #\6)
                  (#\8 #\8 #\8 #\6 #\6)
                  (nil nil #\6 #\6)
                  (nil #\6 #\6)
                  (#\6 #\6)
                  (nil))
                (loop for j from 0 to 7
                      collect
                   (loop for i from (1+ j) to 8 collect
                     (find-if #'evendigitp "12483167" :start j :end i
                          :from-end t)))))

(defun compose (fun1 fun2)
  (lambda (x)
    (funcall fun1 (funcall fun2 x))))

(define-test find-if-string.13
  (assert-equal '(#\4 #\4 #\8 #\8 #\8 #\6 #\6)
                (loop for i from 0 to 6
                      collect
                   (find-if #'evenp "1473816"
                        :key (compose #'read-from-string #'string)
                        :start i))))

(define-test find-if-string.14
  (assert-equal '(#\6 #\6 #\6 #\6 #\6 #\6 #\6)
                (loop for i from 0 to 6
                      collect
                   (find-if #'evenp "1473816"
                        :key (compose #'read-from-string #'string)
                        :start i :from-end t))))

(define-test find-if-string.15
  (assert-equal '(nil nil #\4 #\4 #\4 #\4 #\4 #\4)
                (loop for i from 0 to 7
                      collect
                   (find-if #'evenp "1473816"
                        :key (compose #'read-from-string #'string)
                        :end i))))

(define-test find-if-string.16
  (assert-equal '(nil nil #\4 #\4 #\4 #\8 #\8 #\6)
                (loop for i from 0 to 7
                      collect
                   (find-if #'evenp "1473816"
                        :key (compose #'read-from-string #'string)
                        :end i :from-end t))))

(define-test find-if-string.17
  (assert-equal '((nil #\4 #\4 #\4 #\4 #\4 #\4)
                  (#\4 #\4 #\4 #\4 #\4 #\4)
                  (nil nil #\8 #\8 #\8)
                  (nil #\8 #\8 #\8)
                  (#\8 #\8 #\8)
                  (nil #\6)
                  (#\6))
                (loop for j from 0 to 6
                      collect
                   (loop for i from (1+ j) to 7 collect
                     (find-if #'evenp "1473816"
                          :key (compose #'read-from-string #'string)
                          :start j :end i)))))  

(define-test find-if-string.18
  (assert-equal '((nil #\4 #\4 #\4 #\8 #\8 #\6)
                  (#\4 #\4 #\4 #\8 #\8 #\6)
                  (nil nil #\8 #\8 #\6)
                  (nil #\8 #\8 #\6)
                  (#\8 #\8 #\6)
                  (nil #\6)
                  (#\6))
                (loop for j from 0 to 6
                      collect
                   (loop for i from (1+ j) to 7 collect
                     (find-if #'evenp "1473816"
                          :key (compose #'read-from-string #'string)
                          :start j :end i
                          :from-end t)))))

(define-test find-if-string.19
  (let ((a (make-array '(10) :initial-contents "123456789a"
		       :fill-pointer 5
		       :element-type 'character)))
    (assert-equal #\2 (find-if #'evendigitp a))
    (assert-equal #\4 (find-if #'evendigitp a :from-end t))
    (assert-equal #\1 (find-if #'odddigitp a))
    (assert-equal #\5 (find-if #'odddigitp a :from-end t))))

;;; Keyword tests

(define-test find-if.allow-other-keys.1
  (assert-equal '2
                (find-if #'evenp '(1 2 3 4 5) :bad t :allow-other-keys t)))

(define-test find-if.allow-other-keys.2
  (assert-equal '2
                (find-if #'evenp '(1 2 3 4 5) :allow-other-keys t :also-bad t)))

;;; The leftmost of two :allow-other-keys arguments is the one that  matters.
(define-test find-if.allow-other-keys.3
  (assert-equal '2
                (find-if #'evenp '(1 2 3 4 5)
                         :allow-other-keys t
                         :allow-other-keys nil
                         :bad t)))

(define-test find-if.keywords.4
  (assert-equal '2
                (find-if #'evenp '(1 2 3 4 5) :key #'identity :key #'1+)))

(define-test find-if.allow-other-keys.5
  (assert-equal 'a
                (find-if #'identity '(nil a b c nil) :allow-other-keys nil)))


;;; Error tests

(define-test find-if.error.4
  (assert-error 'type-error (find-if 'null '(a b c . d))))

(define-test find-if.error.5
  (let ((fun nil)
	(warned nil))
    (handler-bind ((warning (lambda (condition)
			      (setf warned t)
			      (muffle-warning condition))))
      (setf fun
	    (compile nil '(lambda () (find-if)))))
    (assert-true warned)
    (assert-error 'program-error (funcall fun))))

(define-test find-if.error.6
  (let ((fun nil)
	(warned nil))
    (handler-bind ((warning (lambda (condition)
			      (setf warned t)
			      (muffle-warning condition))))
      (setf fun
	    (compile nil '(lambda () (find-if #'null)))))
    (assert-true warned)
    (assert-error 'program-error (funcall fun))))

(define-test find-if.error.7
  (let ((fun nil)
	(warned nil))
    (handler-bind ((warning (lambda (condition)
			      (setf warned t)
			      (muffle-warning condition))))
      (setf fun
	    (compile nil '(lambda () (find-if #'null nil :bad t)))))
    (assert-true warned)
    (assert-error 'program-error (funcall fun))))

(define-test find-if.error.8
  (let ((fun nil)
	(warned nil))
    (handler-bind ((warning (lambda (condition)
			      (setf warned t)
			      (muffle-warning condition))))
      (setf fun
	    (compile nil '(lambda ()
			   (find-if #'null nil :bad t :allow-other-keys nil)))))
    (assert-true warned)
    (assert-error 'program-error (funcall fun))))

(define-test find-if.error.9
  (let ((fun nil)
	(warned nil))
    (handler-bind ((warning (lambda (condition)
			      (setf warned t)
			      (muffle-warning condition))))
      (setf fun
	    (compile nil '(lambda ()
			   (find-if #'null nil 1 1)))))
    (assert-true warned)
    (assert-error 'program-error (funcall fun))))

(define-test find-if.error.10
  (let ((fun nil)
	(warned nil))
    (handler-bind ((warning (lambda (condition)
			      (setf warned t)
			      (muffle-warning condition))))
      (setf fun
	    (compile nil '(lambda ()
			   (find-if #'null nil :key)))))
    (assert-true warned)
    (assert-error 'program-error (funcall fun))))

(define-test find-if.error.11
  (let ((fun nil)
	(warned nil))
    (handler-bind ((warning (lambda (condition)
			      (setf warned t)
			      (muffle-warning condition))))
      (setf fun
	    (compile nil '(lambda () (find-if)))))
    (assert-true warned)
    (assert-error 'program-error (funcall fun))))

(define-test find-if.error.11
  (assert-error 'type-error (locally (find-if #'null 'b) t)))

(define-test find-if.error.12
  (assert-error 'program-error (find-if #'cons '(a b c))))

(define-test find-if.error.13
  (assert-error 'type-error (find-if #'car '(a b c))))

(define-test find-if.error.14
  (assert-error 'program-error (find-if #'identity '(a b c) :key #'cons)))

(define-test find-if.error.15
  (assert-error 'type-error
		 (find-if #'identity '(a b c) :key #'car)))

;;; Order of evaluation tests

(define-test find-if.order.1
  (let ((i 0) x y)
    (assert-equal
     '(a 2 1 2)
     (list
      (find-if (progn (setf x (incf i)) #'identity)
               (progn (setf y (incf i)) '(nil nil nil a nil nil)))
      i x y))))

(define-test find-if.order.2
  (let ((i 0) a b c d e f)
    (assert-equal
     '(a 6 1 2 3 4 5 6)
     (list
      (find-if (progn (setf a (incf i)) #'null)
               (progn (setf b (incf i)) '(nil nil nil a nil nil))
               :start (progn (setf c (incf i)) 1)
               :end   (progn (setf d (incf i)) 4)
               :from-end (setf e (incf i))
               :key   (progn (setf f (incf i)) #'null)
               )
      i a b c d e f))))

(define-test find-if.order.3
  (let ((i 0) a b c d e f)
    (assert-equal
     '(a 6 1 2 3 4 5 6)
     (list
      (find-if (progn (setf a (incf i)) #'null)
               (progn (setf b (incf i)) '(nil nil nil a nil nil))
               :key   (progn (setf c (incf i)) #'null)
               :from-end (setf d (incf i))
               :end   (progn (setf e (incf i)) 4)
               :start (progn (setf f (incf i)) 1)
               )
      i a b c d e f))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function find-if-not

(define-test find-if-not-list.1
  (assert-equal
   nil
   (find-if-not #'identity ())))

(define-test find-if-not-list.2
  (assert-equal
   'a
   (find-if-not #'null '(a))))

(define-test find-if-not-list.2a
  (assert-equal
   'a
   (find-if-not 'null '(a))))

(define-test find-if-not-list.3
  (assert-equal
   2
   (find-if-not #'oddp '(1 2 4 8 3 1 6 7))))

(define-test find-if-not-list.4
  (assert-equal
   6
   (find-if-not #'oddp '(1 2 4 8 3 1 6 7) :from-end t)))

(define-test find-if-not-list.5
  (assert-equal
   '(2 2 4 8 6 6 6 nil)
   (loop for i from 0 to 7 collect
     (find-if-not #'oddp '(1 2 4 8 3 1 6 7) :start i))))

(define-test find-if-not-list.6
  (assert-equal
   '(2 2 4 8 6 6 6 nil)
   (loop for i from 0 to 7 collect
     (find-if-not #'oddp '(1 2 4 8 3 1 6 7) :start i :end nil))))

(define-test find-if-not-list.7
  (assert-equal
   '(6 6 6 6 6 6 6 nil)
   (loop for i from 0 to 7 collect
     (find-if-not #'oddp '(1 2 4 8 3 1 6 7) :start i :from-end t))))

(define-test find-if-not-list.8
  (assert-equal
   '(6 6 6 6 6 6 6 nil)
   (loop for i from 0 to 7 collect
     (find-if-not #'oddp '(1 2 4 8 3 1 6 7) :start i :end nil :from-end t))))

(define-test find-if-not-list.9
  (assert-equal
   '(nil nil 2 2 2 2 2 2 2)
   (loop for i from 0 to 8 collect
     (find-if-not #'oddp '(1 2 4 8 3 1 6 7) :end i))))

(define-test find-if-not-list.10
  (assert-equal
   '(nil nil 2 4 8 8 8 6 6)
   (loop for i from 0 to 8 collect
     (find-if-not #'oddp '(1 2 4 8 3 1 6 7) :end i :from-end t))))

(define-test find-if-not-list.11
  (assert-equal
   '((nil 2 2 2 2 2 2 2)
     (2 2 2 2 2 2 2)
     (4 4 4 4 4 4)
     (8 8 8 8 8)
     (nil nil 6 6)
     (nil 6 6)
     (6 6)
     (nil))
   (loop for j from 0 to 7
         collect
      (loop for i from (1+ j) to 8 collect
        (find-if-not #'oddp '(1 2 4 8 3 1 6 7) :start j :end i)))))

(define-test find-if-not-list.12
  (assert-equal
   '((nil 2 4 8 8 8 6 6)
     (2 4 8 8 8 6 6)
     (4 8 8 8 6 6)
     (8 8 8 6 6)
     (nil nil 6 6)
     (nil 6 6)
     (6 6)
     (nil))
   (loop for j from 0 to 7
         collect
      (loop for i from (1+ j) to 8 collect
        (find-if-not #'oddp '(1 2 4 8 3 1 6 7) :start j :end i
             :from-end t)))))

(define-test find-if-not-list.13
  (assert-equal
   '(1 11 11 45 45 71 nil)
   (loop for i from 0 to 6
         collect
      (find-if-not #'oddp '(1 6 11 32 45 71 100) :key #'1+ :start i))))

(define-test find-if-not-list.14
  (assert-equal
   '(71 71 71 71 71 71 nil)
   (loop for i from 0 to 6
         collect
      (find-if-not #'oddp '(1 6 11 32 45 71 100) :key '1+ :start i :from-end t))))

(define-test find-if-not-list.15
  (assert-equal
   '(nil 1 1 1 1 1 1 1)
   (loop for i from 0 to 7
         collect
      (find-if-not #'oddp '(1 6 11 32 45 71 100) :key #'1+ :end i))))

(define-test find-if-not-list.16
  (assert-equal
   '(nil 1 1 11 11 45 71 71)
   (loop for i from 0 to 7
         collect
      (find-if-not #'oddp '(1 6 11 32 45 71 100) :key '1+ :end i :from-end t))))

(define-test find-if-not-list.17
  (assert-equal
   '((nil 2 2 2 2 2 2 2)
     (2 2 2 2 2 2 2)
     (4 4 4 4 4 4)
     (8 8 8 8 8)
     (nil nil 6 6)
     (nil 6 6)
     (6 6)
     (nil))
   (loop for j from 0 to 7
         collect
      (loop for i from (1+ j) to 8 collect
        (find-if-not #'evenp '(1 2 4 8 3 1 6 7) :start j :end i :key #'1-)))))

(define-test find-if-not-list.18
  (assert-equal
   '((nil 2 4 8 8 8 6 6)
     (2 4 8 8 8 6 6)
     (4 8 8 8 6 6)
     (8 8 8 6 6)
     (nil nil 6 6)
     (nil 6 6)
     (6 6)
     (nil))
   (loop for j from 0 to 7
         collect
      (loop for i from (1+ j) to 8 collect
        (find-if-not #'evenp '(1 2 4 8 3 1 6 7) :start j :end i
             :from-end t :key #'1+)))))

;;; tests for vectors

(define-test find-if-not-vector.1
  (assert-equal
   nil
   (find-if-not #'identity #())))

(define-test find-if-not-vector.2
  (assert-equal
   'a
   (find-if-not #'not #(a))))

(define-test find-if-not-vector.2a
  (assert-equal
   'a
   (find-if-not 'null #(a))))

(define-test find-if-not-vector.3
  (assert-equal
   2
   (find-if-not #'oddp #(1 2 4 8 3 1 6 7))))

(define-test find-if-not-vector.4
  (assert-equal
   6
   (find-if-not #'oddp #(1 2 4 8 3 1 6 7) :from-end t)))

(define-test find-if-not-vector.5
  (assert-equal
   '(2 2 4 8 6 6 6 nil)
   (loop for i from 0 to 7 collect
     (find-if-not #'oddp #(1 2 4 8 3 1 6 7) :start i))))

(define-test find-if-not-vector.6
  (assert-equal
   '(2 2 4 8 6 6 6 nil)
   (loop for i from 0 to 7 collect
     (find-if-not #'oddp #(1 2 4 8 3 1 6 7) :start i :end nil))))

(define-test find-if-not-vector.7
  (assert-equal
   '(6 6 6 6 6 6 6 nil)
   (loop for i from 0 to 7 collect
     (find-if-not #'oddp #(1 2 4 8 3 1 6 7) :start i :from-end t))))

(define-test find-if-not-vector.8
  (assert-equal
   '(6 6 6 6 6 6 6 nil)
   (loop for i from 0 to 7 collect
     (find-if-not #'oddp #(1 2 4 8 3 1 6 7) :start i :end nil :from-end t))))

(define-test find-if-not-vector.9
  (assert-equal
   '(nil nil 2 2 2 2 2 2 2)
   (loop for i from 0 to 8 collect
     (find-if-not #'oddp #(1 2 4 8 3 1 6 7) :end i))))

(define-test find-if-not-vector.10
  (assert-equal
   '(nil nil 2 4 8 8 8 6 6)
   (loop for i from 0 to 8 collect
     (find-if-not #'oddp #(1 2 4 8 3 1 6 7) :end i :from-end t))))

(define-test find-if-not-vector.11
  (assert-equal
   '((nil 2 2 2 2 2 2 2)
     (2 2 2 2 2 2 2)
     (4 4 4 4 4 4)
     (8 8 8 8 8)
     (nil nil 6 6)
     (nil 6 6)
     (6 6)
     (nil))
   (loop for j from 0 to 7
         collect
      (loop for i from (1+ j) to 8 collect
        (find-if-not #'oddp #(1 2 4 8 3 1 6 7) :start j :end i)))))

(define-test find-if-not-vector.12
  (assert-equal
   '((nil 2 4 8 8 8 6 6)
     (2 4 8 8 8 6 6)
     (4 8 8 8 6 6)
     (8 8 8 6 6)
     (nil nil 6 6)
     (nil 6 6)
     (6 6)
     (nil))
   (loop for j from 0 to 7
         collect
      (loop for i from (1+ j) to 8 collect
        (find-if-not #'oddp #(1 2 4 8 3 1 6 7) :start j :end i
             :from-end t)))))

(define-test find-if-not-vector.13
  (assert-equal
   '(1 11 11 45 45 71 nil)
   (loop for i from 0 to 6
         collect
      (find-if-not #'oddp #(1 6 11 32 45 71 100) :key #'1+ :start i))))

(define-test find-if-not-vector.14
  (assert-equal
   '(71 71 71 71 71 71 nil)
   (loop for i from 0 to 6
         collect
      (find-if-not #'oddp #(1 6 11 32 45 71 100) :key '1+ :start i :from-end t))))

(define-test find-if-not-vector.15
  (assert-equal
   '(nil 1 1 1 1 1 1 1)
   (loop for i from 0 to 7
         collect
      (find-if-not #'oddp #(1 6 11 32 45 71 100) :key #'1+ :end i))))

(define-test find-if-not-vector.16
  (assert-equal
   '(nil 1 1 11 11 45 71 71)
   (loop for i from 0 to 7
         collect
      (find-if-not #'oddp #(1 6 11 32 45 71 100) :key '1+ :end i :from-end t))))

(define-test find-if-not-vector.17
  (assert-equal
   '((nil 2 2 2 2 2 2 2)
     (2 2 2 2 2 2 2)
     (4 4 4 4 4 4)
     (8 8 8 8 8)
     (nil nil 6 6)
     (nil 6 6)
     (6 6)
     (nil))
   (loop for j from 0 to 7
         collect
      (loop for i from (1+ j) to 8 collect
        (find-if-not #'evenp #(1 2 4 8 3 1 6 7) :start j :end i :key #'1-)))))

(define-test find-if-not-vector.18
  (assert-equal
   '((nil 2 4 8 8 8 6 6)
     (2 4 8 8 8 6 6)
     (4 8 8 8 6 6)
     (8 8 8 6 6)
     (nil nil 6 6)
     (nil 6 6)
     (6 6)
     (nil))
   (loop for j from 0 to 7
         collect
      (loop for i from (1+ j) to 8 collect
        (find-if-not #'evenp #(1 2 4 8 3 1 6 7) :start j :end i
             :from-end t :key #'1+)))))

;;; Tests for bit vectors

(define-test find-if-not-bit-vector.1
  (assert-equal
   nil
   (find-if-not #'identity #*)))

(define-test find-if-not-bit-vector.2
  (assert-equal
   1
   (find-if-not #'null #*1)))

(define-test find-if-not-bit-vector.3
  (assert-equal
   0
   (find-if-not #'not #*0)))

(define-test find-if-not-bit-vector.4
  (assert-equal
   '((nil 0 0 0 0 0 0 0)
     (nil nil nil 0 0 0 0)
     (nil nil 0 0 0 0)
     (nil 0 0 0 0)
     (nil nil nil 0)
     (nil nil 0)
     (nil 0))
   (loop for i from 0 to 6
         collect (loop for j from i to 7
                       collect (find-if-not #'oddp #*0110110 :start i :end j)))))

(define-test find-if-not-bit-vector.5
  (assert-equal
   '((nil 0 0 0 0 0 0 0)
     (nil nil nil 0 0 0 0)
     (nil nil 0 0 0 0)
     (nil 0 0 0 0)
     (nil nil nil 0)
     (nil nil 0)
     (nil 0))
   (loop for i from 0 to 6
         collect (loop for j from i to 7
                       collect (find-if-not #'oddp #*0110110 :start i :end j
                                    :from-end t)))))

(define-test find-if-not-bit-vector.6
  (assert-equal
   '((nil 0 0 0 0 0 0 0)
     (nil nil nil 0 0 0 0)
     (nil nil 0 0 0 0)
     (nil 0 0 0 0)
     (nil nil nil 0)
     (nil nil 0)
     (nil 0))
   (loop for i from 0 to 6
         collect (loop for j from i to 7
                       collect (find-if-not #'evenp #*0110110 :start i :end j
                                    :from-end t :key #'1+)))))

(define-test find-if-not-bit-vector.7
  (assert-equal
   '((nil 0 0 0 0 0 0 0)
     (nil nil nil 0 0 0 0)
     (nil nil 0 0 0 0)
     (nil 0 0 0 0)
     (nil nil nil 0)
     (nil nil 0)
     (nil 0))
   (loop for i from 0 to 6
         collect (loop for j from i to 7
                       collect (find-if-not #'evenp #*0110110 :start i :end j
                                    :key '1-)))))

;;; Tests for strings

(define-test find-if-not-string.1
  (assert-equal
   nil
   (find-if-not #'identity "")))

(define-test find-if-not-string.2
  (assert-equal
   #\a
   (find-if-not #'null "a")))

(define-test find-if-not-string.2a
  (assert-equal
   #\a
   (find-if-not 'null "a")))

(define-test find-if-not-string.3
  (assert-equal
   #\2
   (find-if-not #'odddigitp "12483167")))
  
(define-test find-if-not-string.3a
  (assert-equal
   #\2
   (find-if-not #'oddp "12483167" :key #'(lambda (c) (read-from-string (string c))))))

(define-test find-if-not-string.4
  (assert-equal
   #\6
   (find-if-not #'odddigitp "12483167" :from-end t)))

(define-test find-if-not-string.5
  (assert-equal
   '(#\2 #\2 #\4 #\8 #\6 #\6 #\6 nil)
   (loop for i from 0 to 7 collect
     (find-if-not #'odddigitp "12483167" :start i))))

(define-test find-if-not-string.6
  (assert-equal
   '(#\2 #\2 #\4 #\8 #\6 #\6 #\6 nil)
   (loop for i from 0 to 7 collect
     (find-if-not #'odddigitp "12483167" :start i :end nil))))

(define-test find-if-not-string.7
  (assert-equal
   '(#\6 #\6 #\6 #\6 #\6 #\6 #\6 nil)
   (loop for i from 0 to 7 collect
     (find-if-not #'odddigitp "12483167" :start i :from-end t))))

(define-test find-if-not-string.8
  (assert-equal
   '(#\6 #\6 #\6 #\6 #\6 #\6 #\6 nil)
   (loop for i from 0 to 7 collect
     (find-if-not #'odddigitp "12483167" :start i :end nil :from-end t))))

(define-test find-if-not-string.9
  (assert-equal
   '(nil nil #\2 #\2 #\2 #\2 #\2 #\2 #\2)
   (loop for i from 0 to 8 collect
     (find-if-not #'odddigitp "12483167" :end i))))

(define-test find-if-not-string.10
  (assert-equal
   '(nil nil #\2 #\4 #\8 #\8 #\8 #\6 #\6)
   (loop for i from 0 to 8 collect
     (find-if-not #'odddigitp "12483167" :end i :from-end t))))

(define-test find-if-not-string.11
  (assert-equal
   '((nil #\2 #\2 #\2 #\2 #\2 #\2 #\2)
     (#\2 #\2 #\2 #\2 #\2 #\2 #\2)
     (#\4 #\4 #\4 #\4 #\4 #\4)
     (#\8 #\8 #\8 #\8 #\8)
     (nil nil #\6 #\6)
     (nil #\6 #\6)
     (#\6 #\6)
     (nil))
   (loop for j from 0 to 7
         collect
      (loop for i from (1+ j) to 8 collect
        (find-if-not #'odddigitp "12483167" :start j :end i)))))

(define-test find-if-not-string.12
  (assert-equal
  '((nil #\2 #\4 #\8 #\8 #\8 #\6 #\6)
    (#\2 #\4 #\8 #\8 #\8 #\6 #\6)
    (#\4 #\8 #\8 #\8 #\6 #\6)
    (#\8 #\8 #\8 #\6 #\6)
    (nil nil #\6 #\6)
    (nil #\6 #\6)
    (#\6 #\6)
    (nil))
  (loop for j from 0 to 7
        collect
     (loop for i from (1+ j) to 8 collect
       (find-if-not #'odddigitp "12483167" :start j :end i
            :from-end t)))))

(define-test find-if-not-string.13
  (assert-equal
  '(#\4 #\4 #\8 #\8 #\8 #\6 #\6)
  (loop for i from 0 to 6
        collect
     (find-if-not #'oddp "1473816"
          :key (compose #'read-from-string #'string)
          :start i))))

(define-test find-if-not-string.14
  (assert-equal
  '(#\6 #\6 #\6 #\6 #\6 #\6 #\6)
  (loop for i from 0 to 6
        collect
     (find-if-not #'oddp "1473816"
          :key (compose #'read-from-string #'string)
          :start i :from-end t))))

(define-test find-if-not-string.15
  (assert-equal
  '(nil nil #\4 #\4 #\4 #\4 #\4 #\4)
  (loop for i from 0 to 7
        collect
     (find-if-not #'oddp "1473816"
          :key (compose #'read-from-string #'string)
          :end i))))

(define-test find-if-not-string.16
  (assert-equal
  '(nil nil #\4 #\4 #\4 #\8 #\8 #\6)
  (loop for i from 0 to 7
        collect
     (find-if-not #'oddp "1473816"
          :key (compose #'read-from-string #'string)
          :end i :from-end t))))

(define-test find-if-not-string.17
  (assert-equal
  '((nil #\4 #\4 #\4 #\4 #\4 #\4)
    (#\4 #\4 #\4 #\4 #\4 #\4)
    (nil nil #\8 #\8 #\8)
    (nil #\8 #\8 #\8)
    (#\8 #\8 #\8)
    (nil #\6)
    (#\6))
  (loop for j from 0 to 6
        collect
     (loop for i from (1+ j) to 7 collect
       (find-if-not #'oddp "1473816"
            :key (compose #'read-from-string #'string)
            :start j :end i))))  )

(define-test find-if-not-string.18
  (assert-equal
  '((nil #\4 #\4 #\4 #\8 #\8 #\6)
    (#\4 #\4 #\4 #\8 #\8 #\6)
    (nil nil #\8 #\8 #\6)
    (nil #\8 #\8 #\6)
    (#\8 #\8 #\6)
    (nil #\6)
    (#\6))
   (loop for j from 0 to 6
         collect
      (loop for i from (1+ j) to 7 collect
        (find-if-not #'oddp "1473816"
             :key (compose #'read-from-string #'string)
             :start j :end i
             :from-end t)))))

;;; Keyword tests

(define-test find-if-not.allow-other-keys.1
  (assert-equal
   2
   (find-if-not #'oddp '(1 2 3 4 5) :bad t :allow-other-keys t)))

(define-test find-if-not.allow-other-keys.2
  (assert-equal
   2
   (find-if-not #'oddp '(1 2 3 4 5) :allow-other-keys t :also-bad t)))

;;; The leftmost of two :allow-other-keys arguments is the one that  matters.
(define-test find-if-not.allow-other-keys.3
  (assert-equal
   2
   (find-if-not #'oddp '(1 2 3 4 5)
                :allow-other-keys t
                :allow-other-keys nil
                :bad t)))

(define-test find-if-not.keywords.4
  (assert-equal
   2
   (find-if-not #'oddp '(1 2 3 4 5) :key #'identity :key #'1+)))

(define-test find-if-not.allow-other-keys.5
  (assert-equal
   'a
   (find-if-not #'null '(nil a b c nil) :allow-other-keys nil)))

;;; Error tests

(define-test find-if-not.error.4
  (assert-error 'type-error
                (find-if-not 'identity '(a b c . d))))

(define-test find-if-not.error.5
  (let ((fun nil)
	(warned nil))
    (handler-bind ((warning (lambda (condition)
			      (setf warned t)
			      (muffle-warning condition))))
      (setf fun
	    (compile nil '(lambda () (find-if-not)))))
    (assert-true warned)
    (assert-error 'program-error (funcall fun))))

(define-test find-if-not.error.6
  (let ((fun nil)
	(warned nil))
    (handler-bind ((warning (lambda (condition)
			      (setf warned t)
			      (muffle-warning condition))))
      (setf fun
	    (compile nil '(lambda () (find-if-not #'null)))))
    (assert-true warned)
    (assert-error 'program-error (funcall fun))))

(define-test find-if-not.error.7
  (let ((fun nil)
	(warned nil))
    (handler-bind ((warning (lambda (condition)
			      (setf warned t)
			      (muffle-warning condition))))
      (setf fun
	    (compile nil '(lambda () (find-if-not #'null nil :bad t)))))
    (assert-true warned)
    (assert-error 'program-error (funcall fun))))

(define-test find-if-not.error.8
  (let ((fun nil)
	(warned nil))
    (handler-bind ((warning (lambda (condition)
			      (setf warned t)
			      (muffle-warning condition))))
      (setf fun
	    (compile nil '(lambda ()
			   (find-if-not #'null nil :bad t :allow-other-keys nil)))))
    (assert-true warned)
    (assert-error 'program-error (funcall fun))))

(define-test find-if-not.error.9
  (let ((fun nil)
	(warned nil))
    (handler-bind ((warning (lambda (condition)
			      (setf warned t)
			      (muffle-warning condition))))
      (setf fun
	    (compile nil '(lambda ()
			   (find-if-not #'null nil 1 1)))))
    (assert-true warned)
    (assert-error 'program-error (funcall fun))))

(define-test find-if-not.error.10
  (let ((fun nil)
	(warned nil))
    (handler-bind ((warning (lambda (condition)
			      (setf warned t)
			      (muffle-warning condition))))
      (setf fun
	    (compile nil '(lambda ()
			   (find-if-not #'null nil :key)))))
    (assert-true warned)
    (assert-error 'program-error (funcall fun))))
    
(define-test find-if-not.error.11
  (assert-error 'type-error (locally (find-if-not #'null 'b) t)))

(define-test find-if-not.error.12
  (assert-error 'program-error (find-if-not #'cons '(a b c))))
    
(define-test find-if-not.error.13
  (assert-error 'type-error (find-if-not #'car '(a b c))))

(define-test find-if-not.error.14
  (assert-error 'program-error (find-if-not #'identity '(a b c) :key #'cons)))

(define-test find-if-not.error.15
  (assert-error 'type-error
                (find-if-not #'identity '(a b c) :key #'car)))

;;; Order of evaluation tests

(define-test find-if-not.order.1
  (let ((i 0) x y)
    (assert-equal
     '(a 2 1 2)
     (list
      (find-if-not (progn (setf x (incf i)) #'null)
                   (progn (setf y (incf i)) '(nil nil nil a nil nil)))
      i x y))))
  
(define-test find-if-not.order.2
  (let ((i 0) a b c d e f)
    (assert-equal
     '(a 6 1 2 3 4 5 6)
     (list
      (find-if-not (progn (setf a (incf i)) #'identity)
                   (progn (setf b (incf i)) '(nil nil nil a nil nil))
                   :start (progn (setf c (incf i)) 1)
                   :end   (progn (setf d (incf i)) 4)
                   :from-end (setf e (incf i))
                   :key   (progn (setf f (incf i)) #'null)
                   )
      i a b c d e f))))

(define-test find-if-not.order.3
  (let ((i 0) a b c d e f)
    (assert-equal
     '(a 6 1 2 3 4 5 6)
     (list
      (find-if-not (progn (setf a (incf i)) #'identity)
                   (progn (setf b (incf i)) '(nil nil nil a nil nil))
                   :key   (progn (setf c (incf i)) #'null)
                   :from-end (setf d (incf i))
                   :end   (progn (setf e (incf i)) 4)
                   :start (progn (setf f (incf i)) 1)
                   )
      i a b c d e f))))

  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function length

(define-test length.list.1
  (assert-equal
   0
   (length nil)))

(define-test length.list.2
  (assert-equal
   5
   (length '(a b c d e))))

(define-test length.list.3
  (assert-equal
   200000
   (length (make-list 200000))))

(defun length.list-4-body ()
  (let ((x ()))
    (loop
     for i from 0 to 999 do
     (progn
       (unless (eql (length x) i) (return nil))
       (push i x))
     finally (return t))))

(define-test length.list-4
  (assert-equal
   t
   (length.list-4-body)))

(define-test length.vector.1
  (assert-equal
   0
   (length #())))

(define-test length.vector.2
  (assert-equal
   1
   (length #(a))))

(define-test length.vector.3
  (assert-equal
   2
   (length #(a b))))

(define-test length.vector.4
  (assert-equal
   3
   (length #(a b c))))

(define-test length.nonsimple-vector.1
  (assert-equal
   10
   (length (make-array 10 :fill-pointer t :adjustable t))))

(define-test length.nonsimple-vector.2
  (assert-equal
   5
   (let ((a (make-array 10 :fill-pointer t :adjustable t)))
     (setf (fill-pointer a) 5)
     (length a))))

(define-test length.bit-vector.1
  (assert-equal
   0
   (length #*)))

(define-test length.bit-vector.2
  (assert-equal
   1
   (length #*1)))

(define-test length.bit-vector.3
  (assert-equal
   1
   (length #*0)))

(define-test length.bit-vector.4
  (assert-equal
   6
   (length #*010101)))

(define-test length.bit-vector.5
  (assert-equal
   '(5 1)
   (let ((i 0))
     (flet ((%f () (incf i)
              (make-array 5 :element-type 'bit
                          :initial-contents '(0 0 1 1 0))))
       (list
        (length (the (simple-bit-vector 5) (%f)))
        i)))))

(define-test length.string.1
  (assert-equal
   0
   (length "")))

(define-test length.string.2
  (assert-equal
   1
   (length "a")))

(define-test length.string.3
  (assert-equal
   13
   (length "abcdefghijklm")))

(define-test length.string.4
  (assert-equal
   1
   (length "\ ")))

(define-test length.string.5
  (assert-equal
   '(5 1)
   (let ((i 0))
     (flet ((%f () (incf i)
              (make-string 5 :initial-element #\a)))
       (list (length (the (simple-string 5) (%f))) i)))))
  

(define-test length.string.6
  (assert-equal
   '(5 1)
   (let ((i 0))
     (flet ((%f () (incf i)
              (make-array 5 :element-type 'base-char
                          :initial-element #\a)))
       (list (length (the (simple-base-string 5) (%f))) i)))))

(define-test length.error.6
  (let ((fun nil)
	(warned nil))
    (handler-bind ((warning (lambda (condition)
			      (setf warned t)
			      (muffle-warning condition))))
      (setf fun
	    (compile nil '(lambda ()
			   (length)))))
    (assert-true warned)
    (assert-error 'program-error (funcall fun))))

(define-test length.error.7
  (let ((fun nil)
	(warned nil))
    (handler-bind ((warning (lambda (condition)
			      (setf warned t)
			      (muffle-warning condition))))
      (setf fun
	    (compile nil '(lambda ()
			   (length nil nil)))))
    (assert-true warned)
    (assert-error 'program-error (funcall fun))))

(define-test length.error.8
  (assert-error 'type-error (locally (length 'a) t)))

;;; Length on vectors created with make-array

(define-test length.array.1
  (assert-equal
   20
   (length (make-array '(20)))))

(define-test length.array.2
  (assert-equal
   100001
   (length (make-array '(100001)))))

(define-test length.array.3
  (assert-equal
   0
   (length (make-array '(0)))))

(define-test length.array.4
  (assert-equal
   10
   (let ((x (make-array '(100) :fill-pointer 10)))
     (length x))))

(define-test length.array.5
  (assert-equal
   20
   (let ((x (make-array '(100) :fill-pointer 10)))
     (setf (fill-pointer x) 20)
     (length x))))

;;; Unusual vectors

(define-test length.array.6
  (assert-equal
   nil
   (loop for i from 1 to 40
         for etype = `(unsigned-byte ,i)
         for vec = (make-array 7 :element-type etype :initial-element 0)
         for len = (length vec)
         unless (eql len 7)
           collect (list i vec len))))

(define-test length.array.7
  (assert-equal
   nil
   (loop for i from 1 to 40
         for etype = `(signed-byte ,i)
         for vec = (make-array 13 :element-type etype :initial-element 0)
         for len = (length vec)
         unless (eql len 13)
           collect (list i vec len))))

(define-test length.array.8
  (assert-equal
   nil
   (loop for etype in '(short-float single-float double-float long-float rational)
         for vec = (make-array 5 :element-type etype :initial-element (coerce 0 etype))
         for len = (length vec)
         unless (eql len 5)
           collect (list etype vec len))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function remove

(define-test test.remove.list.1
  (assert-equal
   '()
   (remove 0 '())))

(define-test test.remove.list.2
  (assert-equal
   '()
   (remove 0 '(0))))

(define-test test.remove.list.3
  (assert-equal
   '()
   (remove 0 '(0 0))))

(define-test test.remove.list.4
  (assert-equal
   '(1)
   (remove 0 '(1))))

(define-test test.remove.list.5
  (assert-equal
   '(1)
   (remove 0 '(0 1 0))))

(define-test test.remove.list.6
  (assert-equal
   '()
   (remove '(a) '() :test #'equal)))

(define-test test.remove.list.7
  (assert-equal
   '()
   (remove '(a) '((a)) :test #'equal)))

(define-test test.remove.list.8
  (assert-equal
   '((b) (b))
   (remove '(a) '((b) (a) (b)) :test #'equal)))

(define-test test.remove.list.9
  (assert-equal
   '()
   (remove '(a) '() :test #'equal :key #'car)))

(define-test test.remove.list.10
  (assert-equal
   '()
   (remove '(a) '(((a))) :test #'equal :key #'car)))

(define-test test.remove.list.11
  (assert-equal
   '(((b)) ((b)))
   (remove '(a) '(((b)) ((a)) ((b))) :test #'equal :key #'car)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 
;;; Tests for function substitute

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=identity 1|
  (assert-equal
   '(0 0)
   (substitute 1 2 '(0 0))))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=identity 2|
  (assert-equal
   '(1)
   (substitute 1 2 '(2))))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=identity 3|
  (assert-equal
   '(1)
   (substitute 1 2 '(1))))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=identity 4|
  (assert-equal
   '(0 1)
   (substitute 1 2 '(0 2))))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=identity 5|
  (assert-equal
   '(0 1 3 1)
   (substitute 1 2 '(0 2 3 2))))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=identity 6|
  (assert-error 
   'type-error
   (substitute 1 2 'a)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=identity 7|
  (assert-error
   'type-error
   (substitute 1 2 '(2 0 . 3))))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=identity 8|
  (assert-equal
   '(0 0)
   (substitute 1 2 '(0 0) :test #'eql)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=identity 9|
  (assert-equal
   '(1)
   (substitute 1 2 '(2) :test #'eql)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=identity 10|
  (assert-equal
   '(1)
   (substitute 1 2 '(1) :test #'eql)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=identity 11|
  (assert-equal
   '(0 1)
   (substitute 1 2 '(0 2) :test #'eql)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=identity 12|
  (assert-equal
   '(0 1 3 1)
   (substitute 1 2 '(0 2 3 2) :test #'eql)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=identity 13|
  (assert-error 
   'type-error
   (substitute 1 2 'a :test #'eql)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=identity 14|
  (assert-error
   'type-error
   (substitute 1 2 '(2 0 . 3) :test #'eql)))

(define-test |substitute seq-type=list start=other end=nil test=eql count=nil key=identity 1|
  (assert-equal
   '(2 2)
   (substitute 1 2 '(2 2) :start 2)))

(define-test |substitute seq-type=list start=other end=nil test=eql count=nil key=identity 2|
  (assert-equal
   '(2 1)
   (substitute 1 2 '(2 2) :start 1)))

(define-test |substitute seq-type=list start=other end=nil test=eql count=nil key=identity 3|
  (assert-error
   'type-error
   (substitute 1 2 '(2 2) :start 3)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=other 1|
  (assert-equal
   '((0) (0))
   (substitute 1 2 '((0) (0)) :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=other 2|
  (assert-equal
   '(1)
   (substitute 1 2 '((2)) :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=other 3|
  (assert-equal
   '((1))
   (substitute 1 2 '((1)) :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=other 4|
  (assert-equal
   '((0) 1)
   (substitute 1 2 '((0) (2)) :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=other 5|
  (assert-equal
   '((0) 1 (3) 1)
   (substitute 1 2 '((0) (2) (3) (2)) :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=other 6|
  (assert-error 
   'type-error
   (substitute 1 2 'a :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=other 7|
  (assert-error
   'type-error
   (substitute 1 2 '((2) (0) . 3) :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=other 8|
  (assert-equal
   '((0) (0))
   (substitute 1 2 '((0) (0)) :test #'eql :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=other 9|
  (assert-equal
   '(1)
   (substitute 1 2 '((2)) :test #'eql :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=other 10|
  (assert-equal
   '((1))
   (substitute 1 2 '((1)) :test #'eql :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=other 11|
  (assert-equal
   '((0) 1)
   (substitute 1 2 '((0) (2)) :test #'eql :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=other 12|
  (assert-equal
   '((0) 1 (3) 1)
   (substitute 1 2 '((0) (2) (3) (2)) :test #'eql :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=other 13|
  (assert-error 
   'type-error
   (substitute 1 2 'a :test #'eql :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eql count=nil key=other 14|
  (assert-error
   'type-error
   (substitute 1 2 '((2) (0) . 3) :test #'eql :key #'car)))

(define-test |substitute seq-type=list start=other end=nil test=eql count=nil key=other 1|
  (assert-equal
   '((2) (2))
   (substitute 1 2 '((2) (2)) :start 2 :key #'car)))

(define-test |substitute seq-type=list start=other end=nil test=eql count=nil key=other 2|
  (assert-equal
   '((2) 1)
   (substitute 1 2 '((2) (2)) :start 1 :key #'car)))

(define-test |substitute seq-type=list start=other end=nil test=eql count=nil key=other 3|
  (assert-error
   'type-error
   (substitute 'b 'c '((c) (c)) :start 3 :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eq count=nil key=identity 1|
  (assert-equal
   '(a a)
   (substitute 'b 'c '(a a) :test #'eq)))

(define-test |substitute seq-type=list start=0 end=nil test=eq count=nil key=identity 2|
  (assert-equal
   '(b)
   (substitute 'b 'c '(c) :test #'eq)))

(define-test |substitute seq-type=list start=0 end=nil test=eq count=nil key=identity 3|
  (assert-equal
   '(b)
   (substitute 'b 'c '(b) :test #'eq)))

(define-test |substitute seq-type=list start=0 end=nil test=eq count=nil key=identity 4|
  (assert-equal
   '(a b)
   (substitute 'b 'c '(a c) :test #'eq)))

(define-test |substitute seq-type=list start=0 end=nil test=eq count=nil key=identity 5|
  (assert-equal
   '(a b d b)
   (substitute 'b 'c '(a c d c) :test #'eq)))

(define-test |substitute seq-type=list start=0 end=nil test=eq count=nil key=identity 6|
  (assert-error 
   'type-error
   (substitute 'b 'c 'a :test #'eq)))

(define-test |substitute seq-type=list start=0 end=nil test=eq count=nil key=identity 7|
  (assert-error
   'type-error
   (substitute 'b 'c '(c a . d) :test #'eq)))

(define-test |substitute seq-type=list start=other end=nil test=eq count=nil key=identity 1|
  (assert-equal
   '(c c)
   (substitute 'b 'c '(c c) :start 2 :test #'eq)))

(define-test |substitute seq-type=list start=other end=nil test=eq count=nil key=identity 2|
  (assert-equal
   '(c b)
   (substitute 'b 'c '(c c) :start 1 :test #'eq)))

(define-test |substitute seq-type=list start=other end=nil test=eq count=nil key=identity 3|
  (assert-error
   'type-error
   (substitute 'b 'c '(c c) :start 3 :test #'eq)))

(define-test |substitute seq-type=list start=0 end=nil test=eq count=nil key=other 1|
  (assert-equal
   '((a) (a))
   (substitute 'b 'c '((a) (a)) :test #'eq :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eq count=nil key=other 2|
  (assert-equal
   '(b)
   (substitute 'b 'c '((c)) :test #'eq :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eq count=nil key=other 3|
  (assert-equal
   '((b))
   (substitute 'b 'c '((b)) :test #'eq :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eq count=nil key=other 4|
  (assert-equal
   '((a) b)
   (substitute 'b 'c '((a) (c)) :test #'eq :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eq count=nil key=other 5|
  (assert-equal
   '((a) b (3) b)
   (substitute 'b 'c '((a) (c) (3) (c)) :test #'eq :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eq count=nil key=other 6|
  (assert-error 
   'type-error
   (substitute 'b 'c 'a :test #'eq :key #'car)))

(define-test |substitute seq-type=list start=0 end=nil test=eq count=nil key=other 7|
  (assert-error
   'type-error
   (substitute 'b 'c '((c) (a) . 3) :test #'eq :key #'car)))

(define-test |substitute seq-type=list start=other end=nil test=eq count=nil key=other 1|
  (assert-equal
   '((c) (c))
   (substitute 'b 'c '((c) (c)) :start 2 :test #'eq :key #'car)))

(define-test |substitute seq-type=list start=other end=nil test=eq count=nil key=other 2|
  (assert-equal
   '((c) b)
   (substitute 'b 'c '((c) (c)) :start 1 :test #'eq :key #'car)))

(define-test |substitute seq-type=list start=other end=nil test=eq count=nil key=other 3|
  (assert-error
   'type-error
   (substitute 'b 'c '((c) (c)) :start 3 :test #'eq :key #'car)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=identity

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=identity start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=identity start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=identity start=0 end=nil from-end=nil

;;; Check that it works with the empty list and no explicitly given test, 
;;; and no explicit start given.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 1a|
  (assert-equal nil
		(position 1 '())))

;;; Check that it works with the empty list and :test #'eql given
;;; and no explicit start given.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 1b|
  (assert-equal nil
		(position 1 '() :test #'eql)))

;;; Check that it works with the empty list and :test 'eql given
;;; and no explicit start given.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 1c|
  (assert-equal nil
		(position 1 '() :test 'eql)))

;;; Check that it works with the empty list and no explicitly given test, 
;;; and an explicit start of 0 given.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 2a|
  (assert-equal nil
		(position 1 '() :start 0)))

;;; Check that it works with the empty list and :test #'eql given
;;; and an explicit start of 0 given.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 2b|
  (assert-equal nil
		(position 1 '() :start 0 :test #'eql)))

;;; Check that it works with the empty list and :test 'eql given
;;; and an explicit start of 0 given.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 2c|
  (assert-equal nil
		(position 1 '() :start 0 :test 'eql)))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 3a|
  (assert-equal 1
		(position *i01* (list *i1* *i02* *i01* *i2*))))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 3b|
  (assert-equal 1
		(position *i01* (list *i1* *i02* *i01* *i2*) :test #'eql)))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 3c|
  (assert-equal 1
		(position *i01* (list *i1* *i02* *i01* *i2*) :test 'eql)))

;;; Check that we get nil back if the number is not in the list.
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 4a|
  (assert-equal nil
		(position *i01* (list *i1* *i2* *i3*))))

;;; Check that we get nil back if the number is not in the list.
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 4b|
  (assert-equal nil
		(position *i01* (list *i1* *i2* *i3*) :test #'eql)))

;;; Check that we get nil back if the number is not in the list.
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 4c|
  (assert-equal nil
		(position *i01* (list *i1* *i2* *i3*) :test 'eql)))

;;; Check that we do not accidentally use equal
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 5a|
  (assert-equal nil
		(position (list 'a) (list (list 'a)))))

;;; Check that we do not accidentally use equal
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 5b|
  (assert-equal nil
		(position (list 'a) (list (list 'a)) :test #'eql)))

;;; Check that we do not accidentally use equal
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 5c|
  (assert-equal nil
		(position (list 'a) (list (list 'a)) :test 'eql)))

;;; Check that we get a type error when we pass something that is not
;;; a sequence.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 6a|
  (assert-error 'type-error
		(position 0 1)))

;;; Check that we get a type error when we pass something that is not
;;; a sequence.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 6b|
  (assert-error 'type-error
		(position 0 1 :test #'eql)))

;;; Check that we get a type error when we pass something that is not
;;; a sequence.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 6c|
  (assert-error 'type-error
		(position 0 1 :test 'eql)))

;;; Check that we get a type error when we pass a dotted list and 
;;; the item is not in the sequence.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 7a|
  (assert-error 'type-error
		(position 0 '(1 1 . 1))))

;;; Check that we get a type error when we pass a dotted list and 
;;; the item is not in the sequence.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 7b|
  (assert-error 'type-error
		(position 0 '(1 1 . 1) :test #'eql)))

;;; Check that we get a type error when we pass a dotted list and 
;;; the item is not in the sequence.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=nil 7c|
  (assert-error 'type-error
		(position 0 '(1 1 . 1) :test 'eql)))

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=identity start=0 end=nil from-end=t

;;; Check that it works with the empty list and no explicitly given test, 
;;; and no explicit start given.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 1a|
  (assert-equal nil
		(position 1 '() :from-end t)))

;;; Check that it works with the empty list and :test #'eql given
;;; and no explicit start given.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 1b|
  (assert-equal nil
		(position 1 '() :test #'eql :from-end t)))

;;; Check that it works with the empty list and :test 'eql given
;;; and no explicit start given.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 1c|
  (assert-equal nil
		(position 1 '() :test 'eql :from-end t)))

;;; Check that it works with the empty list and no explicitly given test, 
;;; and an explicit start of 0 given.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 2a|
  (assert-equal nil
		(position 1 '() :start 0 :from-end t)))

;;; Check that it works with the empty list and :test #'eql given
;;; and an explicit start of 0 given.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 2b|
  (assert-equal nil
		(position 1 '() :start 0 :test #'eql :from-end t)))

;;; Check that it works with the empty list and :test 'eql given
;;; and an explicit start of 0 given.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 2c|
  (assert-equal nil
		(position 1 '() :start 0 :test 'eql :from-end t)))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 3a|
  (assert-equal 2
		(position *i01* (list *i1* *i01* *i02* *i2*) :from-end t)))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 3b|
  (assert-equal 2
		(position *i01* (list *i1* *i01* *i02* *i2*) :test #'eql :from-end t)))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 3c|
  (assert-equal 2
		(position *i01* (list *i1* *i01* *i02* *i2*) :test 'eql :from-end t)))

;;; Check that we get nil back if the number is not in the list.
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 4a|
  (assert-equal nil
		(position *i01* (list *i1* *i2* *i3*) :from-end t)))

;;; Check that we get nil back if the number is not in the list.
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 4b|
  (assert-equal nil
		(position *i01* (list *i1* *i2* *i3*) :test #'eql :from-end t)))

;;; Check that we get nil back if the number is not in the list.
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 4c|
  (assert-equal nil
		(position *i01* (list *i1* *i2* *i3*) :test 'eql :from-end t)))

;;; Check that we do not accidentally use equal
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 5a|
  (assert-equal nil
		(position (list 'a) (list (list 'a)) :from-end t)))

;;; Check that we do not accidentally use equal
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 5b|
  (assert-equal nil
		(position (list 'a) (list (list 'a)) :test #'eql :from-end t)))

;;; Check that we do not accidentally use equal
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 5c|
  (assert-equal nil
		(position (list 'a) (list (list 'a)) :test 'eql :from-end t)))

;;; Check that we get a type error when we pass a dotted list and 
;;; the item is not in the sequence.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 7a|
  (assert-error 'type-error
		(position 0 '(1 1 . 1) :from-end t)))

;;; Check that we get a type error when we pass a dotted list and 
;;; the item is not in the sequence.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 7b|
  (assert-error 'type-error
		(position 0 '(1 1 . 1) :test #'eql :from-end t)))

;;; Check that we get a type error when we pass a dotted list and 
;;; the item is not in the sequence.
(define-test |position seq-type=list test=eql key=identity start=0 end=nil from-end=true 7c|
  (assert-error 'type-error
		(position 0 '(1 1 . 1) :test 'eql :from-end t)))

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=identity start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=identity start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=identity start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=identity start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=identity start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=identity start=other end=nil from-end=nil

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=identity start=other end=nil from-end=nil 2a|
  (assert-equal 1
		(position *i01* (list *i1* *i02* *i2*) :start 1)))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=identity start=other end=nil from-end=nil 2b|
  (assert-equal 1
		(position *i01* (list *i1* *i02* *i2*) :test #'eql :start 1)))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=identity start=other end=nil from-end=nil 2c|
  (assert-equal 1
		(position *i01* (list *i1* *i02* *i2*) :test 'eql :start 1)))

;;; Check that we do not find n eql number because of the value of start
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=identity start=other end=nil from-end=nil 3a|
  (assert-equal nil
		(position *i01* (list *i1* *i02* *i2*) :start 2)))

;;; Check that we do not find n eql number because of the value of start
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=identity start=other end=nil from-end=nil 3b|
  (assert-equal nil
		(position *i01* (list *i1* *i02* *i2*) :test #'eql :start 2)))

;;; Check that we do not find n eql number because of the value of start
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=identity start=other end=nil from-end=nil 3c|
  (assert-equal nil
		(position *i01* (list *i1* *i02* *i2*) :test 'eql :start 2)))

;;; Check that we get an error when start is beyond the end of the list
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=identity start=other end=nil from-end=nil 4a|
  (assert-error 'type-error
		(position *i01* (list *i1* *i02* *i2*) :start 4)))

;;; Check that we get an error when start is beyond the end of the list
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=identity start=other end=nil from-end=nil 4b|
  (assert-error 'type-error
		(position *i01* (list *i1* *i02* *i2*) :test #'eql :start 4)))

;;; Check that we get an error when start is beyond the end of the list
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=identity start=other end=nil from-end=nil 4c|
  (assert-error 'type-error
		(position *i01* (list *i1* *i02* *i2*) :test 'eql :start 4)))

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=identity start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=identity start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=identity start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=identity start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=other start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=other start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=other start=0 end=nil from-end=nil

;;; Check that it works with the empty list and no explicitly given test, 
;;; and no explicit start given.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 1a|
  (assert-equal nil
		(position 1 '()
			  :key #'car)))

;;; Check that it works with the empty list and :test #'eql given
;;; and no explicit start given.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 1b|
  (assert-equal nil
		(position 1 '()
			  :test #'eql :key #'car)))

;;; Check that it works with the empty list and :test 'eql given
;;; and no explicit start given.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 1c|
  (assert-equal nil
		(position 1 '()
			  :test 'eql :key #'car)))

;;; Check that it works with the empty list and no explicitly given test, 
;;; and an explicit start of 0 given.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 2a|
  (assert-equal nil
		(position 1 '()
			  :start 0 :key #'car)))

;;; Check that it works with the empty list and :test #'eql given
;;; and an explicit start of 0 given.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 2b|
  (assert-equal nil
		(position 1 '()
			  :start 0 :test #'eql :key #'car)))

;;; Check that it works with the empty list and :test 'eql given
;;; and an explicit start of 0 given.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 2c|
  (assert-equal nil
		(position 1 '()
			  :start 0 :test 'eql :key #'car)))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 3a|
  (let ((element (list *i02*)))
    (assert-equal 1
		  (position *i01* (list (list *i1*) element (list *i01*) (list *i2*))
			    :key #'car))))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 3b|
  (let ((element (list *i02*)))
    (assert-equal 1
		  (position *i01* (list (list *i1*) element (list *i01*) (list *i2*))
			    :test #'eql :key #'car))))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 3c|
  (let ((element (list *i02*)))
    (assert-equal 1
		  (position *i01* (list (list *i1*) element (list *i01*) (list *i2*))
			    :test 'eql :key #'car))))

;;; Check that we get nil back if the number is not in the list.
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 4a|
  (assert-equal nil
		(position *i01* (list (list *i1*) (list *i2*) (list *i3*))
			  :key #'car)))

;;; Check that we get nil back if the number is not in the list.
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 4b|
  (assert-equal nil
		(position *i01* (list (list *i1*) (list *i2*) (list *i3*))
			  :test #'eql :key #'car)))

;;; Check that we get nil back if the number is not in the list.
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 4c|
  (assert-equal nil
		(position *i01* (list (list *i1*) (list *i2*) (list *i3*))
			  :test 'eql :key #'car)))

;;; Check that we do not accidentally use equal
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 5a|
  (assert-equal nil
		(position (list (list 'a)) (list (list (list 'a)))
			  :key #'car)))

;;; Check that we do not accidentally use equal
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 5b|
  (assert-equal nil
		(position (list (list 'a)) (list (list (list 'a)))
			  :test #'eql :key #'car)))

;;; Check that we do not accidentally use equal
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 5c|
  (assert-equal nil
		(position (list (list 'a)) (list (list (list 'a)))
			  :test 'eql :key #'car)))

;;; Check that we get a type error when we pass something that is not
;;; a sequence.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 6a|
  (assert-error 'type-error
		(position 0 1
			  :key #'car)))

;;; Check that we get a type error when we pass something that is not
;;; a sequence.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 6b|
  (assert-error 'type-error
		(position 0 1
			  :test #'eql :key #'car)))

;;; Check that we get a type error when we pass something that is not
;;; a sequence.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 6c|
  (assert-error 'type-error
		(position 0 1
			  :test 'eql :key #'car)))

;;; Check that we get a type error when we pass a dotted list and 
;;; the item is not in the sequence.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 7a|
  (assert-error 'type-error
		(position 0 '((1) (1) . 1)
			  :key #'car)))

;;; Check that we get a type error when we pass a dotted list and 
;;; the item is not in the sequence.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 7b|
  (assert-error 'type-error
		(position 0 '((1) (1) . 1)
			  :test #'eql :key #'car)))

;;; Check that we get a type error when we pass a dotted list and 
;;; the item is not in the sequence.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=nil 7c|
  (assert-error 'type-error
		(position 0 '((1) (1) . 1)
			  :test 'eql :key #'car)))

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=other start=0 end=nil from-end=t

;;; Check that it works with the empty list and no explicitly given test, 
;;; and no explicit start given.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 1a|
  (assert-equal nil
		(position 1 '()
			  :key #'car :from-end t)))

;;; Check that it works with the empty list and :test #'eql given
;;; and no explicit start given.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 1b|
  (assert-equal nil
		(position 1 '()
			  :test #'eql :key #'car :from-end t)))

;;; Check that it works with the empty list and :test 'eql given
;;; and no explicit start given.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 1c|
  (assert-equal nil
		(position 1 '()
			  :test 'eql :key #'car :from-end t)))

;;; Check that it works with the empty list and no explicitly given test, 
;;; and an explicit start of 0 given.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 2a|
  (assert-equal nil
		(position 1 '()
			  :start 0 :key #'car :from-end t)))

;;; Check that it works with the empty list and :test #'eql given
;;; and an explicit start of 0 given.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 2b|
  (assert-equal nil
		(position 1 '()
			  :start 0 :test #'eql :key #'car :from-end t)))

;;; Check that it works with the empty list and :test 'eql given
;;; and an explicit start of 0 given.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 2c|
  (assert-equal nil
		(position 1 '()
			  :start 0 :test 'eql :key #'car :from-end t)))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 3a|
  (let ((element (list *i02*)))
    (assert-equal 2
		  (position *i01* (list (list *i1*) (list *i01*) element (list *i2*))
			    :key #'car :from-end t))))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 3b|
  (let ((element (list *i02*)))
    (assert-equal 2
		  (position *i01* (list (list *i1*) (list *i01*) element (list *i2*))
			    :test #'eql :key #'car :from-end t))))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 3c|
  (let ((element (list *i02*)))
    (assert-equal 2
		  (position *i01* (list (list *i1*) (list *i01*) element (list *i2*))
			    :test 'eql :key #'car :from-end t))))

;;; Check that we get nil back if the number is not in the list.
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 4a|
  (assert-equal nil
		(position *i01* (list (list *i1*) (list *i2*) (list *i3*))
			  :key #'car)))

;;; Check that we get nil back if the number is not in the list.
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 4b|
  (assert-equal nil
		(position *i01* (list (list *i1*) (list *i2*) (list *i3*))
			  :test #'eql :key #'car :from-end t)))

;;; Check that we get nil back if the number is not in the list.
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 4c|
  (assert-equal nil
		(position *i01* (list (list *i1*) (list *i2*) (list *i3*))
			  :test 'eql :key #'car :from-end t)))

;;; Check that we do not accidentally use equal
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 5a|
  (assert-equal nil
		(position (list (list 'a)) (list (list (list 'a)))
			  :key #'car :from-end t)))

;;; Check that we do not accidentally use equal
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 5b|
  (assert-equal nil
		(position (list (list 'a)) (list (list (list 'a)))
			  :test #'eql :key #'car :from-end t)))

;;; Check that we do not accidentally use equal
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 5c|
  (assert-equal nil
		(position (list (list 'a)) (list (list (list 'a)))
			  :test 'eql :key #'car :from-end t)))

;;; Check that we get a type error when we pass something that is not
;;; a sequence.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 6a|
  (assert-error 'type-error
		(position 0 1
			  :key #'car :from-end t)))

;;; Check that we get a type error when we pass something that is not
;;; a sequence.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 6b|
  (assert-error 'type-error
		(position 0 1
			  :test #'eql :key #'car :from-end t)))

;;; Check that we get a type error when we pass something that is not
;;; a sequence.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 6c|
  (assert-error 'type-error
		(position 0 1
			  :test 'eql :key #'car :from-end t)))

;;; Check that we get a type error when we pass a dotted list and 
;;; the item is not in the sequence.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 7a|
  (assert-error 'type-error
		(position 0 '((1) (1) . 1)
			  :key #'car :from-end t)))

;;; Check that we get a type error when we pass a dotted list and 
;;; the item is not in the sequence.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 7b|
  (assert-error 'type-error
		(position 0 '((1) (1) . 1)
			  :test #'eql :key #'car :from-end t)))

;;; Check that we get a type error when we pass a dotted list and 
;;; the item is not in the sequence.
(define-test |position seq-type=list test=eql key=other start=0 end=nil from-end=true 7c|
  (assert-error 'type-error
		(position 0 '((1) (1) . 1)
			  :test 'eql :key #'car :from-end t)))

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=other start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=other start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=other start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=other start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=other start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=other start=other end=nil from-end=nil

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=other start=other end=nil from-end=nil 2a|
  (let ((element (list *i02*)))
    (assert-equal 1
		  (position *i01* (list (list *i1*) element (list *i2*))
			    :start 1 :key #'car))))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=other start=other end=nil from-end=nil 2b|
  (let ((element (list *i02*)))
    (assert-equal 1
		  (position *i01* (list (list *i1*) element (list *i2*))
			    :test #'eql :start 1 :key #'car))))

;;; Check that we find a eql number (but probably not eq) in a list.  
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=other start=other end=nil from-end=nil 2c|
  (let ((element (list *i02*)))
    (assert-equal 1
		  (position *i01* (list (list *i1*) element (list *i2*))
			    :test 'eql :start 1 :key #'car))))

;;; Check that we do not find n eql number because of the value of start
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=other start=other end=nil from-end=nil 3a|
  (let ((element (list *i02*)))
    (assert-equal nil
		  (position *i01* (list (list *i1*) element (list *i2*))
			    :start 2 :key #'car))))

;;; Check that we do not find n eql number because of the value of start
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=other start=other end=nil from-end=nil 3b|
  (let ((element (list *i02*)))
    (assert-equal nil
		  (position *i01* (list (list *i1*) element (list *i2*))
			    :test #'eql :start 2 :key #'car))))

;;; Check that we do not find n eql number because of the value of start
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=other start=other end=nil from-end=nil 3c|
  (let ((element (list *i02*)))
    (assert-equal nil
		  (position *i01* (list (list *i1*) element (list *i2*))
			    :test 'eql :start 2 :key #'car))))

;;; Check that we get an error when start is beyond the end of the list
;;; A test of eql is implicit.
(define-test |position seq-type=list test=eql key=other start=other end=nil from-end=nil 4a|
  (let ((element (list *i02*)))
    (assert-error 'type-error
		  (position *i01* (list (list *i1*) element (list *i2*))
			    :start 4 :key #'car))))

;;; Check that we get an error when start is beyond the end of the list
;;; A test of eql is explicit by passing the function.
(define-test |position seq-type=list test=eql key=other start=other end=nil from-end=nil 4b|
  (let ((element (list *i02*)))
    (assert-error 'type-error
		  (position *i01* (list (list *i1*) element (list *i2*))
			    :test #'eql :start 4 :key #'car))))

;;; Check that we get an error when start is beyond the end of the list
;;; A test of eql is explicit by passing the name of the function. 
(define-test |position seq-type=list test=eql key=other start=other end=nil from-end=nil 4c|
  (let ((element (list *i02*)))
    (assert-error 'type-error
		  (position *i01* (list (list *i1*) element (list *i2*))
			    :test 'eql :start 4 :key #'car))))

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=other start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=other start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=other start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eql key=other start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=identity

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=identity start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=identity start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=identity start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=identity start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=identity start=0 end=true

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=identity start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=identity start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=identity start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=identity start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=identity start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=identity start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=identity start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=identity start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=identity start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=other start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=other start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=other start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=other start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=other start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=other start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=other start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=other start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=other start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=other start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=other start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=other start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=other start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=eq key=other start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=identity

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=identity start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=identity start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=identity start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=identity start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=identity start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=identity start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=identity start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=identity start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=identity start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=identity start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=identity start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=identity start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=identity start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=identity start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=other start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=other start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=other start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=other start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=other start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=other start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=other start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=other start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=other start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=other start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=other start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=other start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=other start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test=other key=other start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=identity

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=identity start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=identity start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=identity start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=identity start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=identity start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=identity start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=identity start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=identity start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=identity start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=identity start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=identity start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=identity start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=identity start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=identity start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=other start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=other start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=other start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=other start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=other start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=other start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=other start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=other start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=other start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=other start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=other start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=other start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=other start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eql key=other start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=identity

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=identity start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=identity start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=identity start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=identity start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=identity start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=identity start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=identity start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=identity start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=identity start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=identity start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=identity start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=identity start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=identity start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=identity start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=other start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=other start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=other start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=other start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=other start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=other start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=other start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=other start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=other start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=other start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=other start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=other start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=other start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=eq key=other start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=identity

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=identity start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=identity start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=identity start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=identity start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=identity start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=identity start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=identity start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=identity start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=identity start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=identity start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=identity start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=identity start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=identity start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=identity start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=other start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=other start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=other start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=other start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=other start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=other start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=other start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=other start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=other start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=other start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=other start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=other start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=other start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=list test-not=other key=other start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=identity

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=identity start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=identity start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=identity start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=identity start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=identity start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=identity start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=identity start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=identity start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=identity start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=identity start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=identity start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=identity start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=identity start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=identity start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=other start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=other start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=other start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=other start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=other start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=other start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=other start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=other start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=other start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=other start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=other start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=other start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=other start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eql key=other start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=identity

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=identity start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=identity start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=identity start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=identity start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=identity start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=identity start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=identity start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=identity start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=identity start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=identity start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=identity start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=identity start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=identity start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=identity start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=other start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=other start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=other start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=other start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=other start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=other start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=other start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=other start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=other start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=other start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=other start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=other start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=other start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=eq key=other start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=identity

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=identity start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=identity start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=identity start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=identity start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=identity start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=identity start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=identity start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=identity start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=identity start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=identity start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=identity start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=identity start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=identity start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=identity start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=other start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=other start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=other start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=other start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=other start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=other start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=other start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=other start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=other start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=other start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=other start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=other start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=other start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test=other key=other start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=identity

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=identity start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=identity start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=identity start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=identity start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=identity start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=identity start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=identity start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=identity start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=identity start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=identity start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=identity start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=identity start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=identity start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=identity start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=other start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=other start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=other start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=other start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=other start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=other start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=other start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=other start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=other start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=other start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=other start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=other start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=other start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eql key=other start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=identity

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=identity start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=identity start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=identity start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=identity start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=identity start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=identity start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=identity start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=identity start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=identity start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=identity start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=identity start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=identity start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=identity start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=identity start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=other start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=other start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=other start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=other start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=other start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=other start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=other start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=other start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=other start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=other start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=other start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=other start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=other start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=eq key=other start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=identity

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=identity start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=identity start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=identity start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=identity start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=identity start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=identity start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=identity start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=identity start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=identity start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=identity start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=identity start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=identity start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=identity start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=identity start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=other start=0

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=other start=0 end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=other start=0 end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=other start=0 end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=other start=0 end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=other start=0 end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=other start=0 end=true from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=other start=other

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=other start=other end=nil

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=other start=other end=nil from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=other start=other end=nil from-end=t

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=other start=other end=true

;;; DO NOT PUT TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=other start=other end=true from-end=nil

;;; ************** ADD MORE TESTS HERE

;;;;;;;;;;
;;;
;;; Tests for function position
;;; with seq-type=vector test-not=other key=other start=other end=true from-end=t

;;; ************** ADD MORE TESTS HERE

