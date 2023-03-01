#set -e
#CPATH='.;../lib/hamcrest-core-1.3.jar;../lib/junit-4.13.2.jar'

#DETECTING OS (source: https://gist.github.com/3080525.git):
UNAME=$(uname)

if [[ "$UNAME" == CYGWIN* || "$UNAME" == MINGW* ]] ; then
	CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'
else
        CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'
fi

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

#echo `ls ./`

javac -cp $CPATH *.java 2> error-message.txt 

if [[ $? -eq 0 ]]
then 
    echo "COMPILE SUCCESS YAY"
    
else 
    echo "COMPILE ERROR"
    echo `cat error-message.txt`
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > run-message.txt

echo `cat run-message.txt`
#echo `grep "OK" run-message.txt`

GREPCHECK=`grep OK run-message.txt`

#echo $GREPCHECK

if [[ -n $GREPCHECK ]]
then
    echo "TEST SUCCESS"
else
    echo "TESTS FAILED"
fi