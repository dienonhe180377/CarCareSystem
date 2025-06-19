function showDetail(id, userId, carTypeId, startDate, endDate, price, description) {
    var html = `
        <b>ID:</b> ${id}<br>
        <b>User ID:</b> ${userId}<br>
        <b>Car Type ID:</b> ${carTypeId}<br>
        <b>Start Date:</b> ${startDate}<br>
        <b>End Date:</b> ${endDate}<br>
        <b>Price:</b> ${price}<br>
        <b>Description:</b> ${description}
    `;
    document.getElementById('modalContent').innerHTML = html;
    document.getElementById('detailModal').classList.add('active');
}
function closeModal() {
    document.getElementById('detailModal').classList.remove('active');
}