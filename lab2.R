main.dir <- "music/"
vec.musics <- list.dirs(main.dir)

# subsetting all the album files by 
directs <- str_count(vec.musics, pattern = "/")
subdirects.indices <- which(directs == 3)
subdirects <- rep(x = NA, times = length(subdirects.indices))
counter <- 1
for(i in subdirects.indices){
  subdirects[counter] <- vec.musics[i]
  counter <- counter + 1
}

all.files <- list.files(subdirects)
file.indices <- which(str_count(all.files, pattern = ".wav") == 1)
wav.files <- rep(x = NA, times = length(file.indices))
counter <- 1
for(file.num in file.indices){
  wav.files[counter] <- all.files[file.num]
  counter <- counter + 1
}

code.to.process <- rep(x = NA, times = length(wav.files))
counter <- 1
for(file in wav.files){
  x <- paste(file)
  x <- str_sub(x,1, length(x)-6)
  x <- str_split(x, "-")
  code.to.process[counter] <- x[2] + x[3]
  counter <- counter +1
} 


code.to.process <- c()
for(i in 1:length(subdirects)){
  current <- list.files(subdirects[i])
  file.indices <- which(str_count(current, pattern = ".wav") == 1)
  wav.files <- rep(x = NA, times = length(file.indices))
  shortened <- str_split(subdirects[i], "/")
  album.name <- shortened[[1]][4]
  
  for(file.in.sub in current){
    x <- paste(file.in.sub)
    x <- str_sub(x,1, length(x)-6)
    x <- str_split(x, "-")
    final.parts <- x[[1]]
    # print(str_c(final.parts[2],album.name, final.parts[3], sep = "-"))
    sentence <- str_c(final.parts[2],album.name, final.parts[3], sep = "-")
    sentence <- paste("streaming_extractor_music.exe ", file.in.sub, str_c(sentence, ".json"))
    
    code.to.process <- append(code.to.process,sentence)
  }
}
fileConn<-file("batfile.txt")
writeLines(code.to.process, fileConn)
close(fileConn)

name.file <- "The Front Bottoms-Talon Of The Hawk-Au Revoir (Adios).json"
parts.of.name <- str_split(name.file, "-")[[1]]
object <- fromJSON(name.file)

