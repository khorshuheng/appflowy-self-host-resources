#cloud-config
package_upgrade: true
apt:
  sources:
    docker.list:
      source: deb [arch=amd64] https://download.docker.com/linux/ubuntu $RELEASE stable
      keyid: 9DC858229FC7DD38854AE2D88D81803C0EBFCD88

packages:
  - nginx
  - docker-ce
  - docker-ce-cli

groups:
  - docker

system_info:
  default_user:
    groups: [docker]

runcmd:
  - git clone https://github.com/AppFlowy-IO/AppFlowy-Cloud.git -b fine-grained-docker-compose --single-branch --depth=1
  - cd AppFlowy-Cloud; cp deploy.env .env; cp nginx/external/appflowy-cloud-site.conf /etc/nginx/conf.d/
