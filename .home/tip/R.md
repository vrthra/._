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

#### Dataframes

- find the attribute naes of min index

    | s = read.table('data.rdata')
    | which(s == min(s), arr.ind = T)
    || arrayInd(which.min(s$total), dim(s))
    > rnames = rownames(s)[inds[,1]]
    > cnames = colnames(s)[inds[,2]]

- Adding new column

    | s$base <- ifelse(s$aresult=="single", 1, 0)
    | s$percent <- s$cov / s$total * 100

- Getting rows

    |  which(s == max(s$percent), arr.ind=T)
                              row col
    arguments                  63   3
    commad-pattern-with-guice  77   3
    | s[63,]
    | s[77,]
    | s['coverage']
    | s[1,]['coverage']

    | s[order(s$percent, decreasing=TRUE)[1:min(5, length(s$percent))],]

- create a data frame

    | statef <- letters[1:10]
    | incomes <- 1:10
    | infomef <- 1:10
    | x <- data.frame(home=statef, loot=incomes, shot=incomef)
    | x$home
    | names(x) <- letters[1:3]
    | rownames(x) <- letters[1:10]

- dataframe from a matrix

    | tmp <- data.frame(matrix(rnorm(30), 10, 3, dimnames=list(letters[1:10], c("company", "person", "salary"))))

- dataframe with no row labels

    # house.data
    > Price    Floor     Area   Rooms     Age  Cent.heat
    > 52.00    111.0      830     5       6.2      no
    > 54.75    128.0      710     5       7.5      no
    | p  <- read.table("houses.data", header=TRUE)

- from matrix

    | s <- matrix(letters[1:18],ncol=3,byrow=TRUE)
    | rownames(s) <- letters[1:6]
    | colnames(s) <- letters[1:3]
    | p <- as.data.frame(s)
    | p['f',]
    | p$a

- number of rows

    | nrow(s)
    | length(cov$bin[cov$bin <10 & cov$bin >= 0])

- ploting

    | txtplot(cov$percent)
    | txtdensity(cov$percent)
    | cov$bin <- 10*round(cov$percent/10,digits=0)
    | txtbarchart(factor(cov$bin))

- write

    | write.table(file="most_cov",rownames(best_cov), quote=F, row.names=F, col.names=F)

- Use an https url

   | s <- read.table(pipe('curl -L https://raw.github.com/vrthra/clone-unit-coverage/master/rdata/filtered.data'))

