/* A "backend" in Terraform determines how state is
   loaded and how an operation such as apply is executed.
   This abstraction enables non-local file state storage,
   remote execution, etc.

   Google Cloud Storage is where we keep our state.
   State is represented by a file: default.tfstate

   An example of a state file, using a prefix and the default terraform
   workspace could be described as follows:

   |GCS|         BUCKET          |        PREFIX      |   WORKSPACE  |
   gs://my-terraform-state-bucket/staging/cluster-name/default.tfstate
*/

terraform {
  # configure the backend
  backend "gcs" {
    # name of the bucket to keep your state in
    # if the bucket does not exist, create it with:
    # gsutil mb gs://bucketname
    bucket = ""

    # the prefix (path) of your state
    # e.g. gs://tflab/pre/fix/
    prefix = ""

    # the [billable/trial] GCP project for your resources
    project = ""
  }
}
