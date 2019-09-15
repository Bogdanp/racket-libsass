#lang racket/base

(require (for-syntax racket/base)
         racket/match
         racket/runtime-path)

(provide
 libsass-path)

(define-runtime-path artifacts
  (build-path "artifacts"))

(define libsass-path
  (match (cons (system-type) (system-type 'word))
    [(cons 'unix 64)
     (build-path artifacts "linux-x86-64" "lib" "libsass")]

    [(cons 'macosx 64)
     (build-path artifacts "macos-x86-64" "lib" "libsass")]

    [_ #f]))
