document.addEventListener('DOMContentLoaded', function () {
    const rowsPerPage = 15;
    const table = document.getElementById('productTable');
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    const totalPages = Math.ceil(rows.length / rowsPerPage);
    const pagination = document.getElementById('pagination');

    // 1. Hàm lấy tham số trang từ URL
    function getPageFromURL() {
        const urlParams = new URLSearchParams(window.location.search);
        const pageParam = urlParams.get('page');
        if (pageParam) {
            const page = parseInt(pageParam);
            // Kiểm tra hợp lệ: phải là số và trong khoảng 1 -> totalPages
            if (!isNaN(page) && page >= 1 && page <= totalPages) {
                return page;
            }
        }
        return 1; // Mặc định trang 1 nếu không hợp lệ
    }

    let currentPage = getPageFromURL(); // Khởi tạo từ URL

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
            if (currentPage > 1) {
                currentPage--;
                update();
            }
        });
        pagination.appendChild(prev);

        // Số trang
        for (let i = 1; i <= totalPages; i++) {
            const btn = document.createElement('button');
            const base = i === currentPage ? 'btn btn-primary' : 'btn btn-outline-primary';
            btn.className = `${base} px-3 py-2`;
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
            if (currentPage < totalPages) {
                currentPage++;
                update();
            }
        });
        pagination.appendChild(next);
    }

    // 2. Cập nhật URL khi chuyển trang
    function updateURL() {
        const url = new URL(window.location);
        url.searchParams.set('page', currentPage);
        window.history.replaceState(null, '', url);
    }

    function update() {
        renderTable(currentPage);
        renderPagination();
        updateURL(); // Cập nhật tham số URL
    }

    update();
});