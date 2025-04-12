function submitOrder(event, url) {
  event.preventDefault();

  const form = document.getElementById('orderForm');
  const formData = new FormData(form);
  const jsonData = {};

  formData.forEach((value, key) => {
    jsonData[key] = value;
  });

  fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(jsonData)
  })
  .then(response => {
    if (!response.ok) {
      return response.json().then(err => { throw err });
    }
    return response.json();
  })
  .then(data => {
    alert("Pedido criado com sucesso! ID: " + data.order_id);
    form.reset();
  })
  .catch(error => {
    alert("Erro ao enviar pedido: " + (error?.error || "Erro"));
  });
}
