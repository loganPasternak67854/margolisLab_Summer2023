function[d]=distanceBetween(x1,y1,x2,y2)
%{
Specification: This function calculates the distance between two points.

Input: Coordinates of point1 and point2 on a Cartesian plane.
Output: The distance between the points.

%}
xDiff=x2-x1;
yDiff=y2-y1;

expression=(xDiff.^2)+(yDiff.^2);
d=sqrt(expression);

end
