### r

  R -q

#### Simple Plotting
    
    > pdf('my.pdf')
    > x <- 1:20
    > y <- 3*x + 5
    > plot(x,y)
  
#### Data file 

No header for row names, and tab separated

        A B C D
      a 1 2 3 4
      b 1 2 3 4

    data <- read.table('my.data', header = TRUE, row.names = 1)
    plot(0, type ="n", main="Aa", xlab = "A", ylab = "a", xlim=c(0,10), ylim=c(0,10), sep="\t")
    grid()
    points(data$A, data$B)

#### Execution

    #!/usr/bin/Rscript

Use

    > source('script.r')

to ensure that screen is refreshed.   

#### Language

- Vectors

    | s = c(1,2,3)
    | m <- 1:4
    | n <- 5:8
    | assign('y', c(1.2, 3.4, 5.6)
    | c(1.2, 3.4, 5.6) -> y

- Last value evaluated
   
    | c(1,2,3)
    | .Last.value

- Matrices

    | rbind(m,n)
      [,1] [,2] [,3] [,4]
    m    1    2    3    4
    n    5    6    7    8

    | cbind(m,n)
         m n
    [1,] 1 5
    [2,] 2 6
    [3,] 3 7
    [4,] 4 8

    | x <- 1:12
    | matrix(x, nrow = 4)
    | z <- matrix(x, nrow = 4, byrow = TRUE)
    | z[1,2]
    | z[,2]
    | z[1,]

- Ploting

    | x <- seq(-pi, pi, length = 100)
    | y <- sin(x)
    | plot(x,y)
    | lines(x,y)

- Summary
    
    | s <- read.table('summary/all.data')
    | names(s)
    | attributes(s)
    | summary(s)
    | pairs(s)
   
    | fivenum(s)
    | stem(s)

- Attach makes the $vars available as vars

    | attach(s)
    | cor(dup_files, contributors)

    | mean(s), sd(s)

- List objects

    | ls()
    | objectss()
    all objects assigned so far.
    | rm(s, x, y)

- Plot histogram

    | hist(s$contributors, prob=TRUE, col="red")
    | lines(density(s$contributors), col="red")


- Table queries

    | x <- s$coverage_percent
    | y <- s$contributors
    | x[y>2 & y < 3]

    | (x+1)[(!is.na(x)) & x>0] -> z
    | y <- x[-(1:5)]

    | x[is.na(x)] <- 0
    | y[y < 0] <- -y[y < 0]

- Installing (do as root)

    # R 
    > install.packages("Defaults")

- ggplot2

    | library(ggplot2)
    | s <- read.table('summary/all.data')
    | qplot(s$contributors, s$coverage_percent)

- Ascii scatter plots
    >  source("http://biostatmatt.com/R/scat.R")
    >  data(co2)
    >  scat(c(co2[1:75]), rows=10, cols=80)

- Help

    | ?solve
    | ??solve
    | help("solve")
    | expample(solve)

- Sink
   
Divert screen output to file.
   
    | sink("record.lis")
    | sink()


