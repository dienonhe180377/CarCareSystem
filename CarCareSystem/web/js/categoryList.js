// ===== 1. Phân trang cho Table =====
document.addEventListener('DOMContentLoaded', function () {
    const table = document.getElementById('categoryTable');
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    const rowsPerPage = 5;
    const totalRows = rows.length;
    const totalPages = Math.ceil(totalRows / rowsPerPage);
    const paginationContainer = document.getElementById('pagination');

    let currentPage = 1;

    function showPage(page) {
        const startIdx = (page - 1) * rowsPerPage;
        const endIdx = page * rowsPerPage;

        // Hiển thị/ẩn từng hàng
        rows.forEach((row, index) => {
            row.style.display = (index >= startIdx && index < endIdx) ? '' : 'none';
        });

        // Cập nhật class active-page cho các nút số trang
        const pageButtons = paginationContainer.querySelectorAll('button[data-page]');
        pageButtons.forEach(btn => {
            const btnPageNum = parseInt(btn.getAttribute('data-page'), 10);
            btn.classList.toggle('active-page', btnPageNum === page);
        });

        currentPage = page;

        // Bật/tắt Prev & Next
        const prevBtn = paginationContainer.querySelector('button[data-action="prev"]');
        const nextBtn = paginationContainer.querySelector('button[data-action="next"]');
        if (prevBtn)
            prevBtn.disabled = (currentPage === 1);
        if (nextBtn)
            nextBtn.disabled = (currentPage === totalPages);
    }

    function renderPagination() {
        paginationContainer.innerHTML = '';

        // Prev
        const prevLi = document.createElement('li');
        const prevBtn = document.createElement('button');
        prevBtn.textContent = 'Prev';
        prevBtn.setAttribute('data-action', 'prev');
        prevBtn.disabled = true; // khi ở trang 1
        prevBtn.addEventListener('click', () => {
            if (currentPage > 1)
                showPage(currentPage - 1);
        });
        prevLi.appendChild(prevBtn);
        paginationContainer.appendChild(prevLi);

        // Các số trang
        for (let i = 1; i <= totalPages; i++) {
            const li = document.createElement('li');
            const btn = document.createElement('button');
            btn.textContent = i;
            btn.setAttribute('data-page', i);
            // Không gán active-page ở đây nữa
            btn.addEventListener('click', () => showPage(i));
            li.appendChild(btn);
            paginationContainer.appendChild(li);
        }

        // Next
        const nextLi = document.createElement('li');
        const nextBtn = document.createElement('button');
        nextBtn.textContent = 'Next';
        nextBtn.setAttribute('data-action', 'next');
        nextBtn.disabled = (totalPages <= 1);
        nextBtn.addEventListener('click', () => {
            if (currentPage < totalPages)
                showPage(currentPage + 1);
        });
        nextLi.appendChild(nextBtn);
        paginationContainer.appendChild(nextLi);
    }

    renderPagination();
    showPage(1);
});