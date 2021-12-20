# akmal3m4-regional-infra

Instructions

```
export CLOUDSDK_PYTHON_SITEPACKAGES=1
```

```
gcloud beta builds submit --config cloudbuild-us.yaml .
gcloud beta builds submit --config cloudbuild-asia.yaml .

```