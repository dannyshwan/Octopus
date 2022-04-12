; Use a local let binding for the angles to calculate sin(pi/4) cos(pi/3) + cos(pi/4) sin(pi/3)
(let ((x (/ pi 4)) (y (/ pi 3))) 
  (+ (* (sin x) (cos y)) (* (cos x) (sin y))))