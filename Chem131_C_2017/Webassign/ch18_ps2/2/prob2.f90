! This problem is similar to Problem 18-17 in McQuarrie. 

!====================================Question=======================================!
! Plot the fraction of HBr(g) molecules in various rotation levels (J=0,50)
! Make 2 Graphs to compare T = 300k and T = 1000K
!====================================Question=======================================!

!====================================Solution=======================================!
! From P.745 of McQuarrie : f(J) = (2J+1) (o/T) (e^-o*J(J+1)/T)
! Expect at higher Temperature we have more energy, therefore higher J states 
! Have a higher probability of being populated. 
!====================================Solution=======================================!

!====================================Program=======================================!
! Set our indepedent variable J (quantum number) from 0-50: (j)
! Solve for population density at 300K: (f)
! Solve for population density at 1000K: (g)
! Write data to a file for plotting with python
!====================================Program=======================================!

PROGRAM ch18_2
  IMPLICIT NONE
  REAL, PARAMETER :: rot_temp=12.02       ! McQuarrrie P. 739
  REAL, PARAMETER :: T=300              
  REAL, PARAMETER :: T2=1000
  Real, Parameter :: increment=1          !Evaluate at every whole number
  Integer, Parameter :: n = (50-0)/increment
  REAL, DIMENSION(1:n) :: j, f, g         !Our data to plot
  INTEGER :: i

! Always start by setting variables we want to calculate to 0
  f = 0
  j = 0
  g = 0

! plot from J = 0 to J = 50 (indepedent variable). 
  j(1) = 0
  DO i =2,n
    j(i) = j(i-1) + increment
  END DO

! Use function below to calculate population density at 300K
  DO i = 1, n
    f(i) = population(j(i))
  END DO
  
! Use function below to calculate population density at 1000K
  DO i = 1, n
    g(i) = population2(j(i))
  END DO

!Write our data to a file called data.dat  j   f(j) at 300K     f(j) at 1000K
  OPEN (UNIT =1, FILE='data.dat')
  DO i=1,n
    WRITE(1,*) j(i), f(i), g(i)
  END DO
  CLOSE (UNIT=1)

  
!Want a function that takes in a value of J and gives a population density f(J)
  CONTAINS 

    FUNCTION population(x) RESULT (values)
      IMPLICIT NONE
      REAL :: x, values
      
      values = (2.*x +1.) * (rot_temp / T) * (EXP(-(rot_temp*x*(x+1))/T))

    END FUNCTION population
    
    FUNCTION population2(x) RESULT (values)
      IMPLICIT NONE
      REAL :: x, values
      
      values = (2.*x +1.) * (rot_temp / T2) * (EXP(-(rot_temp*x*(x+1))/T2))

    END FUNCTION population2

! There is a better way to do this, but for simplicity I just write two funcitons 
! One for each temperature we are asked to evaluate.
! Note this structure is the exact same as in teh irst problem. 

! I plot that data using a python script, see plot.py and myfig.png

END PROGRAM ch18_2
