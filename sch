{
  // Unique identifier for the entire run
  "run_id": "RUN_CITI_CRE_2024_Q1_001", 

  // Multi-tenant & engagement details
  "tenant_id": "CITI",
  "industry_type": "CRE",          // or "C&I", "OTHER", ...
  "engagement_id": "ENG_CITI_2024_Q1",
  "year": 2024,
  "quarter": 1,

  // Overall run status & timing
  "status": "completed",           // possible states: "ingestion_completed", "processing", "failed", "completed"
  "start_time": ISODate("2024-01-10T10:00:00Z"),
  "end_time": ISODate("2024-01-10T10:30:00Z"),

  // Additional environment & user context
  "environment": "dev",            // or "stage", "prod"
  "triggered_by": "user_john_doe", // who initiated this run
  "timestamp": ISODate("2024-01-10T10:00:00Z"), // the time we first wrote this record

  // Info about the SharePoint site/folder from which we pulled docs
  "sharepoint_info": {
    "site_url": "https://sharepoint.com/sites/CITIloanDocs",
    "folder_path": "/Shared Documents/2024Q1/CRE",
    "last_accessed": ISODate("2024-01-10T10:00:05Z")
  },

  // Info about where the docs got placed in Blob
  "blob_storage": {
    "container_name": "loan-docs",
    "base_path": "CITI/CRE/ENG_CITI_2024_Q1/2024/Q1",
    // If versioning is on, you could store details or references to version IDs
    "upload_time": ISODate("2024-01-10T10:05:00Z")
  },

  // The array of documents involved in this run
  "docs": [
    {
      "doc_id": "DOC12345",            // unique doc ID for references
      "file_name": "loan_abc.pdf",     // original file name from sharepoint

      // Path on sharepoint
      "sharepoint_full_path": "/Shared Documents/2024Q1/CRE/loan_abc.pdf",
      // Final path in Blob (including tenant/industry/engagement/year/quarter)
      "blob_path": "CITI/CRE/ENG_CITI_2024_Q1/2024/Q1/loan_abc.pdf",

      // Current doc status (the pipeline updates this as it progresses)
      "status": "Indexed",            // or "Uploaded", "Processing", "Recognized", "LLMExtracted", "Failed", etc.

      // A detailed step-by-step log for each doc
      "steps": [
        {
          "step_name": "ingestion",
          "start_time": ISODate("2024-01-10T10:00:15Z"),
          "end_time": ISODate("2024-01-10T10:00:30Z"),
          "result": "success",
          "log": "Pulled from SharePoint, placed in Blob with version overwrite."
        },
        {
          "step_name": "doc_extraction",
          "start_time": ISODate("2024-01-10T10:00:45Z"),
          "end_time": ISODate("2024-01-10T10:01:10Z"),
          "result": "success",
          "log": "Extracted text with external service, partial results stored."
        },
        {
          "step_name": "indexing",
          "start_time": ISODate("2024-01-10T10:01:15Z"),
          "end_time": ISODate("2024-01-10T10:01:25Z"),
          "result": "success",
          "log": "Computed embeddings, added to vector DB."
        }
        // More steps if needed (LLM, compliance checks, etc.)
      ],

      // Optionally store partial extracted text or an LLM summary
      "extraction_result": {
        "raw_text_snippet": "Loan doc content ...",
        "entities": [
          // array of recognized fields
          { "key": "borrower_name", "value": "John Smith" }
        ],
        "timestamp": ISODate("2024-01-10T10:01:10Z")
      },

      // Store details if something fails or if you'd like to track errors
      "error_details": {
        "step_name": null,        // or "doc_extraction"
        "error_message": null     // or "Service timeout"
      }
    },
    // Additional doc objects
  ]
}
