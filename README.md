# Environment Installer

Installation using bash through curl:

```bash
bash -c "$(curl -L https://raw.githubusercontent.com/poldz123/EnvironmentInstaller/master/mac/install.sh)"
```

## Addon installation

Install extra addon program to the environment.

```bash
bash -c "$(curl -L https://raw.githubusercontent.com/poldz123/EnvironmentInstaller/master/mac/install.sh)" --options-go-here
```

| Option | Description  |
|--------|---|
| --with-kubernetes | Install kubernetes cli and Kubernetes powertools |