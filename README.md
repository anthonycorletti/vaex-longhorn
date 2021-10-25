# vaex-rook-ceph

Building a large-scale, kubernetes-native, dataframe layer.

Read the [docs](./docs) and the [contributing doc](./CONTRIBUTING.md) to get started.

To showcase; data is immediately replicated across deployments direct to filesystem.

```shell
🔌 ⚡️ Anthonys-MBP in ~/vaex-rook-ceph on main
$ kubectl exec -it pod/vaex-server-6fd5974676-688xb -- python
Python 3.9.0 (default, Nov 25 2020, 02:26:32)
[GCC 8.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import os
>>> os.listdir("/")
['bin', 'boot', 'dev', 'etc', 'home', 'lib', 'lib64', 'media', 'mnt', 'opt', 'proc', 'root', 'run', 'sbin', 'srv', 'sys', 'tmp', 'usr', 'var', 'data', '.dockerenv']
>>> os.listdir("/data")
[]
>>> import vaex
>>> df = vaex.example()
>>> os.mkdir("/data/id_1234xyz")
>>> df.export_arrow("/data/id_1234xyz/data.arrow")
>>> os.listdir("/data/id_1234xyz")
['data.arrow']
>>> os.path.getsize("/data/id_1234xyz/data.arrow")
13531200
🔌 ⚡️ Anthonys-MBP in ~/vaex-rook-ceph on main
$ kubectl exec -it pod/vaex-server-6fd5974676-9f4qt -- python
Python 3.9.0 (default, Nov 25 2020, 02:26:32)
[GCC 8.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import os
>>> os.path.getsize("/data/id_1234xyz/data.arrow")
13531200
```

This is the system usage profile output with no user activity, all machine specifications are noted in the eksctl config in the [eks](./eks) directory.

```
🔌 ⚡️ Anthonys-MBP in ~/vaex-rook-ceph 🐍 .venv on main
$ kubectl top po -A
W1025 00:01:18.551372   42303 top_pod.go:140] Using json format to get metrics. Next release will switch to protocol-buffers, switch early by passing --use-protocol-buffers flag
NAMESPACE     NAME                                                              CPU(cores)   MEMORY(bytes)
default       vaex-server-6fd5974676-688xb                                      2m           231Mi
default       vaex-server-6fd5974676-9f4qt                                      3m           236Mi
default       vaex-server-6fd5974676-9zwff                                      3m           231Mi
kube-system   aws-node-7kwtb                                                    4m           42Mi
kube-system   aws-node-jnsh8                                                    4m           42Mi
kube-system   aws-node-lpljl                                                    5m           41Mi
kube-system   coredns-65bfc5645f-4bft7                                          2m           10Mi
kube-system   coredns-65bfc5645f-nfs58                                          2m           9Mi
kube-system   kube-proxy-dhcxq                                                  1m           14Mi
kube-system   kube-proxy-rc6s7                                                  1m           13Mi
kube-system   kube-proxy-zcznh                                                  1m           14Mi
kube-system   metrics-server-588cd8ddb5-4nhvt                                   3m           19Mi
rook-ceph     csi-cephfsplugin-6lcnx                                            1m           37Mi
rook-ceph     csi-cephfsplugin-provisioner-54fdf994d6-5fpfg                     4m           78Mi
rook-ceph     csi-cephfsplugin-provisioner-54fdf994d6-qhrjx                     1m           62Mi
rook-ceph     csi-cephfsplugin-sl75b                                            1m           37Mi
rook-ceph     csi-cephfsplugin-wnxnn                                            1m           36Mi
rook-ceph     csi-rbdplugin-mwpcm                                               1m           33Mi
rook-ceph     csi-rbdplugin-provisioner-c76f87d5b-876nw                         1m           62Mi
rook-ceph     csi-rbdplugin-provisioner-c76f87d5b-8gsz7                         3m           72Mi
rook-ceph     csi-rbdplugin-vb45s                                               1m           34Mi
rook-ceph     csi-rbdplugin-wp8dr                                               1m           33Mi
rook-ceph     rook-ceph-crashcollector-ip-192-168-11-55.ec2.internal-75fn8qlh   0m           6Mi
rook-ceph     rook-ceph-crashcollector-ip-192-168-32-153.ec2.internal-8fz5r28   0m           6Mi
rook-ceph     rook-ceph-crashcollector-ip-192-168-9-148.ec2.internal-844gqw6s   0m           6Mi
rook-ceph     rook-ceph-mds-myfs-a-7fb66c5cf8-pnt9f                             15m          25Mi
rook-ceph     rook-ceph-mds-myfs-b-8574cd7b6b-dnn9g                             15m          22Mi
rook-ceph     rook-ceph-mgr-a-75f675c6f8-gsvlf                                  16m          413Mi
rook-ceph     rook-ceph-mon-a-89b9df84d-z6kj7                                   17m          487Mi
rook-ceph     rook-ceph-mon-b-546bbf8dcc-5jb4w                                  16m          287Mi
rook-ceph     rook-ceph-mon-c-674495d976-mtgxn                                  15m          283Mi
rook-ceph     rook-ceph-operator-7bdb744878-r6ptk                               39m          28Mi
rook-ceph     rook-ceph-osd-0-865545c44b-qmnmk                                  22m          76Mi
rook-ceph     rook-ceph-osd-1-5bcf7cc797-hwxh9                                  14m          76Mi
rook-ceph     rook-ceph-osd-2-867d8d5984-xx8dl                                  23m          75Mi
rook-ceph     rook-ceph-tools-7869bc54f6-qsbmg                                  1m           3Mi
🔌 ⚡️ Anthonys-MBP in ~/vaex-rook-ceph 🐍 .venv on main
$ kubectl top no
W1025 00:01:23.876217   42376 top_node.go:119] Using json format to get metrics. Next release will switch to protocol-buffers, switch early by passing --use-protocol-buffers flag
NAME                             CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
ip-192-168-11-55.ec2.internal    198m         5%     1895Mi          13%
ip-192-168-32-153.ec2.internal   117m         2%     1712Mi          11%
ip-192-168-9-148.ec2.internal    179m         4%     2166Mi          14%
```

Sources:
- https://rook.io/docs/rook/v1.7/quickstart.html
- https://rook.io/docs/rook/v1.7/ceph-filesystem.html
- https://eksctl.io/usage/schema/
