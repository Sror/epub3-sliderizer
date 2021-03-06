#!/bin/sh

root=$(pwd)

#DATA_file="${root}/_INPUT/Romain/slides.html"
#DATA_file="${root}/_INPUT/book_UNZIPPED.epub/OEBPS/content.opf"

#DATA_file="${root}/_INPUT/DAISY/data.txt"

DATA_file="${root}/_INPUT/data.txt"


rm -r ./_OUTPUT
mkdir ./_OUTPUT
cp -r ./tool/readium ./_OUTPUT/
mkdir ./_OUTPUT/content
cp -r ./tool/EPUB3 ./_OUTPUT/content/
mv ./_OUTPUT/readium/index.html ./_OUTPUT/content/

cd ./tool/epub3-sliderizer/

pwd

class="./bin/Main.class"

if [ -f ${class} ]; then

echo "Class found: ${class}"

else

echo "Compiling: ${class}"

javac -classpath ".:${root}/tool/epub3-sliderizer/lib/jsoup-1.7.2.jar" "${root}/tool/epub3-sliderizer/src/Main.java" -d "${root}/tool/epub3-sliderizer/bin/" -sourcepath "${root}/tool/epub3-sliderizer/src" #-verbose

fi

DATA_url="file://${DATA_file}"

EPUB_FOLDER="${root}/_OUTPUT/content/EPUB3/epub"

echo "EPUB3-Sliderization in progress..."
echo ${DATA_file}
echo ${EPUB_FOLDER}

java -classpath "${root}/tool/epub3-sliderizer/bin/:${root}/tool/epub3-sliderizer/lib/jsoup-1.7.2.jar" Main ${DATA_url} ${EPUB_FOLDER} VERBOSE_min


open ${EPUB_FOLDER}
#exit


cd ${root}

./pack-epub.sh
