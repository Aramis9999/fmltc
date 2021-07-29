
resource "google_storage_bucket" "fmltc" {
  name          = var.project_name
  location      = "US"
  force_destroy = true
  depends_on = [google_project_service.gcp_services]
}

resource "google_storage_bucket" "fmltc-blobs" {
  name          = "${var.project_name}-blobs"
  location      = "US"
  force_destroy = true

  #
  # Temporary cors policy for testing
  #
  cors {
    origin          = ["*"]
    method          = ["GET", "PUT", "POST", "DELETE"]
    response_header = ["Content-Type", "Access-Control-Allow-Origin", "X-Requested-With", "x-goog-resumable"]
    max_age_seconds = 3600
  }
  depends_on = [google_project_service.gcp_services]
}

resource "google_storage_bucket_acl" "fmltc-public-acl" {
  bucket = google_storage_bucket.fmltc.name
  predefined_acl = "publicread"
  depends_on = [google_project_service.gcp_services]
}


resource "google_storage_bucket" "fmltc-action-parameters" {
  name          = "${var.project_name}-action-parameters"
  location      = "US"
  force_destroy = true
  depends_on = [google_project_service.gcp_services]
}

resource "google_storage_bucket" "fmltc-gcf-source" {
  name          = "${var.project_name}-gcf-source"
  location      = "US"
  force_destroy = true
  depends_on = [google_project_service.gcp_services]
}

resource "google_storage_bucket" "fmltc-gae-source" {
  name          = "${var.project_name}-gae-source"
  location      = "US"
  force_destroy = true
  depends_on = [google_project_service.gcp_services]
}

resource "google_storage_bucket_object" "styles" {
  name   = "static/css/styles.css"
  source = "${path.root}/../../server/static/css/styles.css"
  bucket = google_storage_bucket.fmltc.name
}

resource "google_storage_bucket_object" "closure_js" {
  name   = "compiled/js/fmltc.js"
  source = "${path.root}/../../compiled/js/fmltc.js"
  bucket = google_storage_bucket.fmltc.name
}


