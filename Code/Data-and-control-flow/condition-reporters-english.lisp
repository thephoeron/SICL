(cl:in-package #:sicl-data-and-control-flow)

(defmethod cleavir-i18n:report-condition
    ((condition odd-number-of-arguments-to-setf)
     stream
     (langauge cleavir-i18n:english))
  (format stream
	  "An odd number of arguments was given to SETF~@
           in the following form:~@
           ~s"
          (form condition)))

(defmethod cleavir-i18n:report-condition
    ((condition odd-number-of-arguments-to-psetf)
     stream
     (langauge cleavir-i18n:english))
  (format stream
	  "An odd number of arguments was given to PSETF~@
           in the following form:~@
           ~s"
          (form condition)))

(defmethod cleavir-i18n:report-condition
    ((condition odd-number-of-arguments-to-psetq)
     stream
     (langauge cleavir-i18n:english))
  (format stream
	  "An odd number of arguments was given to PSETQ~@
           in the following form:~@
           ~s"
          (form condition)))

(defmethod cleavir-i18n:report-condition
    ((condition too-few-arguments-to-shiftf)
     stream
     (langauge cleavir-i18n:english))
  (format stream
	  "Too few arguments were given to SHIFTF~@
           in the following form:~@
           ~s"
          (form condition)))
