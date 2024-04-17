\version "2.25.8"
\language "english"

\markup \column {
  \overlay {
    \translate #'(1.0 . 1)
    \fontsize #-2 \center-align \fraction 0 1
    \translate #'(11.17 . 1)
    \fontsize #-2 \center-align \fraction 355 1
    \translate #'(21.32 . 1)
    \fontsize #-2 \center-align \fraction 709 1
    \translate #'(23.7 . 1)
    \fontsize #-2 \center-align \fraction 792 1
    \translate #'(46.39 . 1)
    \fontsize #-2 \center-align \fraction 1584 1
    \translate #'(60.61 . 1)
    \fontsize #-2 \center-align \fraction 2080 1
    \translate #'(72.13 . 1)
    \fontsize #-2 \center-align \fraction 2482 1
    \translate #'(85.68 . 1)
    \fontsize #-2 \center-align \fraction 2955 1
    \translate #'(95.83 . 1)
    \fontsize #-2 \center-align \fraction 3309 1
    \translate #'(106.0 . 1)
    \fontsize #-2 \center-align \fraction 3664 1
  }
  \postscript #"
  0.2 setlinewidth

  1.0 0.5 moveto
  1.0 1.5 lineto
  stroke
  11.17 0.5 moveto
  11.17 1.5 lineto
  stroke
  1.0 1.0 moveto
  11.17 1.0 lineto
  stroke
  21.32 0.5 moveto
  21.32 1.5 lineto
  stroke
  23.7 0.5 moveto
  23.7 1.5 lineto
  stroke
  21.32 1.0 moveto
  23.7 1.0 lineto
  stroke
  46.39 0.5 moveto
  46.39 1.5 lineto
  stroke
  60.61 0.5 moveto
  60.61 1.5 lineto
  stroke
  46.39 1.0 moveto
  60.61 1.0 lineto
  stroke
  72.13 0.5 moveto
  72.13 1.5 lineto
  stroke
  85.68 0.5 moveto
  85.68 1.5 lineto
  stroke
  72.13 1.0 moveto
  85.68 1.0 lineto
  stroke
  95.83 0.5 moveto
  95.83 1.5 lineto
  stroke
  106.0 0.5 moveto
  106.0 1.5 lineto
  stroke
  95.83 1.0 moveto
  106.0 1.0 lineto
  stroke
  "
}