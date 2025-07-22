
document.addEventListener('DOMContentLoaded', function() {
    const rowsPerPage = 7;
    const table = document.getElementById('supplierTable');
    const tbody = table.tBodies[0];
    const rows = Array.from(tbody.querySelectorAll('tr'));
    const pageCount = Math.ceil(rows.length / rowsPerPage);
    let currentPage = 1;

    function renderTable(page) {
        const start = (page - 1) * rowsPerPage;
        const end = start + rowsPerPage;
        rows.forEach((row, idx) => {
            row.style.display = (idx >= start && idx < end) ? '' : 'none';
        });
    }

    function renderPagination() {
        const container = document.getElementById('pagination');
        container.innerHTML = '';

        // Prev button
        const prevBtn = document.createElement('button');
        prevBtn.textContent = '‹';
        prevBtn.disabled = currentPage === 1;
        prevBtn.onclick = () => changePage(currentPage - 1);
        container.appendChild(prevBtn);

        // Page numbers
        for (let i = 1; i <= pageCount; i++) {
            const btn = document.createElement('button');
            btn.textContent = i;
            if (i === currentPage) btn.classList.add('active');
            btn.onclick = () => changePage(i);
            container.appendChild(btn);
        }

        // Next button
        const nextBtn = document.createElement('button');
        nextBtn.textContent = '›';
        nextBtn.disabled = currentPage === pageCount;
        nextBtn.onclick = () => changePage(currentPage + 1);
        container.appendChild(nextBtn);
    }

    function changePage(page) {
        if (page < 1 || page > pageCount) return;
        currentPage = page;
        renderTable(page);
        renderPagination();
    }

    // Khởi tạo
    renderTable(currentPage);
    renderPagination();
});



