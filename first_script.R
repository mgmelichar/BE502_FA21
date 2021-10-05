'
Author: Madeline Melichar
University of Arizona
Date: October 5, 2021
'
# http://www.rexamples.com/14/Sample%28%29

print(sample(1:3))
print(sample(1:3, size=3, replace=FALSE))  # same as previous line
print(sample(c(2,5,3), size=4, replace=TRUE))
print(sample(1:2, size=10, prob=c(1,3), replace=TRUE))

print(sample(c(2,5,3), size=3, replace=FALSE))
print(sample(c(2,5,3), size=3, replace=TRUE))

barplot(table(sample(1:3, size=1000, replace=TRUE, prob=c(.30,.60,.10))))