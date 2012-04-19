## This function uses fishers method to find the threshold
## in a histogram - it asumes to have only 2 segments, to adapt
## it to more segments a simple extrapolation is necessary
## 
## Author: Bruno Normande Lins (aka. Jollyrog3r)

function Threshold = Fisher(Histogram)

  HistSize = size(Histogram)(2);
  N = zeros(2); 		# N will contain the sum of each segments values
  N(1) = Histogram(1);		# left side
  N(2) = sum(Histogram(2:HistSize)); # right side
  GreaterDistance = 0;		     # 'distance' - we will try to maximize it
  for LimitTemp = 2 : HistSize	     # for all possible threshold
    ## Means for each side
    Means = zeros(2);
    for i = 1 : LimitTemp
      Means(1) = Means(1) + Histogram(i)*i;
    end
    for i = LimitTemp : HistSize
      Means(2) = Means(2) + Histogram(i)*i;
    end
    Means(1) = Means(1)/N(1);
    Means(2) = Means(2)/N(2);
    ## Variance for each side
    Var = zeros(2);
    for i = 1 : LimitTemp
      Var(1) = Var(1) + Histogram(i)*((i - Means(1))^2);
    end
    for i = LimitTemp : HistSize
      Var(2) = Var(2) + Histogram(i)*((i - Means(2))^2);
    end
    Var(1) = Var(1)/N(1);
    Var(2) = Var(2)/N(2);
    ## Now, the nasty distance...    
    Distance = ((N(1) + N(2)) * ((Means(1) + (Means(2)))^2)) / \
    ((Var(1)^2) + (Var(2)^2));
    ## if this distance is bigger than the previously bigger distance...
    if (Distance > GreaterDistance)
      Threshold = LimitTemp;
      GreaterDistance = Distance;
    endif
    ## update N
    N(1) = N(1) + Histogram(LimitTemp);
    N(2) = N(2) - Histogram(LimitTemp);
  end
  ## in the end the last Threshold found is returned
  
