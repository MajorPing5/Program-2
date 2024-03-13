#lang racket/gui

(require racket/system)
(require text-table)
(require csv-reading)

;; Define a function to read the CSV file into a list of records
(define (data-path symbol period)
  (build-path "Video Game Sales" period (string-append symbol ".csv")))

;; Function to filter games list by name (case-insensitive)
(define (filter-by-name games-list name)
  (filter (lambda (game) (string-ci=? (second game) name)) games-list))

;; Function to filter games list by date range
(define (filter-by-date games-list start-year end-year)
  (let ([start (min start-year end-year)]
        [end (max start-year end-year)])
    (filter (lambda (game)
              (let ([year (string->number (fifth game))])
                (and (<= start year) (<= year end))))
            games-list)))

;; Function to filter games list by publisher (case-insensitive, partial match)
(define (filter-by-publisher games-list publisher)
  (filter (lambda (game)
            (string-contains? (string-downcase (seventh game)) (string-downcase publisher)))
          games-list))

;; Function to filter games list by region sales
;; Assumes 'region' is one of: 'North America', 'Europe', 'Japan', 'Rest of World', 'Global'
(define (filter-by-region games-list region)
  (let ([index (case region
                  [('North America) 8]
                  [('Europe) 9]
                  [('Japan) 10]
                  [('Rest of World) 11]
                  [('Global) 12]
                  [else (error "Invalid region")])])
    (filter (lambda (game) (> (string->number (list-ref game index)) 0)) games-list)))

;; Function to filter games list by genre
(define (filter-by-genre games-list genre)
  (filter (lambda (game) (string-ci=? (sixth game) genre)) games-list))

;; Sorting function placeholder (to be implemented)
(define (sort-games games-list sort-by)
  (displayln "This function has yet to be implemented")
  ;; Implement sorting logic based on 'sort-by' criteria ('rank' or 'review')
  games-list)

;; Main function to handle user interaction (to be implemented)
(define (main)
  
  ;; Read the CSV data file
  ;; Implement user interaction for entering search criteria
  (define main-frame
    (new frame%
         [label "Video Game Sales Program"]
         [width 800]
         [height 600]))

  (define msg
    (new message%
         [parent main-frame]
         [auto-resize #t]
         [label "Welcome to the Video Game Sales program! To begin, specify any 3 of the following criteria to better filter the list to the relevant information for your needs"]))

  (define control-panel1
    (new horizontal-panel%
         [parent main-frame]))

  (define control-panel2
    (new horizontal-panel%
         [parent main-frame]))

  (define control-panel3
    (new horizontal-panel%
         [parent main-frame]))

  (define control-panel4
    (new horizontal-panel%
         [parent main-frame]))

  (define control-panel5
    (new horizontal-panel%
         [parent main-frame]))

  (new button%
       [parent control-panel1]
       [label "Name"]
       [callback (λ (button event)
                   ())])

  (define text-name
    (new text-field%
         [parent control-panel1]
         [label "Video Game Name: "]
         [stretchable-width #f]
         [init-value ""]))

  (new button%
       [parent control-panel2]
       [label "Date"]
       [callback (λ (button event)
                   (send ))])

  (new button%
       [parent control-panel3]
       [label "Publisher"]
       [callback (λ (button event)
                   (send ))])

  (new button%
       [parent control-panel4]
       [label "Region"]
       [callback (λ (button event)
                   (send ))])

  (new button%
       [parent control-panel5]
       [label "Genre"]
       [callback (λ (button event)
                   (send ))])
  
  (send main-frame show #t)
  (displayln "Welcome to the Video Game Sales program! To begin, specify any 3 of the following criteria to better filter the list to the relevant information for your needs\n")
  (displayln "Name - case insensitive, but spelling counts")
  (displayln "Date - requires beginning and end years, can also have both beginning and end be in 1 year")
  (displayln "Publisher - case insensitive, but partial match is feasible (refer to full publisher name rather than stock symbol)")
  (displayln "Region - specified by North America, Europe, Japan, Other, or Global")
  (displayln "Genre - must use categories provided within the set")

  #|Apply filters based on user input
    Optionally sort the filtered list
    Display the results to the user
    Repeat or exit based on user input|#
  )