# Reduce Dir All
Reduce all .JPG files in a r_all sub directory

Used in my photo processing flow. After extracting all the pictures from the SD card from a shoot, I create a smaller version of all photos to sort them out faster. This is the bash script used to create those smaller pictures. Any other files than .JPG will be ignored (leaving RAWs untouched.)


For example, a folder containing those files:
- IMG_6711.JPG
- IMG_6712.JPG
- IMG_6713.JPG
- IMG_6714.JPG
- IMG_6715.JPG

Will end up with a new subfolder with the reduced images
- IMG_6711.JPG
- IMG_6712.JPG
- IMG_6713.JPG
- IMG_6714.JPG
- IMG_6715.JPG
- r_all
  - IMG_6711.jpg
  - IMG_6712.jpg
  - IMG_6713.jpg
  - IMG_6714.jpg
  - IMG_6715.jpg


## Installation
Place the script in the parent of the folder containing your .JPG files

You need the package notify-osd for the notifications to work.
`sudo apt install notify-osd`

## Configuration
Change the name of the sub folder on line 17 and 33
Change the convert values on line 33 (size reduction, JPG compression, ...). See the `convert` command help for more informations


## Usage
In a terminal:
`bash reduce_dir_all.sh NAME_OF_FOLDER_CONTAINING_JPG/`
