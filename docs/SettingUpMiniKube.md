After running the mini-X ansible script in ABBEYROAD do the following:

1. Sort out ssh keys
   - This is to ensure you can get to the container.  Depending on which key you use.  I sometimes have to `ssh -i '/home/acshell/.ssh/id_ed25519' ubuntu@10.117.133.190` to get to the host.
   - Note that I had to change PasswordAuthentication to yes so that I could login with my own credentials (sid and password) and setup so that I'm accountable not some group user.
2. Install Docker and add yourself to the group.
   - There are half-a-dozen sites that can show you how to do this. 
3. Get and install minikube
   - `curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64`
   - `sudo install minikube-linux-amd64 /usr/local/bin/minikube` 
4. 
5. Get and install kubelet. 
6. Get and install kubectl.


All set.
