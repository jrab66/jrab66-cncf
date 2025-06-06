
# promox 


## create infrastructure



```
terraform/elastysys  terraform apply
data.local_file.ssh_public_key: Reading...
data.local_file.ssh_public_key: Read complete after 0s [id=6216ed8709925bcfbdf889bd926e96330520eca8]
proxmox_virtual_environment_file.cloud_config: Refreshing state... [id=local:snippets/cloud-config.yaml]
proxmox_virtual_environment_file.k3s_config: Refreshing state... [id=local:snippets/k3s-config.yaml]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # proxmox_virtual_environment_vm.ubuntu_vm will be created
  + resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
      + acpi                    = true
      + bios                    = "seabios"
      + id                      = (known after apply)
      + ipv4_addresses          = (known after apply)
      + ipv6_addresses          = (known after apply)
      + keyboard_layout         = "en-us"
      + mac_addresses           = (known after apply)
      + migrate                 = false
      + name                    = "elastsys-ubuntu"
      + network_interface_names = (known after apply)
      + node_name               = "promox"
      + on_boot                 = true
      + protection              = false
      + reboot                  = false
      + scsi_hardware           = "virtio-scsi-pci"
      + started                 = true
      + stop_on_destroy         = false
      + tablet_device           = true
      + template                = false
      + timeout_clone           = 1800
      + timeout_create          = 1800
      + timeout_migrate         = 1800
      + timeout_move_disk       = 1800
      + timeout_reboot          = 1800
      + timeout_shutdown_vm     = 1800
      + timeout_start_vm        = 1800
      + timeout_stop_vm         = 300
      + vm_id                   = (known after apply)

      + agent {
          + enabled = true
          + timeout = "15m"
          + trim    = false
          + type    = "virtio"
        }

      + cpu {
          + architecture = "x86_64"
          + cores        = 4
          + hotplugged   = 0
          + limit        = 0
          + numa         = false
          + sockets      = 1
          + type         = "qemu64"
          + units        = 1024
        }

      + disk {
          + aio               = "io_uring"
          + backup            = true
          + cache             = "none"
          + datastore_id      = "local-lvm"
          + discard           = "on"
          + file_format       = (known after apply)
          + file_id           = "local:iso/noble-server-cloudimg-amd64.img"
          + interface         = "virtio0"
          + iothread          = true
          + path_in_datastore = (known after apply)
          + replicate         = true
          + size              = 40
          + ssd               = false
        }

      + initialization {
          + datastore_id      = "local-lvm"
          + upgrade           = (known after apply)
          + user_data_file_id = "local:snippets/k3s-config.yaml"

          + ip_config {
              + ipv4 {
                  + address = "192.168.31.85/24"
                  + gateway = "192.168.31.1"
                }
            }

          + user_account {
              + keys     = [
                  + "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDI0wR8ajum4i15+Mml02k+/kATK1x0lSP/6hzakAlY5OsUDwhDcQVefvSgUJzD5lbpXurMx4mNtn3AbpUcL5Lc1FmFYSlOJBCfpRrd1H0UUnXw5zyT022lJdp+ZSBCLGJaqkaLy5tSI1DE15cAztMw9WDhgbTh3hh7lFLxZF/dDqAQoGPBiepQ7nXyyZhLd9cNYOZaJVYE8Gzz68RO10bgEJ7sWFOiniX9Ig2GsWfd9JR7SdMQ3iAmWeSImm1I3+fLFcjESSARNSitd63PrppV0ZaCUsCov9nCe+7qYrduVjt9xtIIN8Pn4iVghcUdumDME47j3x/xASSPhk6dOP+qd5YICZ+vJL090W7PDEZyv1EdFbWZ4O1m/c9ruGXEGda5/ItN3VhOCeaEASc6e8V0eJSVCfe9mauh/FTkLTOilbo3vD6nvCLbyJ9/Svg89ggFPhi64M5MjCiUiq9FPUjTKdkHjEsdNVveII+9lhi+TdlEFlGyIdHN+cKu0wZNmfkuYXC8ADwSRpgN9TvevmYU+vYXRO+f2aXlTXIRyBaEGeunt4SVNNV5HpTGfnqr+haWvNeNemg1SA7KTs2cZFm51mJ6ZVN/4MZCPNewPtSBJdShRz/HXlIV2EOAJQcMxTEXrMu1dOJAMYimjj8B6zX/70nxl2aQ2/ZOyb8fh9TaEQ== t490-jrab66",
                ]
              + password = (sensitive value)
              + username = "ubuntu"
            }
        }

      + memory {
          + dedicated      = 8000
          + floating       = 2008
          + keep_hugepages = false
          + shared         = 0
        }

      + network_device {
          + bridge      = "vmbr0"
          + enabled     = true
          + firewall    = false
          + mac_address = (known after apply)
          + model       = "virtio"
          + mtu         = 0
          + queues      = 0
          + rate_limit  = 0
          + vlan_id     = 0
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

proxmox_virtual_environment_vm.ubuntu_vm: Creating...
proxmox_virtual_environment_vm.ubuntu_vm: Still creating... [10s elapsed]
proxmox_virtual_environment_vm.ubuntu_vm: Still creating... [20s elapsed]
proxmox_virtual_environment_vm.ubuntu_vm: Still creating... [30s elapsed]
proxmox_virtual_environment_vm.ubuntu_vm: Still creating... [40s elapsed]
proxmox_virtual_environment_vm.ubuntu_vm: Still creating... [50s elapsed]
proxmox_virtual_environment_vm.ubuntu_vm: Still creating... [1m0s elapsed]
proxmox_virtual_environment_vm.ubuntu_vm: Still creating... [1m10s elapsed]
proxmox_virtual_environment_vm.ubuntu_vm: Still creating... [1m20s elapsed]
proxmox_virtual_environment_vm.ubuntu_vm: Creation complete after 1m24s [id=101]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

## download kubeconfig

default location needs permissions to be changed i dindt spend to much time on it, i download it from ssh console.
```
scp -C ubuntu@192.168.31.85:/etc/rancher/k3s/k3s.yaml kubeconfig.yaml
scp: remote open "/etc/rancher/k3s/k3s.yaml": Permission denied
```

## fix kubeconfig

by default k3s cluster have localhost as server, i did change it to my local network.

```
apiVersion: v1
clusters:
- cluster:
    server: https://192.168.31.85:6443
```




### docker build
```
 docker build -t node-hostname:0.1 . 

[+] Building 0.5s (10/10) FINISHED                                                                                                                                                                                                         docker:default
 => [internal] load build definition from Dockerfile                                                                                                                                                                                                 0.0s
 => => transferring dockerfile: 280B                                                                                                                                                                                                                 0.0s
 => [internal] load metadata for docker.io/library/node:carbon                                                                                                                                                                                       0.0s
 => [internal] load .dockerignore                                                                                                                                                                                                                    0.0s
 => => transferring context: 2B                                                                                                                                                                                                                      0.0s
 => [1/5] FROM docker.io/library/node:carbon                                                                                                                                                                                                         0.0s
 => [internal] load build context                                                                                                                                                                                                                    0.1s
 => => transferring context: 24.12kB                                                                                                                                                                                                                 0.0s
 => CACHED [2/5] WORKDIR /usr/src/app                                                                                                                                                                                                                0.0s
 => CACHED [3/5] COPY package*.json ./                                                                                                                                                                                                               0.0s
 => CACHED [4/5] RUN npm install                                                                                                                                                                                                                     0.0s
 => CACHED [5/5] COPY . .                                                                                                                                                                                                                            0.0s
 => exporting to image                                                                                                                                                                                                                               0.0s
 => => exporting layers                                                                                                                                                                                                                              0.0s
 => => writing image sha256:08fe79f293064e0c11ff847b4574b4c8ddb5372254bdbe957ec56a986e3a174d                                                                                                                                                         0.0s
 => => naming to docker.io/library/node-hostname                                                                                                                                                                                                     0.0s

 1 warning found (use docker --debug to expand):
 - LegacyKeyValueFormat: "LABEL key=value" should be used instead of legacy "LABEL key value" format (line 3)
```


```

docker images | grep node-hostname
node-hostname                                               0.1                     08fe79f29306   30 minutes ago   904MB


docker tag node-hostname:0.1 jrab66/node-hostname:0.1




docker login


USING WEB-BASED LOGIN
To sign in with credentials on the command line, use 'docker login -u <username>'

Your one-time device confirmation code is: XXXX-XXXX
Press ENTER to open your browser or submit your device code here: https://login.docker.com/activate

Waiting for authentication in the browser…
WARNING! Your password will be stored unencrypted in /home/jrab66/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credential-stores

Login Succeeded

```

```
docker push jrab66/node-hostname:0.1
The push refers to repository [docker.io/jrab66/node-hostname]
2e0768cdc894: Layer already exists 
71cfe1890679: Layer already exists 
d0704dbfa4dd: Layer already exists 
95a4a71747b4: Layer already exists 
423451ed44f2: Layer already exists 
b2aaf85d6633: Layer already exists 
88601a85ce11: Layer already exists 
42f9c2f9c08e: Layer already exists 
99e8bd3efaaf: Layer already exists 
bee1e39d7c3a: Layer already exists 
1f59a4b2e206: Layer already exists 
0ca7f54856c0: Layer already exists 
ebb9ae013834: Layer already exists 
0.1: digest: sha256:b375f0afb9c395736eff56eabdb20a2b828f38d518783115f0edd9831db2e872 size: 3050
```


## Bonus


### SSL ingress 

### HPA / Load testing 

```
k6 run --vus 10 --duration 60s load.js

          /\      |‾‾| /‾‾/   /‾‾/   
     /\  /  \     |  |/  /   /  /    
    /  \/    \    |     (   /   ‾‾\  
   /          \   |  |\  \ |  (‾)  | 
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: load.js
     output: -

  scenarios: (100.00%) 1 scenario, 10 max VUs, 1m30s max duration (incl. graceful stop):
           * default: 10 looping VUs for 1m0s (gracefulStop: 30s)


     █ response time test

       ✓ check request duration

     █ status code test

       ✗ verify homepage text
        ↳  0% — ✓ 0 / ✗ 16204

     checks.........................: 50.00% ✓ 16204      ✗ 16204
     data_received..................: 7.4 MB 122 kB/s
     data_sent......................: 3.3 MB 54 kB/s
     group_duration.................: avg=18.5ms  min=1.5ms  med=4.22ms  max=487.71ms p(90)=66.47ms p(95)=87.01ms 
     http_req_blocked...............: avg=21.53µs min=769ns  med=1.92µs  max=61.89ms  p(90)=3.67µs  p(95)=4.79µs  
     http_req_connecting............: avg=827ns   min=0s     med=0s      max=3.34ms   p(90)=0s      p(95)=0s      
     http_req_duration..............: avg=18.39ms min=1.44ms med=4.14ms  max=487.59ms p(90)=66.25ms p(95)=86.91ms 
       { expected_response:true }...: avg=18.39ms min=1.44ms med=4.14ms  max=487.59ms p(90)=66.25ms p(95)=86.91ms 
     http_req_failed................: 0.00%  ✓ 0          ✗ 32408
     http_req_receiving.............: avg=39.9µs  min=9.85µs med=30.26µs max=4.16ms   p(90)=64.26µs p(95)=82.34µs 
     http_req_sending...............: avg=10.73µs min=3.56µs med=8.48µs  max=2.3ms    p(90)=16.1µs  p(95)=20.3µs  
     http_req_tls_handshaking.......: avg=0s      min=0s     med=0s      max=0s       p(90)=0s      p(95)=0s      
     http_req_waiting...............: avg=18.34ms min=1.41ms med=4.09ms  max=487.5ms  p(90)=66.22ms p(95)=86.79ms 
     http_reqs......................: 32408  537.414315/s
     iteration_duration.............: avg=37.04ms min=3.3ms  med=13.01ms max=582.4ms  p(90)=93.25ms p(95)=111.92ms
     iterations.....................: 16204  268.707158/s
     vus............................: 10     min=10       max=10 
     vus_max........................: 10     min=10       max=10 


running (1m00.3s), 00/10 VUs, 16204 complete and 0 interrupted iterations
default ✓ [======================================] 10 VUs  1m0s

```