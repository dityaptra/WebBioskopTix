/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function validateInput(input) {
    var value = parseInt(input.value);
    var errorMsg = document.getElementById('error-msg');
    var submitBtn = document.getElementById('submit-btn');
    var totalInput = document.getElementsByName('total_harga')[0];

    if (value < 1) {
        errorMsg.style.display = 'block';
        submitBtn.disabled = true;
        totalInput.value = '0';
    } else {
        errorMsg.style.display = 'none';
        submitBtn.disabled = false;
        hitungTotal();
    }
}

function hitungTotal() {
    var jumlah = document.getElementsByName('jumlah')[0].value;
    var harga = document.getElementsByName('harga')[0].value;
    var total = jumlah * harga;
    document.getElementsByName('total_harga')[0].value = total;
}

function increase() {
    var value = parseInt(document.getElementById('jumlah').value);
    value = isNaN(value) ? 0 : value;
    value++;
    document.getElementById('jumlah').value = value;
    hitungTotal();
}

function decrease() {
    var value = parseInt(document.getElementById('jumlah').value);
    value = isNaN(value) ? 0 : value;
    if (value > 1) {
        value--;
        document.getElementById('jumlah').value = value;
        hitungTotal();
    }
}

function updateMoviePoster() {
    const select = document.getElementById('filmSelect');
    const posterContainer = document.getElementById('moviePoster');
    const posterImage = document.getElementById('posterImage');

    const selectedOption = select.options[select.selectedIndex];
    const posterUrl = selectedOption.getAttribute('data-poster');

    if (posterUrl && posterUrl !== '') {
        posterImage.src = posterUrl;
        posterContainer.style.display = 'block';
    } else {
        posterContainer.style.display = 'none';
    }
}