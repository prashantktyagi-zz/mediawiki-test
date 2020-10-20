# mediawiki-test

# Running on local machine

# make sure you have local Kuberneters cluster running with helm installed

C:\apps\media-wiki-test\IaC>kubectl get node
NAME             STATUS   ROLES    AGE   VERSION
docker-desktop   Ready    master   8d    v1.18.8

C:\apps\media-wiki-test\IaC>helm list
NAME            REVISION        UPDATED                         STATUS          CHART               APP VERSION NAMESPACE
mediawiki       15              Fri Oct 16 02:35:07 2020        DEPLOYED        mediawiki-1.35.0    1.0.0       default

C:\apps\media-wiki-test\IaC>kubectl get svc
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
kubernetes   ClusterIP   10.96.0.1        <none>        443/TCP        8d
mediawiki    NodePort    10.111.227.245   <none>        80:30001/TCP   4d8h
  
  

