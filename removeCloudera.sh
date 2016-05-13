#!/bin/bash



echo "start removing cloudera agent, data and CDH... good luck!"

	

sudo rm -Rf /usr/share/cmf /var/lib/cloudera* /var/cache/yum/cloudera*

sudo /usr/share/cmf/uninstall-cloudera-manager.sh


sudo service cloudera-scm-server stop
sudo service cloudera-scm-server-db stop

sudo yum remove cloudera-manager-server -y
sudo yum remove cloudera-manager-server-db -y 

sudo service cloudera-scm-agent hard_stop


sudo yum remove 'cloudera-manager-*' -y

sudo yum clean all -y

sudo rm -Rf /usr/share/cmf /var/lib/cloudera* /var/cache/yum/cloudera* /var/log/cloudera* /var/run/cloudera*

sudo rm -Rf /var/lib/flume-ng /var/lib/hadoop* /var/lib/hue /var/lib/oozie /var/lib/solr /var/lib/sqoop*

sudo rm -Rf /dfs /mapred /yarn

for u in hdfs mapred cloudera-scm hbase hue zookeeper oozie hive impala flume; do sudo kill $(ps -u $u -o pid=); done


sudo rm /tmp/.scm_prepare_node.lock



rm -rf /opt/cloudera
rm -rf /tmp/*
rm -rf /var/tmp/*


echo "Deleting data from root.."

FROM_ROOT=(
	hbase
	hive
	impala
	llama
	sentry
	spark
	zookeeper
)

for ROOT_ELEM in "${FROM_ROOT[@]}"
do
	rm -rf /$ROOT_ELEM
done	


echo "Deleting user bins..."

USR_BINS=(
	avro-tools 
	beeline 
	hadoop 
	hadoop-0.20 
	hadoop-fuse-dfs 
	hbase 
	hbase-indexer 
	hcat 
	hdfs 
	impalad 
	hive 
	hiveserver2 
	impala-shell
	flume-ng
	llama
	llamaadmin
	oozie
	mapred
	mahout
)


for USR_BIN in "${USR_BINS[@]}"
do
	rm -rf /usr/bin/$USR_BIN
done	



echo "Deleting bins..."

EXECUTER_BINS=(
	pig 
	pyspark  
	zookeeper-client 
	zookeeper-server 
	zookeeper-server-cleanup 
	zookeeper-server-initialize 
	yarn 
	spark-submit 
	spark-shell 
	spark-executor 
	solrctl 
	sqoop 
	sqoop2 
	sqoop-codegen 
	sqoop-create-hive-table 
	sqoop-eval 
	sqoop-export 
	sqoop-help 
	sqoop-import 
	sqoop-import-all-tables 
	sqoop-job 
	sqoop-list-databases 
	sqoop-list-tables 
	sqoop-merge 
	sqoop-metastore 
	sqoop-version 
	sentry
)


for EXEC in "${EXECUTER_BINS[@]}"
do
	rm -rf /usr/bin/$EXEC
done	



echo "Deleting etc data..."

ETC_DATA=(
	hadoop 
	flume-ng  
	hadoop-httpfs 
	hadoop-kms 
	hbase 
	hbase-solr 
	hive 
	hive-hcatalog 
	hive-hcatalog 
	hive-webhcat 
	hue 
	impala 
	llama 
	mahout  
	oozie 
	sentry 
	solr 
	spark 
	sqoop 
	sqoop2 
	zookeeper
)



for ETC in "${ETC_DATA[@]}"
do
	rm -rf /etc/$ETC
done	



echo "Deleting var libs..."

VAR_LIBS=(
	hbase
	impala
	llama
	hive
	sentry
	spark
	zookeeper
)

for VAR_LIB in "${VAR_LIBS[@]}"
do
	rm -rf /var/lib/$VAR_LIB
done	




echo "DONE"
