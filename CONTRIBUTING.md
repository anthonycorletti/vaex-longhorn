# Contributing

Read the [docs](./docs).

To build the vaex-server docker container, run the following command.

```sh
./scripts/docker-build.sh
```

To run the vaex-server docker container, run the following command.

```sh
./scripts/docker-run.sh
```

To create the EKS cluster, refer to the following documentaton [here](./eks).

To create all kubernetes resources, run the following command.

```sh
kubectl apply -f kubernetes
```
