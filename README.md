# Cities

## Workflow

### Segmenting

* Overlay timelines of city name (in morse) and set name
* sounding moments are when they overlap
* pass those segments to python
* pass in or load the points for the city envelope
* fill the "on" segments with the city envelope interpolated to fill the space, and the "off" segments with 0 (or some much smaller number (0.1, maybe))


### Letter dynamic envelopes
* Extract city + letter graphs (linear, cubic, average of the 2)
* Normalize them all from `[min, max]` to `[0, 1/(length of city)]`
    (this is so that at worst, the highest volume of the piece is 1)

