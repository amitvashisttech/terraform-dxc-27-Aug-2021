resource "google_service_account" "service_account" {
  account_id   = "test-svc-account007"
  display_name = "Test Service Account"
}


resource "google_project_iam_binding" "project" {
  project = "deep-dynamics-324207"
  role    = "roles/iam.serviceAccountUser"

  members = [
    "serviceAccount:test-svc-account007@deep-dynamics-324207.iam.gserviceaccount.com",
  ]
}

