document.addEventListener('DOMContentLoaded', function () {
    const rowsPerPage = 15;
    const table = document.getElementById('productTable');
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    const totalPages = Math.ceil(rows.length / rowsPerPage);
    const pagination = document.getElementById('pagination');
    let currentPage = 1;

    function renderTable(page) {
        const start = (page - 1) * rowsPerPage;
        const end = start + rowsPerPage;
        rows.forEach((row, idx) => {
            row.style.display = (idx >= start && idx < end) ? '' : 'none';
        });
    }

    function renderPagination() {
        pagination.innerHTML = '';

        // Previous
        const prev = document.createElement('button');
        prev.className = 'btn btn-outline-primary px-3 py-2';
        prev.textContent = '‹';
        prev.disabled = currentPage === 1;
        prev.addEventListener('click', () => {
            currentPage--;
            update();
        });
        pagination.appendChild(prev);

        // Số trang
        for (let i = 1; i <= totalPages; i++) {
            const btn = document.createElement('button');
            const base = i === currentPage ? 'btn btn-primary' : 'btn btn-outline-primary';
            btn.className = base + ' px-3 py-2';
            btn.textContent = i;
            btn.addEventListener('click', () => {
                currentPage = i;
                update();
            });
            pagination.appendChild(btn);
        }

        // Next
        const next = document.createElement('button');
        next.className = 'btn btn-outline-primary px-3 py-2';
        next.textContent = '›';
        next.disabled = currentPage === totalPages;
        next.addEventListener('click', () => {
            currentPage++;
            update();
        });
        pagination.appendChild(next);
    }

    function update() {
        renderTable(currentPage);
        renderPagination();
    }

    update();
});
