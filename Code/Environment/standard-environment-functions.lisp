(cl:in-package #:sicl-standard-environment-functions)

(deftype function-name ()
  `(or symbol (cons (eql setf) (cons symbol null))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function CONSTANTP.

(defun constantp (form &optional (environment (sicl-genv:global-environment)))
  (or (and (not (symbolp form))
	   (not (consp form)))
      (keywordp form)
      (and (symbolp form)
	   (nth-value 1 (sicl-genv:constant-variable form environment)))
      (and (consp form)
	   (eq (car form) 'quote))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function BOUNDP.
;;;
;;; According to the HyperSpec, this function should return any true
;;; value if the name is bound in the global environment and false
;;; otherwise.  We return T when the symbol is bound.  
;;;
;;; The HyperSpec does not say whether the name of a constant variable
;;; is considered to be bound.  We think it is reasonable to consider
;;; it bound in this case.  They HyperSpec also does not say whether
;;; the name of a global symbol macro is considered to be bound.
;;; Again, we think it is reasonable to consider this to be the case,
;;; if for nothing else, then for symmetry with fboundp.
;;;
;;; The symbol is bound as a special variable if it is both the case
;;; that a special variable entry exists for it AND the storage cell
;;; of that entry does not contain +unbound+.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function MAKUNBOUND.
;;;
;;; Since we consider a name bound if it names a constant variable, or
;;; if it names a global symbol macro, we must decide what to do in
;;; those cases.  It would be embarassing for someone to call
;;; MAKUNBOUND successfully and then have BOUNDP return true.  What we
;;; do is to remove the symbol macro if any, and signal an error if an
;;; attempt is made to make a constant variable unbound.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function FBOUNDP.
;;;
;;; According to the HyperSpec, this function should return any true
;;; value if the name is fbound in the global environment.  From the
;;; glossary, we learn that "fbound" means that the name has a
;;; definition as either a function, a macro, or a special operator in
;;; the global environment.

(defun fboundp (function-name)
  (declare (type function-name function-name))
  (sicl-genv:fboundp
   function-name
   (load-time-value (sicl-genv:global-environment))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function FMAKUNBOUND.

(defun fmakunbound (function-name)
  (declare (type function-name function-name))
  (sicl-genv:fmakunbound function-name sicl-genv:*global-environment*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function FDEFINITION.

(defun fdefinition (function-name)
  (declare (type function-name function-name))
  (sicl-genv:fdefinition function-name sicl-genv:*global-environment*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function (SETF FDEFINITION).

(defun (setf fdefinition) (new-definition function-name)
  (declare (type function-name function-name)
	   (type function new-definition))
  (setf (sicl-genv:fdefinition function-name sicl-genv:*global-environment*)
	new-definition))
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function SYMBOL-FUNCTION.

(defun symbol-function (symbol)
  (declare (type symbol symbol))
  (sicl-genv:fdefinition symbol sicl-genv:*global-environment*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function (SETF SYMBOL-FUNCTION).
;;;
;;; According to the HyperSpec, (SETF SYMBOL-FUNCTION) is just like
;;; (SETF FDEFINITION), except that it only accepts a symbol as its
;;; argument.  It suffices thus to check that the argument is a
;;; symbol, and then to call (SETF FDEFINITION) to do the work.

(defun (setf symbol-function) (new-definition symbol)
  (declare (type function new-definition)
	   (type symbol symbol))
  (setf (sicl-genv:fdefinition symbol sicl-genv:*global-environment*)
	new-definition))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function SPECIAL-OPERATOR-P.

(defun special-operator-p (symbol)
  (declare (type symbol symbol))
  (sicl-genv:special-operator symbol sicl-genv:*global-environment*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function COMPILER-MACRO-FUNCTION.

(defun compiler-macro-function (name &optional environment)
  (let ((info (cleavir-env:function-info environment name)))
    (if (null info)
	nil
	(cleavir-env:compiler-macro info))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function (SETF COMPILER-MACRO-FUNCTION).

(defun (setf compiler-macro-function)
    (new-definition name &optional environment)
  (when (null environment)
    (setf environment sicl-genv:*global-environment*))
  (setf (sicl-genv:compiler-macro-function name environment)
	new-definition))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function GET-SETF-EXPANSION.

(defun get-setf-expansion
    (place &optional (environment sicl-genv:*global-environment*))
  (let ((global-environment (cleavir-env:global-environment environment)))
    (if (symbolp place)
	(let ((temp (gensym)))
	  (values '() '() `(,temp) `(setq ,place ,temp) place))
	(let ((expander (sicl-genv:setf-expander (first place) global-environment)))
	  (if (null expander)
	      (let ((temps (mapcar (lambda (p) (declare (ignore p)) (gensym))
				   (rest place)))
		    (new (gensym)))
		(values temps
			(rest place)
			(list new)
			`(funcall #'(setf ,(first place)) ,new ,@temps)
			`(,(first place) ,@temps)))
	      (funcall expander place global-environment))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function FIND-CLASS.

(defun find-class
    (symbol
     &optional
       (errorp t)
       (environment (load-time-value (sicl-genv:global-environment))))
  (let ((class (sicl-genv:find-class symbol environment)))
    (if (and (null class) errorp)
	(error 'no-such-class symbol)
	class)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Function (SETF FIND-CLASS).

(defun (setf find-class)
    (new-class
     symbol
     &optional
       errorp
       (environment (load-time-value (sicl-genv:global-environment))))
  (declare (ignore errorp))
  (setf (sicl-genv:find-class symbol environment)
	new-class))
