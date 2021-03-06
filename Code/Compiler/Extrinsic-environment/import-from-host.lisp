(cl:in-package #:sicl-extrinsic-environment)

(defun import-from-host (environment)
  ;; Import available packages in the host to ENVIRONMENT.
  (setf (sicl-genv:packages environment)
	(list-all-packages))
  (do-all-symbols (symbol)
    ;; Import available functions in the host to ENVIRONMENT.
    (when (and (fboundp symbol)
	       (not (special-operator-p symbol))
	       (null (macro-function symbol)))
      (setf (sicl-genv:fdefinition symbol environment)
	    (fdefinition symbol)))
    (when (fboundp `(setf ,symbol))
      (setf (sicl-genv:fdefinition `(setf ,symbol) environment)
	    (fdefinition `(setf ,symbol))))
    ;; Import all constant variables in the host to ENVIRONMENT.
    (when (constantp symbol)
      (setf (sicl-genv:constant-variable symbol environment)
	    (cl:symbol-value symbol)))
    ;; Import all special operators in the host to ENVIRONMENT
    (when (special-operator-p symbol)
      (setf (sicl-genv:special-operator symbol environment) t))
    ;; Import all classes in the host to ENVIRONMENT
    (let ((class (find-class symbol nil)))
      (unless (null class)
	(setf (sicl-genv:find-class symbol environment)
	      class)))
    ;; Import special variables.  There is no predicate for special
    ;; variables in Common Lisp, so we must settle for an
    ;; approximation.  We consider all symbols with earmuffs to be
    ;; special, and if they are bound, we initialize them with that
    ;; value.  We also exclude constant variables that happen to have
    ;; earmuffs.
    (let* ((name (symbol-name symbol))
	   (length (length name))
	   (boundp (boundp symbol)))
      (when (and (>= length 3)
		 (eql (char name 0) #\*)
		 (eql (char name (1- length)) #\*)
		 (not (constantp symbol)))
	(setf (sicl-genv:special-variable symbol environment boundp)
	      (if boundp (cl:symbol-value symbol) nil)))))
  ;; We look at symbols in the package CLOSER-MOP.  If they have some
  ;; interesting definition, we import that definition associated with
  ;; a symbol with the same name but interned in the package
  ;; SICL-CLOS.  But we only do that if it doesn't already have a
  ;; definition associated with the symbol in the SICL-CLOS package.
  (do-symbols (symbol (find-package '#:closer-mop))
    (let ((new (intern (symbol-name symbol) (find-package '#:sicl-clos))))
      ;; Import available functions.
      (when (and (fboundp symbol)
		 (not (special-operator-p symbol))
		 (null (macro-function symbol))
		 (not (sicl-genv:fboundp new environment)))
	(setf (sicl-genv:fdefinition new environment)
	      (fdefinition symbol)))
      (when (and (fboundp `(setf ,symbol))
		 (not (sicl-genv:fboundp `(setf ,new) environment)))
	(setf (sicl-genv:fdefinition `(setf ,new) environment)
	      (fdefinition `(setf ,symbol))))
      ;; Import constant variables.
      (when (and (constantp symbol)
		 (not (sicl-genv:boundp new environment)))
	(setf (sicl-genv:constant-variable new environment)
	      (cl:symbol-value symbol)))
      ;; Import classes.
      (let ((class (find-class symbol nil)))
	(unless (or (null class)
		    (sicl-genv:find-class new environment))
	  (setf (sicl-genv:find-class new environment)
		class)))
      ;; Import special variables.
      (let* ((name (symbol-name symbol))
	     (length (length name))
	     (boundp (boundp symbol)))
	(when (and (>= length 3)
		   (eql (char name 0) #\*)
		   (eql (char name (1- length)) #\*)
		   (not (constantp symbol))
		   (not (sicl-genv:boundp new environment)))
	  (setf (sicl-genv:special-variable new environment boundp)
		(if boundp (cl:symbol-value symbol) nil)))))))
