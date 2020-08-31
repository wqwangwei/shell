
## script example

test.sh

```shell
#!/bin/bash
  
TEMP=`getopt -o a:b:c:: -a -l apple:,banana:,cherry: -n "test.sh" -- "$@"`

if [ $? != 0 ]
then
        echo "Terminating....." >&2
        exit 1
fi

eval set -- "$TEMP"

while true
do
  case "$1" in
    -a | --apple | -apple)
            IPADD=$2
            shift 2
            ;;
    -b | --banana | -banana)
            USER=$2
            shift 2
            ;;
    -c | --cherry | -cherry)
            PASS=$2
            shift 2
            ;;
    --)
            shift
            break
            ;;
    *)
            echo "Internal error!"
            exit 1
            ;;
    esac

done

for arg do
   echo '--> '"$arg" ;
done


echo "ipadd: $IPADD"
echo "user: $USER"
echo "pass: $PASS"
```

## run script example
```
# sh test.sh --apple 192.168.1.1 --banana root --cherry 123456
ipadd: 192.168.1.1
user: root
pass: 123456
```
