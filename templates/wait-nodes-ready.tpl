#!/bin/sh -xe

retrycmd()
{
    local cmd=$1
    local max=$${2:-600}
    local interval=$${3:-.25}
    local status

    local iters=0
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
            return $status
        fi
        iters=$(($iters + 1))
        sleep $${interval}
    done
}

counter=1
echo -e "Waiting for kubernetes to be ready to apply "
pwd
echo The contents of ${kubeconfig} are
cat ${kubeconfig}
echo retrycmd "kubectl get nodes --kubeconfig ${kubeconfig}" ${max_tries}
retrycmd "kubectl get nodes --kubeconfig ${kubeconfig}" ${max_tries}
exit $?