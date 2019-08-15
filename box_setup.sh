# /bin/bash

# NOTE: THIS WORKS BEST WITH A VM INSTANTIATED WITH UBUNTU 18.04 LTS

ln -s /mnt/disks/work work

# SET BUCKET PERMISSIONS
#TO DO

sudo apt-get install gcc -y
sudo apt-get install g++ -y
sudo apt install make -y

# GET MINICONDA
set +e
curl "https://repo.continuum.io/miniconda/Miniconda3-4.6.14-Linux-x86_64.sh" -o Miniconda_Install.sh
if [ $? -ne 0 ]; then
    curl "https://repo.anaconda.com/miniconda/Miniconda3-4.6.14-Linux-x86_64.sh" -o Miniconda_Install.sh
fi
set -e

bash Miniconda_Install.sh -b -f -p ~/miniconda/
echo ". ~/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc
sudo chmod 777 ~/miniconda/etc/profile.d/conda.sh
. ~/miniconda/etc/profile.d/conda.sh
export PATH=~/miniconda/bin:$PATH

# GET CODE SERVER
wget https://github.com/cdr/code-server/releases/download/1.1156-vsc1.33.1/code-server1.1156-vsc1.33.1-linux-x64.tar.gz
tar -xvzf code-server1.1156-vsc1.33.1-linux-x64.tar.gz


# SET UP VIRTUALENV
conda install -c pytorch -c fastai fastai

#MOUNT GOOGLE BUCKET
export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install gcsfuse
mkdir ~/bucket-Folder
gcsfuse example-bucket /path/to/mount

#COPY ACROSS DATA FOR DEMO
#gsutil cp gs://demo-sml/craigslistVehiclesFull.csv .
#gsutil cp gs://demo-sml/craigslistVehicles.csv .

exec $SHELL
