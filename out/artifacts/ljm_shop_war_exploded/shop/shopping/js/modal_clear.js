$('.modal').on('hidden.bs.modal', function (e) {
    console.log('modal close');
    $(this).find('form')[0].reset()
});