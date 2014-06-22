issue-7-lab-color-space-explorer
================================

A simple app with sliders for creating a color in the LAB color space.

This project was forked from the demo project in Daniel Eggert's tutorial on Key-Value Coding and Observing,
which can be found here: http://www.objc.io/issue-7/key-value-coding-and-observing.html

Eggert's LabColor class holds a property for each component: L, A, and B, and a derived UIColor property that is created
by converting the LAB components into RGB values. 
The color-space conversion proccess can be found here: http://www.easyrgb.com/index.php?X=MATH

What did I change?
I believe Eggert's original LabColor mistakenly converts between the LAB and XYZ spaces, not between LAB and RGB
as intended. So I have added the code to complete the conversion to RGB (and back).
I have also added labels to display the color component values on screen.
