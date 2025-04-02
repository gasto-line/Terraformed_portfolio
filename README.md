# Cloud Resume Site – Terraform Infrastructure

This project is an extended version of the [Cloud Resume Challenge](https://cloudresumechallenge.dev/), designed to serve as both a learning exercise in AWS infrastructure and a functional personal website to showcase projects and track visitor analytics.

## 🌐 Website Overview

The website is a lightweight, static HTML page deployed to AWS, serving three main purposes:

1. **📄 Resume Access**  
   Visitors can view the resume in either English or French (PDF format, hosted on S3).

2. **💻 Project Showcase**  
   A link to this repository is provided to show the Terraform infrastructure code that powers the site. Other personal data/cloud projects will be added later.

3. **📊 Visitor Statistics**  
   The site tracks the total number of visits via a Lambda function and DynamoDB. Statistics are displayed dynamically via JavaScript.

---

## 🧱 Infrastructure Components (Managed with Terraform)

- **S3 Bucket**: Hosts the static website files (HTML, PDFs, JS).
- **CloudFront**: Distributes the site securely via HTTPS with caching.
- **Lambda Function**: Increments the visitor counter and serves analytics data.
- **API Gateway**: Exposes a, HTTP endpoint to trigger the Lambda.
- **DynamoDB Table**: Stores and updates visit counts.
- **IAM Roles/Policies**: Secure access between services.

> The full infrastructure is defined as code using Terraform and can be deployed/reproduced reliably.

---

## 🗂️ Structure

. ├── main.tf # Core infrastructure resources ├── variables.tf # Input variables ├── outputs.tf # Output values ├── lambda/ │ └── counter_function.py # Visitor counter logic ├── s3/ │ ├── index.html │ ├── cv_en.pdf │ └── cv_fr.pdf └── README.md


---

## 🚧 Roadmap

Planned future enhancements:

- Track additional visitor stats: IP-based uniqueness, location, timestamps
- Display data visualizations of visits
- Add more personal projects with GitHub links
- Create a smart job alert system based on scraped job postings and SMS notifications (e.g., using LLMs for matching)

---

## 🔐 Security & Privacy

- IP tracking for analytics will be anonymized (hashed) and stored in compliance with privacy principles.
- No personally identifiable information (PII) is collected.

---

## 🧠 Motivation

This project aims to:
- Put into practice Terraform and AWS services in a real-world scenario.
- Serve as a personal, cloud-hosted portfolio and resume hub.
- Experiment with serverless architecture and automation.
>>>>>>> daf61db (Initial commit of the terraformed cloud portfolio)
