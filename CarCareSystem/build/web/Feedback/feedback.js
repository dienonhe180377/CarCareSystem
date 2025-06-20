function showMenu(id, event) {
    event.stopPropagation();
    document.querySelectorAll('.action-menu').forEach(e => e.style.display = 'none');
    var menu = document.getElementById('menu-' + id);
    if(menu) menu.style.display = 'block';
    document.addEventListener('click', function hideMenu(e) {
        menu.style.display = 'none';
        document.removeEventListener('click', hideMenu);
    });
}
function showEditForm(id, desc) {
    document.getElementById('edit-form-' + id).style.display = 'block';
    document.getElementById('menu-' + id).style.display = 'none';
    document.querySelector('#edit-form-' + id + ' textarea').value = desc;
}
function hideEditForm(id) {
    document.getElementById('edit-form-' + id).style.display = 'none';
}