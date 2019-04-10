```
$ vim $tomcat/bin/catalina.sh

# Get standard environment variables
PRGDIR=`dirname "$PRG"`

# Froce shutdown of java process by shutdown.sh(20180621-francis)
f [ -z "$CATALINA_PID" ]; then
    CATALINA_PID=$PRGDIR/CATALINA_PID
    cat $CATALINA_PID
fi


$ $tomcat/bin/shutdown.sh
原来的     exec "$PRGDIR"/"$EXECUTABLE" stop "$@"  
增加参数后  exec "$PRGDIR"/"$EXECUTABLE" stop -force "$@"
```
