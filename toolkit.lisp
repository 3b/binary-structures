#|
 This file is a part of binary-structures
 (c) 2023 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.binary-structures)

(defun intern* (&rest args)
  (intern (format NIL "~{~a~^~}" args)))

(defun find-symbol* (package &rest args)
  (or (find-symbol (format NIL "~{~a~^~}" args) package)
      (error "?")))

(defmacro define-print-object-method (type format &rest args)
  `(defmethod print-object ((,type ,type) stream)
     (print-unreadable-object (,type stream :type T)
       (format stream ,format ,@(loop for arg in args
                                      collect (if (listp arg) arg `(,arg ,type)))))))

(defun truncate-text (text max-length)
  (if (< max-length (length text))
      (subseq text 0 max-length)
      text))

(defun unspecific-p (&rest things)
  (loop for thing in things
        do (unless (numberp thing) (return thing))))
