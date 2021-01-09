Uses Google Cloud to translate audio to text.

Need to login first with something like:

```
gcloud auth activate-service-account 'translator-sa-1@blah.iam.gserviceaccount.com' --key-file=/Users/blah/Downloads/translator-01234-1111111111111.json
```

Check with:

  gcloud auth list

Service account needs Storage Object and Translator service roles.

Run like:

```bash
$  ~/Dropbox/translate/run-en.sh Foo.m4a > 'data.json'
$  jq '.results[] | .alternatives[] | .transcript' data.json | tr -d '"'
```
