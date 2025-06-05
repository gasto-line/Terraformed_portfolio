const API_URL = "__API_GATEWAY_URL__";

fetch(API_URL,{method:"GET"})
  .catch(error => {
    console.error("Failed to increment visitor count:", error);
  });

  /*
  fetch('https://your-api-id.execute-api.region.amazonaws.com/prod/visits')
      .then(response => response.json())
      .then(data => {
        document.getElementById('visit-count').innerText = data.visits;
      })
      .catch(err => {
        console.error('Error fetching visit count:', err);
        document.getElementById('visit-count').innerText = 'N/A';
      });
  */