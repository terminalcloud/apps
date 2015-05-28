# Harbor

#### An API bridge program specially designed to let you work with Terminal.com, as you were using docker.

---

Harbor works like a bridge between any docker compatible client and the Terminal.com API. In that way, you can use docker commands to work with Terminals making any already existing docker workflow compatible with Terminals.

The theoretical approach of **Harbor** is to make the conceptual conversion, as close as possible, of docker and Terminal components.

With that idea in mind, you will be able to use Terminals as they were docker containers, or use snapshots as they were docker images.

---

### Installation and usage

**Harbor** is designed to work on a Terminal, so you don't need nothing special. Just start the [Harbor Snapshot]() and follow the on-screen instructions to configure it.

You can use it direcly from the Harbor Terminal, which has installed the latest docker client, or connect to it by tunneling the port via ssh and repointing the client to the port where Harbor is listening.

##### A look into the Harbor options
```
~/harbor# ./harbor.py --help
usage: harbor.py [-h] [-u UTOKEN] [-a ATOKEN] [-c CREDS] [-p PORT]
               [-i INTERFACE] [-v VERBOSE] [-s PEMFILE]

HARBOR - Terminal.com bindings for Docker Client

optional arguments:
  -h, --help            show this help message and exit
  -u UTOKEN, --utoken UTOKEN
                        Your user token
  -a ATOKEN, --atoken ATOKEN
                        Your access token
  -c CREDS, --creds CREDS
                        A credentials json file
  -p PORT, --port PORT  Port where listen to - Default [8080]
  -i INTERFACE, --interface INTERFACE
                        IP for the NIC where listen to. - Default [0.0.0.0]
                        (any)
  -v VERBOSE, --verbose VERBOSE
                        Verbose output - Default [True]
  -s PEMFILE, --pemfile PEMFILE
                        Custom pemfile (ssh key)
```

By default, **Harbor** will search for a credentials file, called `creds.json`. If this file exist, you can just execute harbor directly.

The default port where **Harbor** run is `8080`. To connect your docker client to this port, you need to export the `DOCKER_HOST` variable as in the example below:

```
# export DOCKER_HOST=tcp://localhost:8080
```

Once this variable is exported (and Harbor is running), you can use your docker client as usual.

---

##### Examples

**Showing running terminals**
```
# docker ps
CONTAINER ID        IMAGE                                                              COMMAND             CREATED             STATUS              PORTS               NAMES
d8e0ced13b1d        19...   ""                  3 months ago        running             22/tcp              Terminal Blog - Ghost (terminal710)      
bc20872222bb        98...   ""                  3 months ago        running             22/tcp              NetTests (terminal719)                   
15ac468f2ec5        1b..   ""                  3 months ago        running             22/tcp              enterprise.terminal.com (terminal1469)   
e43b02ac8773        5b..   ""                  5 weeks ago         running             22/tcp              Harbor (terminal17999)   
```
<br>

**Creating new Terminals** 
```
# docker create --name=newterminal  --memory=800 987f8d702dc0a6e8158b48ccd3dec24f819a7ccb2756c396ef1fd7f5b34b7980 uname
fb84b3e61852
# docker ps | grep fb84b3e61852
fb84b3e61852  98...   ""  44 seconds ago running 22/tcp newterminal (terminal23465)  
```
- We give the size on the terminal, based on the Memory parameter. In that way, if you set the memory to be between 1 and 256 you will get a 'micro' terminal, between 256 and 800 a 'Mini' Terminal and so on.
- You can use as source image a Terminal snapshot id (as in the example), a docker image id  (see docker images), a dockerhub image (this will pull the dockerhub image to /root/rootdir so you can use chroot later) or just a base image name, like ubuntu, centos, debian, etc...
<br>
<br>

**Managing Terminals**

You can stop, pause, unpause, restart or delete Terminals as well.

```
# docker pause fb84b3e61852
fb84b3e61852
# docker ps -a | grep fb84b3e61852
fb84b3e61852  98...   ""  44 seconds ago suspended 22/tcp newterminal (terminal23465) 

# docker unpause fb84b3e61852 
fb84b3e61852
# docker ps -a | grep fb84b3e61852
fb84b3e61852  98...   ""  44 seconds ago running 22/tcp newterminal (terminal23465)

# docker rm fb84b3e61852
fb84b3e61852
# docker ps -a | grep fb84b3e61852
```
<br>

**Showing snapshots**

```
# docker images
REPOSITORY  TAG                          IMAGE ID            CREATED           VIRTUAL SIZE
2f...       centos | Official Centos 6   6c2a8af3aad2        12 days ago       10.74 GB
48...       debian | Official Debian 7.0 ae596c3a0b61        12 days ago       10.74 GB
a8...       ubuntu | from_terminal21354  08aca0242eef        2 weeks ago       10.74 GB
4f...       ubuntu | Harbor              b01977722785        6 weeks ago       10.74 GB
```
You can also use filters, for instance

```
# docker images -f tags=mesos 
REPOSITORY  TAG                        IMAGE ID            CREATED           VIRTUAL SIZE
26..        mesos | Mesos Slave        77ebcc645b02        6 months ago        10.74 GB
36..        mesos,au2 | Mesos Master   fdd28c5f1aed        6 months ago        20.14 GB
```
<br>

**Searching for snapshots**

This function was improved to search your own snapshots, public snapshots and dockerhub images:

```
# docker search centos
NAME          DESCRIPTION                                              STARS  OFFICIAL AUTOMATED
            --- PUBLIC SNAPSHOTS ---                                              [OK]
cbd59e3ef100 [terminal] Official Centos 6                               0          
6319b77aa167 [varunc]   Official Centos 6                               0       
439babc2ec78 [varunc]   Jail Test                                       0                    
             --- YOUR SNAPSHOTS ---                                     
cbd59e3ef100            Official Centos 6                               0         [OK]     
6c2a8af3aad2            Official Centos 6 [UPDATE OK]                   0                               
            --- DOCKERHUB IMAGES ---                                 
centos                  The official build of CentOS.                   1025      [OK]
tutum/centos            Centos image with SSH access. For the root...   13        [OK]
layerworx/centos        A general CentOS 6 image with the EPEL6 an...   2         [OK]
jdeathe/centos-ssh      CentOS-6 6.6 x86_64 / EPEL Repo. / OpenSSH...             [OK]
...
```
<br>

**Creating Snapshots**

You can create a snapshots from a running Terminal, it will return the image ID and the full URL of the snapshot.

```
# docker ps | grep Piwigo
fb52115b2b8b 4d..   "" 16 minutes ago   running     22/tcp         Piwigo (terminal23487)    # docker commit -m "new version snap" fb52115b2b8b
c124fa80c076 | https://www.terminal.com/snapshot/e01f1f60687982af6fb533e5a3422ba59361d93ec5d2368e395bc124fa80c076
```

<br>

**Deleting Snapshots**

Snapshots can be deleted in the same way as images are removed in a docker environment.

```
# docker images | grep newsnap
48... ubuntu | newsnap     882efb2aee51        9 days ago          10.74 GB
# docker rmi 882efb2aee51
Deleted: 480464a99be2832478dcb222b7628d25350be8994b521482a182882efb2aee51
```

Those are just a few examples of what you can do with Harbor.
For a complete list of commands, just check your docker client documentation.

---

