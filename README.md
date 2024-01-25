# Routh-Hurwitz
So, how does the Routh-Hurwitz criterion works and how its used?
As of now, symbolic entry is not available. 

## Necessary but not sufficient conditions for Stability

## Special Cases
There are four special cases that are implemented in code, and in each of them you will receive a customized message informing you of them.

### 1. A zero followed by a non zero element in same line

### 2. Entire row of zeros
This means that you have a pair of symmetric poles in your system, the 3 possibilities and shown in the image below:

It’s important to note that in this your system will be either marginally stable (case B) or unstable (case A)


### 3. Two entire rows of zeros
This means that you have 2 pairs of symmetric poles in your system (a case C in the previous image, or 2 cases A, or a case A and a case B…).
However, unlike the previous case, here,  your system is always unstable.

### 4. Entire LAST row is filled with zeros
This is a extra special case, and it means that you have a pole on the origin of the system
