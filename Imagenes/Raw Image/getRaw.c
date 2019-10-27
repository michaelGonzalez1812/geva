//taken from https://github.com/Zarana-Parekh/Histogram-Equalization-Algorithm/blob/master/hist_serial.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bmp.h"
#include <math.h> 

// declare image dimensions and size as constant global variables

const int color_depth = 256;

int main(int argc, char** argv){
    
    if(argc != 2){
        printf("Usage: %s image\n", argv[0]);
        exit(-1);
    }

    //read size from header
    int* size;
    size = read_size(argv[1]);
    int image_width = size[0];
    // printf("w: %i\n",image_width);
    int image_height = size[1];
    // printf("h: %i\n",image_height);


    // read from the input bmp image file
    unsigned char* image = read_grayscale(argv[1]);


    char array_char[150];
    strcpy(array_char,"raw_");
    strcat(array_char,argv[1]);

    // write data to output bmp image file
    write_raw(image, image_width, image_height,array_char);
    // write(image,offset_size(argv[1]), read_head(argv[1]), image_width,image_height,"out.bmp");
}
