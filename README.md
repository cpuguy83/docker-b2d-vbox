boot2docker vboxsf
==================

boot2docker is great but can be a pain to use for dev when it's in a VM when it
comes to being able to mount paths local to your VM host (ie, OSX) into a
container.

Folks at Docker are working on a solution to this problem, but until then, here
is a containerized way to add add vbox shared folders support to boot2docker.

```bash
export B2D_KERNEL_VERSION=$(boot2docker ssh uname -r)
docker run --rm --privileged -v /:/b2d -it \
  -v /lib/modules/${B2D_KERNEL_VERSION}:/lib/modules/${B2D_KERNEL_VERSION} \
  -e KERNEL_VERSION=$(echo $B2D_KERNEL_VERSION | sed 's/-.*//') \
  cpuguy83/b2d-vboxsf
```
B2D_KERNEL_VERSION here is the kernel version used by your boot2docker install.
The most current boot2docker as of this writing is 3.15.3

Once the above command is run the vboxsf modules should be added to boot2docker.
You should now be able to ssh into boot2docker and mount your shares:

```bash
boot2docker ssh
sudo mkdir -p /Users
sudo chown docker.docker /Users
sudo mount -t vboxsf users /Users
```
This assumes a share was created in your vbox install called "users".

From here you should be able to:
```bash
cd ~/mysourcecode
docker run -v $(pwd):/mysourcecode ...
```
And be able to see ~/mysourcecode inside /mysourcecode in the contianer.
This is also assuming that the "users" shared folder is mapping to your main user
dir from your host (ie, OSX /Users).



This will need to be run anytime you reboot boo2docker (since it's booting from ISO)
If you really really want vbox shared folders in your boot2docker, just build
your own version of boot2docker!
