#lang scheme/load

(require (planet neil/sicp))

(load "core.scm")
(load "variable-eval.scm")
(load "quote-eval.scm")
(load "assignment-eval.scm")
(load "definition-eval.scm")
(load "lambda-eval.scm")
(load "if-eval.scm")
(load "begin-eval.scm")
(load "cond-eval.scm")
(load "let-eval.scm")
;(require "let*.ss")
;(require "and.ss")
;(require "or.ss")
(load "application-eval.scm")
(load "environment.scm")
(load "procedure.scm")

(install-application-eval)
(install-quote-eval)
(install-variable-eval)
(install-begin-eval)
(install-assignment-eval)
(install-lambda-eval)
(install-definition-eval)
(install-if-eval)
(install-cond-eval)
(install-let-eval)
;(install-let*-package)
;(install-and-package)
;(install-or-package)




(define env-dispatch (make-environment))
(define proc-dispatch (make-procedure))

(define (setup-environment)
  
  (let ([initial-env ((env-dispatch 'extend) (proc-dispatch 'primitive-names)
                                             (proc-dispatch 'primitive-objects)
                                             the-empty-environment)])
    
    ;为一些基本值赋予含义
    ((env-dispatch 'def) 'true true initial-env)
    ((env-dispatch 'def) 'false false initial-env)
    initial-env))

;全局环境
(define the-global-environment (setup-environment))



(define (prompt-for-input)
  (newline)
  (newline)
  (display ";;; M-Eval input: ")
  (newline))

(define (announce-output)
  (newline)
  (display ";;; M-Eval value: ")
  (newline))

(define (result-print object)
  (if ((proc-dispatch 'compound?) object)
      (display (list 'compound-procedure
                     ((proc-dispatch 'parameters) object)
                     ((proc-dispatch 'body) object)
                     '<procedure-env>))
      (display object)))


(define (repl)
  (prompt-for-input)
  (let ([input (read)])
    (let ([output (interp input the-global-environment)])
      (announce-output)
      (result-print output)))
  (repl))