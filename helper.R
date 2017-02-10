require(stringr)

build.test <- function(lan='pt-br', chapter = 'All Chapters'){
  require(exams)
  require(stringr)
  
  lan <<- lan
  
  if (lan == 'pt-br'){
    my.template <- 'myexam_pt-br.tex'
    my.name <- paste0('Exercicios-R_',Sys.Date())
    
  } 
  
  if (lan == 'en') {
    my.template <- 'myexam_en.tex'
    my.name <- paste0('Exercises-R_',Sys.Date())
  }
  
  my.f <- list.files(path = 'My_Exercises', full.names = T)
  
  if (chapter!='All Chapters'){
    chapter <- str_split(chapter,' ')[[1]][1]
    my.f <- my.f[str_detect(my.f, chapter)]
  }
  
  n.q <- length(my.f)
  n.ver <- 1
  f.out <- paste0(my.name,'1.pdf')
  
  #if (file.exists(f.out)) file.remove(f.out)
  
  my.exam <- exams2pdf(file = my.f,
                       n=n.ver,
                       name=my.name,
                       inputs = paste0(getwd(),'/Supplementary files/CAPADigital_DadosFinanceirosR.jpg'),
                       template = paste0(getwd(),'/Supplementary files/',my.template),
                       language = 'pt-br',
                       institution = 'Universidade Federal do Rio Grande do Sul',
                       title = 'MQ - Prova II',
                       course = 'PPGA',
                       duplex = T,
                       encoding = 'UTF-8',
                       dir = 'Pdf Out',
                       #edir = 'temp files',tdir = 'temp files',
                       date = '2016-06-30', intro = '',
                       verbose = TRUE)
  
  # write answers to csv
  df.answer.key <- data.frame()
  exam.now <- my.exam[[1]] 
  n.q <- length(exam.now)
  
  for (i.q in seq(n.q)){
    
    sol.now <- letters[which(exam.now[[i.q]]$metainfo$solution)]
    
    temp <- data.frame(Question = i.q, 
                       Solution = sol.now)
    
    df.answer.key <- rbind(df.answer.key, temp)  
  }
  
  sol.file <- 'Solutions.txt'
  write.csv(x = df.answer.key, file = sol.file, row.names = FALSE)
  
  my.log <- (file.exists(f.out)&file.exists(sol.file))
  
  file.rename(paste0('Pdf Out/',my.name,'1.pdf'), paste0(my.name,'.pdf'))
  
  if (file.exists(f.out)) file.remove(f.out)
  
  zipfile = 'ExercisesR.zip'
  zip(zipfile = zipfile, files = c(paste0(my.name,'.pdf'),
                                   sol.file))
  
  return(my.log)
}

gen.rnd.vec <- function(){
  rnd.vec.1 <- c(1, seq(runif(1,0.1,0.2), runif(1,0.7,0.8), length.out = 4))
  rnd.vec.2 <- c(1, seq(runif(1,1.1,1.2), runif(1,1.7, 1.8), length.out = 4))
  rnd.vec.3 <- c(1, seq(runif(1,0.25,0.5),runif(1,0.6,0.8), length.out = 2), 
                 seq(runif(1,1.2,2), length.out = 2))
  
  rnd.l <- list(rnd.vec.1, rnd.vec.2, rnd.vec.3)
  rnd.vec <- sample(rnd.l,1)[[1]]
  return(rnd.vec)
}
