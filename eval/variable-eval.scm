(load "eval/core.scm")
(load "eval/analyze.scm")
(load "eval/environment.scm")

(define (install-variable-eval)
  
  (define lookup-variable-value ((make-environment)
                                 'lookup))
  
  (define (eval exp env)
    (lookup-variable-value exp env))
  
  (define (observe exp)
    (lambda (env)
      (lookup-variable-value exp env)))
  
  (put eval eval-proc-key variable-keyword)
  (put observe observe-proc-key variable-keyword)
  '(variable eval installed))
