#lang racket/gui

(define (toggle-list-box genre-checkbox list-box)
  (if (send genre-checkbox get-value)
      (send list-box enable #t) ;; Enable if and only genre checkbox is enabled
      (send list-box enable #f))) ;; Else disabled

(define (combined-callback checkbox event)
  (update-submit-button) ;; Calls submit counter function
  (toggle-list-box genre-checkbox list-box)) ;; Enables/Disables list box

(define (reset-main)
  (send name-checkbox set-value #f)
  (send date-checkbox set-value #f)
  (send publisher-checkbox set-value #f)
  (send region-checkbox set-value #f)
  (send genre-checkbox set-value #f))

(define secondary-controls (list list-box)) ;; To be expanded

(define (reset-secondary)
  (send list-box set-selection '()))

(define main-frame (new frame%
                   [label "Select Options"]
                   [width 800]
                   [height 600]))

(define control-panel1
  (new vertical-panel%
       [parent main-frame]))

(define control-panel2
  (new vertical-panel%
       [parent main-frame]))

(define control-panel3
  (new vertical-panel%
       [parent main-frame]))

(define (checkbox-callback checkbox event)
  (update-submit-button))

;; Button to create name option, enabled to interact by default
(define name-checkbox (new check-box%
                           [parent control-panel1]
                           [label "Name"]
                           [callback checkbox-callback]))

;; Button to create date option, enabled to interact by default
(define date-checkbox (new check-box%
                           [parent control-panel1]
                           [label "Date"]
                           [callback checkbox-callback]))

;; Button to create publisher option, enabled to interact by default
(define publisher-checkbox (new check-box%
                                [parent control-panel1]
                                [label "Publisher"]
                                [callback checkbox-callback]))

;; Button to create region option, enabled to interact by default
(define region-checkbox (new check-box%
                             [parent control-panel1]
                             [label "Region"]
                             [callback checkbox-callback]))

;; Button to create genre option, enabled to interact by default
(define genre-checkbox (new check-box%
                            [parent control-panel1]
                            [label "Genre"]
                            [callback combined-callback]))

(define list-box (new list-box%
                      [parent control-panel2]
                      [label "Genre Options:"]
                      [choices '("Action" "Adventure" "Fighting" "Platform" "Puzzle"
                                          "Racing" "Role-Playing" "Shooter" "Simulation"
                                          "Sports" "Strategy" "Misc")]
                      [enabled #f]
                      [style (list 'single)]))

(define submit-button (new button%
                           [parent control-panel3]
                           [label "Submit"]
                           [enabled #f]
                           [callback (λ (button event)
                                       ;; (submit-filters)
                                       (reset-main)
                                       (reset-secondary))]))

(send main-frame show #t)

;; Corrected logic to enable/disable the submit button
(define (update-submit-button)
  (let* ([checkboxes (list name-checkbox date-checkbox publisher-checkbox region-checkbox genre-checkbox)]
         [checked-count (count (lambda (checkbox) (send checkbox get-value)) checkboxes)])
    ;; Use the 'enable' method with an argument to enable/disable based on condition
    (if (= checked-count 3)
        (send submit-button enable #t)  ; Enable the button if exactly 3 checkboxes are selected
        (send submit-button enable #f))))  ; Otherwise, disable it
