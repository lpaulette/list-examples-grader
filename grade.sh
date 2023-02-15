#set -e
CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission
#echo `pwd`
#echo `ls`

if [[ -f ListExamples.java ]]
then 
    echo "ListExamples.java found"
else
    echo " need file ListExamples.java"
    exit 1
fi

cp ../*.java ./

echo `ls ./`

javac -cp CPATH *.java 2>error-message.txt 

if [[ -s error-message.txt ]]
then 
    echo "ERROR TRY AGAIN"
    echo `cat error-message.txt`
else 
    echo "COMPILE SUCCESS YAY"
fi
