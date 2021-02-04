# Bootstraping the kubernetes cluster with kubeadm on Vagrant

This repo highlights setting up a kubenetes cluster on vagrant vms using the kubeadm cluster bootstrapper. Basically vagrant is used to deploy the vms on the host system using the **virtualbox as vm provider**, and **provisioners** are being used to setup the entire kubernetes cluster.


## Prerequisite
* vagrant >=2.2.6
* VirtualBox >= 5.1.38_Ubuntur122592 
* Sufficient ammount of RAM & CPU

## Usage

1. For bringing-up the cluster with default configs. 
```
cd ./k8s-with-vagrant
vagrant up 
```
By default kubernetes cluster with 1xmaster node 2xworker will be get deployed.

2. Accessing the cluster
Once the cluster is up & running, SSH into the master node & can access the cluster
```
vagrant ssh masternode

```

## Argument Reference

The following arguments are supported for the `Vagrantfile` for customized changes:
* NUM_MASTER_NODE - Master node count
* NUM_WORKER_NODE - worker node count
* Kubernetes master node resources
```
vb.name = "kubemaster"
vb.memory = 2048
vb.cpus = 2 
```
* Kubenetes worker node resources
```
vb.name = "kubenode0#{i}"
vb.memory = 1024
vb.cpus = 1
```

## Vagrant cheetsheet
```
vagrant status

vagrant ssh kubemaster

```

## Cleanup 
```
vagrant down
```


**Refrences**


* vagrant installation with virtualbox
https://linuxize.com/post/how-to-install-vagrant-on-ubuntu-18-04/
https://github.com/mitchellh/vagrant-google