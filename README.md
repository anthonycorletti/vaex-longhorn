# vaex-longhorn

An Apache 2.0, Kubernetes-native, large scale, high performance, dataframe layer.

Read the [docs](./docs) and the [contributing doc](./CONTRIBUTING.md) to get started.

To showcase; data is immediately replicated across deployments direct to filesystem.

```shell
🔌 ⚡️ Anthonys-MBP in ~/vaex-longhorn on main
$ kubectl exec -it vaex-server-f6cbc9b98-8kqd7 -- python
Python 3.9.0 (default, Nov 25 2020, 02:26:32)
[GCC 8.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import vaex
>>> df = vaex.example()
>>> df[0][1]
1.2318683862686157
>>> df.export_arrow("/data/data.arrow")
>>> import os
>>> os.path.getsize("/data/data.arrow")
13531200
>>>
🔌 ⚡️ Anthonys-MBP in ~/vaex-longhorn on main
$ kubectl exec -it vaex-server-f6cbc9b98-r2wfn -- python
Python 3.9.0 (default, Nov 25 2020, 02:26:32)
[GCC 8.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import vaex
>>> df = vaex.open("/data/data.arrow")
>>> df[0][1]
1.2318683862686157
>>> import os
>>> os.path.getsize("/data/data.arrow")
13531200
```

Sources:
- https://longhorn.io/docs/1.2.2/deploy/install/install-with-kubectl/
- https://eksctl.io/usage/schema/
