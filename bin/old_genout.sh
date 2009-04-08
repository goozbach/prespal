for i in $(ls -dt1 $(find . -maxdepth 1 -type d | grep -v '^\.$' | cut -d '/' -f 2-));
do
  STOPLIST=''
  for j in $(cat .stoplist)
  do
    if [ $i == $j ]
    then
      STOPLIST=1
    fi
  done
  if [ -z $STOPLIST ]
  then
    echo -e "  <h2> <a href=\"/presentation-storage/$i\">$(cat $i/indexname.txt 2> /dev/null || echo -n "$i")</a> </h2> <p> $(cat $i/indexblurb.txt 2> /dev/null || echo -n "NO BLURB")</p>\n"
  else
    ##DEBUG echo "not printing, $i is in stoplist"
    STOPLIST=''
  fi
done
