const API_URL = "__API_GATEWAY_URL__";

fetch(API_URL,{method:"GET"})
  .catch(error => {
    console.error("Failed to increment visitor count:", error);
  });
