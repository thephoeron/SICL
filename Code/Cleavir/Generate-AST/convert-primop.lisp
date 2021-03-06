(in-package #:cleavir-generate-ast)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:TYPEQ.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:typeq)) form env system)
  (cleavir-ast:make-typeq-ast
   (convert (second form) env system)
   (convert-constant (third form) env system)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:CONSP.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:consp)) form env system)
  (cleavir-code-utilities:check-form-proper-list form)
  (cleavir-code-utilities:check-argcount form 1 1)
  (cleavir-ast:make-consp-ast (convert (second form) env system)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:CAR.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:car)) form env system)
  (cleavir-code-utilities:check-form-proper-list form)
  (cleavir-code-utilities:check-argcount form 1 1)
  (cleavir-ast:make-car-ast (convert (second form) env system)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:CDR.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:cdr)) form env system)
  (cleavir-code-utilities:check-form-proper-list form)
  (cleavir-code-utilities:check-argcount form 1 1)
  (cleavir-ast:make-cdr-ast (convert (second form) env system)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:RPLACA.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:rplaca)) form env system)
  (cleavir-code-utilities:check-form-proper-list form)
  (cleavir-code-utilities:check-argcount form 2 2)
  (cleavir-ast:make-rplaca-ast (convert (second form) env system)
			       (convert (third form) env system)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:RPLACD.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:rplacd)) form env system)
  (cleavir-code-utilities:check-form-proper-list form)
  (cleavir-code-utilities:check-argcount form 2 2)
  (cleavir-ast:make-rplacd-ast (convert (second form) env system)
			       (convert (third form) env system)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-ARITHMETIC.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-arithmetic)) form env system)
  (cleavir-code-utilities:check-form-proper-list form)
  (cleavir-code-utilities:check-argcount form 4 4)
  (destructuring-bind (variable operation normal overflow) (cdr form)
    (assert (symbolp variable))
    (let ((new-env (cleavir-env:add-lexical-variable env variable)))
      (cleavir-ast:make-if-ast (convert operation new-env system)
			       (convert normal new-env system)
			       (convert overflow new-env system)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-+.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-+)) form env system)
  (cleavir-code-utilities:check-form-proper-list form)
  (cleavir-code-utilities:check-argcount form 3 3)
  (destructuring-bind (arg1 arg2 variable) (cdr form)
    (cleavir-ast:make-fixnum-add-ast (convert arg1 env system)
				     (convert arg2 env system)
				     (convert variable env system))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM--.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum--)) form env system)
  (cleavir-code-utilities:check-form-proper-list form)
  (cleavir-code-utilities:check-argcount form 3 3)
  (destructuring-bind (arg1 arg2 variable) (cdr form)
    (cleavir-ast:make-fixnum-sub-ast (convert arg1 env system)
				     (convert arg2 env system)
				     (convert variable env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-<.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-<)) form env system)
  (cleavir-code-utilities:check-form-proper-list form)
  (cleavir-code-utilities:check-argcount form 2 2)
  (destructuring-bind (arg1 arg2) (cdr form)
    (make-instance 'cleavir-ast:fixnum-less-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-<=.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-<=)) form env system)
  (cleavir-code-utilities:check-form-proper-list form)
  (cleavir-code-utilities:check-argcount form 2 2)
  (destructuring-bind (arg1 arg2) (cdr form)
    (make-instance 'cleavir-ast:fixnum-not-greater-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM->.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum->)) form env system)
  (cleavir-code-utilities:check-form-proper-list form)
  (cleavir-code-utilities:check-argcount form 2 2)
  (destructuring-bind (arg1 arg2) (cdr form)
    (make-instance 'cleavir-ast:fixnum-greater-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM->=.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum->=)) form env system)
  (cleavir-code-utilities:check-form-proper-list form)
  (cleavir-code-utilities:check-argcount form 2 2)
  (destructuring-bind (arg1 arg2) (cdr form)
    (make-instance 'cleavir-ast:fixnum-not-less-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Converting CLEAVIR-PRIMOP:FIXNUM-=.

(defmethod convert-special
    ((symbol (eql 'cleavir-primop:fixnum-=)) form env system)
  (cleavir-code-utilities:check-form-proper-list form)
  (cleavir-code-utilities:check-argcount form 2 2)
  (destructuring-bind (arg1 arg2) (cdr form)
    (make-instance 'cleavir-ast:fixnum-equal-ast
      :arg1-ast (convert arg1 env system)
      :arg2-ast (convert arg2 env system))))
