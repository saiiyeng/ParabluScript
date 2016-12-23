#!/bin/sh

TEST_DIR="/tmp/saitest"
mkdir $TEST_DIR

MYLOGFILE="$TEST_DIR/test_bootscript"
touch $MYLOGFILE
date=`date`
echo " Started boot script test...$date" >> $MYLOGFILE
hostname=`/bin/hostname`
echo " AWS VM = $hostname" >> $MYLOGFILE

# Get the URL from the registry
#resp_CreatePraBlue=`curl -s --insecure -X PUT -H "Content-Type: application/json" -H "Accept: application/json" -d '{ "action_name":"CreatePraBlue", "parameters" : { "providerInstanceID" : "12345678","registryInstanceUniqueId" : "abcdefg-test_PraBlue","resourceInfo" : { "name" : "parablue1", "hostName": "prahost", "domainName": "testDomain", "fqdn":"cobalt-vm-win3.pok.ibm.com", "ipaddr": "192.168.33.33", "core_cpus_quantity": "2", "memory": "8", "storage": "100", "uuid": "12345_parablue", "resourceState" : "RUNNING" } } }' "https://service-registry.us.gtsaasonsl.com/dev service_instance/fcc903e1-c3c0-457d-9d18-52247bc1795c"`

#echo $resp_CreatePraBlue
#url=`echo $resp_CreatePraBlue | cut -d" " -f3 | sed -e 's/\"//g' -e 's/,//g'`

url="http://169.55.59.106/parablu-agent.tar.gz"
echo ${url}

cd /opt
sudo wget ${url}
sudo tar xzvf parablu-agent.tar.gz
cd /opt/ParaBlu

export PATH=$PATH:/opt/ParaBlu/jre/bin:/opt/ParaBlu/bin
echo "Path = $PATH " >> $MYLOGFILE

OStype=`uname -m`
echo "OS Type = $OStype" >> $MYLOGFILE

Java_version=`/opt/ParaBlu/jre/bin/java -version`
echo "Checking Java version..." >> $MYLOGFILE
echo ${Java_version} >> $MYLOGFILE

sudo nohup sh run.sh > /tmp/parablu_run.log 2>&1 &

echo " End boot script test !" >> $MYLOGFILE

