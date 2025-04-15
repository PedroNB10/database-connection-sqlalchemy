document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("orderForm");
  const addDetailButton = document.getElementById("addDetailButton");
  const orderDetailsFieldset = document.getElementById("orderDetailsFieldset");

  // Cria e posiciona um elemento para exibir mensagens para o usuário
  const messageBox = document.createElement("div");
  messageBox.id = "messageBox";
  document.body.prepend(messageBox);

  // Função para exibir mensagens com um tipo (info, success, warning, error)
  function showMessage(msg, type = "info") {
    messageBox.textContent = msg;
    messageBox.className = ""; // Limpa as classes existentes
    messageBox.classList.add(type);
    // Remove a mensagem após 5 segundos
    setTimeout(() => {
      messageBox.textContent = "";
      messageBox.className = "";
    }, 5000);
  }

  // Função para adicionar um novo bloco de order detail
  function addOrderDetail() {
    const newDetailDiv = document.createElement("div");
    newDetailDiv.classList.add("order-detail");
    newDetailDiv.innerHTML = `
      <label>Product ID (obrigatório):</label>
      <input type="number" name="productid" required />
      <label>Unit Price:</label>
      <input type="number" step="0.0001" name="unitprice" />
      <label>Quantity:</label>
      <input type="number" name="quantity" />
      <label>Discount:</label>
      <input type="number" step="0.01" name="discount" placeholder="0 (se não informado)" />
      <button type="button" class="remove-detail">Remover Item</button>
    `;
    orderDetailsFieldset.appendChild(newDetailDiv);
    attachRemoveListener(newDetailDiv);
  }

  // Função que adiciona um listener ao botão "Remover Item"
  function attachRemoveListener(detailDiv) {
    const removeButton = detailDiv.querySelector(".remove-detail");
    removeButton.addEventListener("click", () => {
      const detailBlocks =
        orderDetailsFieldset.querySelectorAll(".order-detail");
      if (detailBlocks.length <= 1) {
        showMessage(
          "É necessário ter pelo menos um item no pedido.",
          "warning"
        );
      } else {
        detailDiv.remove();
        showMessage("Item removido.", "success");
      }
    });
  }

  // Atache o listener para o bloco já existente, se houver
  const existingDetailDiv = orderDetailsFieldset.querySelector(".order-detail");
  if (existingDetailDiv) {
    attachRemoveListener(existingDetailDiv);
  }

  // Listener para adicionar novos itens
  addDetailButton.addEventListener("click", (event) => {
    event.preventDefault();
    addOrderDetail();
  });

  form.addEventListener("submit", async (event) => {
    event.preventDefault();
    try {
      // Coleta os dados do pedido principal (inputs dentro de #orderMain)
      const orderMainInputs = document.querySelectorAll("#orderMain input");
      const orderData = {};
      orderMainInputs.forEach((input) => {
        if (["orderid", "employeeid"].includes(input.name)) {
          orderData[input.name] = input.value ? parseInt(input.value) : null;
        } else {
          orderData[input.name] = input.value || null;
        }
      });

      // Coleta os dados dos detalhes do pedido (inputs dentro de elementos com a classe "order-detail")
      const orderDetailsDivs =
        orderDetailsFieldset.querySelectorAll(".order-detail");
      orderData.order_details = [];
      orderDetailsDivs.forEach((div) => {
        const detail = {};
        div.querySelectorAll("input").forEach((input) => {
          if (["productid", "quantity"].includes(input.name)) {
            detail[input.name] = input.value ? parseInt(input.value) : null;
          } else if (["unitprice", "discount"].includes(input.name)) {
            detail[input.name] = input.value ? parseFloat(input.value) : null;
          } else {
            detail[input.name] = input.value || null;
          }
        });
        orderData.order_details.push(detail);
      });

      // Envia a requisição via fetch para a rota POST /api/orders
      const response = await fetch("/api/orders", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(orderData),
      });

      if (!response.ok) {
        const err = await response.json();
        // Mapeia erros conhecidos conforme seu backend
        if (response.status === 409) {
          throw new Error(
            "Um pedido com esse ID já existe. Por favor, verifique os dados."
          );
        } else if (response.status === 400) {
          throw new Error(
            "Há erros nos dados do pedido. Por favor, verifique os campos obrigatórios."
          );
        } else {
          throw new Error(err.error || "Erro ao criar o pedido.");
        }
      }

      const data = await response.json();
      showMessage("Pedido criado com sucesso! ID: " + data.order_id, "success");

      // Reseta os campos do pedido principal para vazios
      orderMainInputs.forEach((input) => {
        input.value = "";
      });
      // Limpa os detalhes e adiciona um novo bloco vazio, mantendo pelo menos um detail
      orderDetailsFieldset.innerHTML = "";
      addOrderDetail();
    } catch (error) {
      showMessage("Erro ao enviar pedido: " + error.message, "error");
      console.error(error);
    }
  });

  // Função para gerar o PDF dos Detalhes do Pedido
  async function generateOrderDetailsPDF(orderId) {
    try {
      const response = await fetch(`/api/orders/report/${orderId}`);
      if (!response.ok) {
        throw new Error("Erro ao buscar detalhes do pedido.");
      }

      const data = await response.json();
      const { jsPDF } = window.jspdf;
      const pdf = new jsPDF();
      
      pdf.setFontSize(16);
      pdf.text(`Detalhes do Pedido #${data.orderid}`, 20, 20);
      pdf.setFontSize(12);
      pdf.text(`Cliente: ${data.customer_name}`, 20, 30);
      pdf.text(`Funcionário: ${data.employee_name}`, 20, 40);
      pdf.text(`Data do Pedido: ${new Date(data.order_date).toLocaleDateString()}`, 20, 50);

      let y = 60;
      data.order_details.forEach((detail, i) => {
        const unitPrice = detail.unitprice && !isNaN(detail.unitprice) ? parseFloat(detail.unitprice).toFixed(2) : "0.00";
        pdf.text(
          `${i + 1}. Produto: ${detail.product_name} | Qtd: ${detail.quantity} | Preço: R$${unitPrice} | Desc: ${detail.discount || 0}`,
          20,
          y
        );
        y += 10;
      });

      pdf.save(`pedido_${data.orderid}_detalhes.pdf`);
      showMessage("Relatório gerado com sucesso!", "success");

    } catch (err) {
      showMessage("Erro ao gerar relatório: " + err.message, "error");
    }
  }

  // Função para gerar o PDF de Ranking de Funcionários
  async function generateEmployeeRankingPDF(startDateObj, endDateObj) {
    try {
      const url = `/api/employees/report?start_date=${encodeURIComponent(startDateObj.toISOString())}&end_date=${encodeURIComponent(endDateObj.toISOString())}`;
      const response = await fetch(url);

      if (!response.ok) {
        throw new Error("Erro ao gerar ranking.");
      }

      const result = await response.json();
      const data = result.ranking;

      const { jsPDF } = window.jspdf;
      const pdf = new jsPDF();
      
      pdf.setFontSize(16);
      pdf.text("Ranking de Funcionários", 20, 20);
      pdf.setFontSize(12);

      let y = 30;
      data.forEach((employee) => {
        pdf.text(
          `${employee.rank}. ${employee.employee_name} - Total de Vendas: R$${parseFloat(employee.total_amount).toFixed(2)} - Pedidos: ${employee.total_orders}`,
          20,
          y
        );
        y += 10;
      });

      pdf.save(`ranking_${startDateObj.toISOString().slice(0, 10)}_to_${endDateObj.toISOString().slice(0, 10)}.pdf`);
      showMessage("Relatório de Ranking gerado com sucesso!", "success");

    } catch (err) {
      showMessage("Erro ao gerar relatório: " + err.message, "error");
    }
  }

  // Manipulador para gerar o PDF do Relatório de Detalhes do Pedido
  document.getElementById("orderDetailsReportForm").addEventListener("submit", (e) => {
    e.preventDefault();
    const orderId = document.getElementById("order_detail_id").value;
    generateOrderDetailsPDF(orderId);
  });

  // Manipulador para gerar o PDF do Relatório de Ranking de Funcionários
  document.getElementById("rankingReportForm").addEventListener("submit", (e) => {
    e.preventDefault();
    const startDate = document.getElementById("start_date").value;
    const endDate = document.getElementById("end_date").value;

    // Converter as strings de data para objetos Date
    const startDateObj = new Date(startDate);
    const endDateObj = new Date(endDate);

    // Verificar se as datas são válidas
    if (isNaN(startDateObj.getTime()) || isNaN(endDateObj.getTime())) {
      showMessage("Por favor, insira datas válidas.", "error");
      return;
    }

    generateEmployeeRankingPDF(startDateObj, endDateObj);
  });
});
