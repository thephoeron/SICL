(cl:in-package #:sicl-boot)

(defun define-validate-superclass (boot)
  (setf (sicl-genv:fdefinition 'sicl-clos:validate-superclass (r2 boot))
	(constantly t)))

;;; The problem that we are solving here is that during class
;;; initialization, there is a test that each superclass is of type
;;; CLASS, and that test uses TYPEP like this (TYPEP c 'CLASS).  But
;;; if we use the host version of TYPEP, it will return NIL because a
;;; bridge class is not a host class.  We solve this problem by
;;; supplying a slightly modified version of TYPEP in R2.  This
;;; modified version calls the host TYPEP in all cases except when the
;;; second argument is the symbol CLASS.  In that case, it instead
;;; supplies a different second argument to the host TYPEP.  This
;;; second argument is the name that the class named CLASS is know to
;;; by the host.  We can find this name by applying CLASS-NAME to the
;;; metaobject that we obtain by calling FIND-CLASS in R1 with the
;;; symbol CLASS.
(defun define-typep (boot)
  (setf (sicl-genv:fdefinition 'typep (r2 boot))
	(lambda (object type)
	  (typep object
		 (if (eq type 'class)
		     (class-name (sicl-genv:find-class 'class (r1 boot)))
		     type)))))

(defun define-ensure-generic-function (boot)
  (setf (sicl-genv:fdefinition 'ensure-generic-function (r2 boot))
	(lambda (function-name &rest arguments)
	  (declare (ignore arguments))
	  (assert (sicl-genv:fboundp function-name (r3 boot)))
	  (let ((result (sicl-genv:fdefinition function-name (r3 boot))))
	    (assert (eq (class-of result)
			(sicl-genv:find-class 'standard-generic-function
					      (r1 boot))))
	    result))))

(defun define-default-superclasses (boot)
  (setf (sicl-genv:fdefinition 'sicl-clos:default-superclasses (r2 boot))
	(lambda (class)
	  (cond ((eq (class-of class)
		     (sicl-genv:find-class 'standard-class (r1 boot)))
		 (sicl-genv:find-class 'standard-object (r2 boot)))
		((eq (class-of class)
		     (sicl-genv:find-class 'sicl-clos:funcallable-standard-class
					   (r1 boot)))
		 (sicl-genv:find-class 'sicl-clos:funcallable-standard-object
				       (r2 boot)))
		(t
		 '())))))

(defun define-reader-method-class (boot)
  (setf (sicl-genv:fdefinition 'sicl-clos:reader-method-class (r2 boot))
	(lambda (&rest arguments)
	  (declare (ignore arguments))
	  (sicl-genv:find-class 'sicl-clos:standard-reader-method (r1 boot)))))

(defun define-writer-method-class (boot)
  (setf (sicl-genv:fdefinition 'sicl-clos:writer-method-class (r2 boot))
	(lambda (&rest arguments)
	  (declare (ignore arguments))
	  (sicl-genv:find-class 'sicl-clos:standard-writer-method (r1 boot)))))

(defun define-add-method (boot)
  (setf (sicl-genv:fdefinition 'sicl-clos:add-method (r2 boot))
	(lambda (generic-function method)
	  (push method (sicl-clos:generic-function-methods generic-function)))))

(defun customize-r2 (boot)
  (let ((c (c1 boot))
	(r (r2 boot)))
    (define-make-instance boot)
    (define-direct-slot-definition-class boot)
    (define-find-class boot)
    (define-validate-superclass boot)
    (define-typep boot)
    (define-ensure-generic-function boot)
    (define-default-superclasses boot)
    (define-reader-method-class boot)
    (define-writer-method-class boot)
    (define-add-method boot)
    (ld "../CLOS/ensure-generic-function-using-class-support.lisp" c r)))

;;  LocalWords:  metaobject
