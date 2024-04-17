## Important news
We will do the data (pre-)processing in a different file than the actual project, because otherwise our PCs will kill themselves and when knitting it will explode.
Also the last few years (from 20 or so) will be used for validation of the models so no cutting them away! This is around 15% testing data.

## Data Processing steps

- combining the datasets in a meaningful way
- first join would be in _Pre-Race_, _Post_Race_ and _Championship_
- We only need the 10 best drivers since no on else receives points (fastest lap is most often under the top 10)
- dropping unneccessary columns to make it easier to work with
- omitting/filling NAs and missing values

## Research questions to answer

- Who is most likely to win the championship?/ the next race given where we race, which teams and sth else?
- Which team will prevail?
- Fastest lap predictions

## How are we approaching this

Which machine learning algos are we choosing? A tree would make sure for sense.
Maybe a classification of drivers, idk yet how exactly we could approach this.



## TODO and Task distribution
1. Preparing datasets
2. joining the datasets so we can work with them
3. prepare it (NA-treatment, fators etc.)
4. train our models
5. interpret results in a report
6. create presentation


## Assignments 
Linear Regression (Who will win the Race): Bolormaa
Logistic Regression (Who will win the Race): Anna 

How does the starting positions influence the propability of winning (Wiktor)

Tree/Forest/PCA (Moritz, Christian) 
