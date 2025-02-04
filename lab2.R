main.dir <- "MUSIC/"
vec.musics <- list.dirs(main.dir)

# subsetting all the album files by taking out all of the subdirectories
directs <- str_count(vec.musics, pattern = "/")
subdirects.indices <- which(directs == 3)
subdirects <- vec.musics[subdirects.indices]


code.to.process <- c()
# iterate through all subdirectories of the artists and take out only the wave files
for(i in 1:length(subdirects)){
  current <- list.files(subdirects[i])
  file.indices <- which(grepl("\\.wav$", current))
  wav.files <- current[file.indices]
  shortened <- str_split(subdirects[i], "/", simplify = T)
  album.name <- shortened[4]
  print(album.name)
  
  for(file.in.sub in wav.files){
    x <- paste(file.in.sub)
    x <- str_sub(x,1, length(x)-6)
    final.parts <- str_split(x, "-", simplify = T)
    sentence <- str_c(final.parts[2],album.name, final.parts[3], sep = "-")
    sentence <- paste("streaming_extractor_music.exe ", file.in.sub, str_c(sentence, ".json"))
    
    code.to.process <- append(code.to.process,sentence)
  }
}
#writes in all of the 
fileConn<-file("batfile.txt")
writeLines(code.to.process, fileConn)
close(fileConn)


#Task 2
  #splitting the items from the file name  
name.files <- list.files()
current.file <- name.files[11]
parts.of.name <- str_split(current.file, "-", simplify = T)
artist <- parts.of.name[1]
album <- parts.of.name[2]
track <- sub(".json", "", parts.of.name[3])

  #loading in the json file and extracting each item 
object <- fromJSON(current.file)
average.loudness <- object$lowlevel$average_loudness
mean.spectral.energy <- object$lowlevel$spectral_energy$mean
danceability <- object$rhythm$danceability
bpm <- object$rhythm$bpm
key_key <- object$tonal$key_key
key_scale <- object$tonal$key_scale
length <- object$metadata$audio_properties$length
