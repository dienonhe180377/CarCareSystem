function showDetail(userName, carTypeName, typeName, startDate, endDate, price, description) {
    var html = `
        <b>User:</b> ${userName}<br>
        <b>Car Type:</b> ${carTypeName}<br>
        <b>Loại bảo hiểm:</b> ${typeName}<br>
        <b>Start Date:</b> ${startDate}<br>
        <b>End Date:</b> ${endDate}<br>
        <b>Giá:</b> ${price}<br>
        <b>Mô tả:</b> ${description}
    `;
    document.getElementById('modalContent').innerHTML = html;
    document.getElementById('detailModal').classList.add('active');
}
function closeModal() {
    document.getElementById('detailModal').classList.remove('active');
}