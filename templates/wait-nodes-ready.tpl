#!/bin/sh -xe

counter=1
echo -e "Waiting for kubernetes to be ready to apply "
pwd
echo The contents of ${kubeconfig} are
cat ${kubeconfig}
cmd='kubectl get nodes --kubeconfig ${kubeconfig}'
echo $cmd
max=${max_tries}
interval=.25
status=0

iters=0
while true
    do
        echo about to execute
        echo $cmd
        if $cmd &> /dev/null; then
            break
        else
            status=$?
        fi
        if [ $${iters} -ge $${max} ]; then
            exit $status
        fi
        iters=$(($iters + 1))
        sleep $${interval}
    done
exit $status