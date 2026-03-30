import './bootstrap';
import.meta.glob([ '../images/**', ]);
import './theme';

window.confirmDelete = function(id, name){
    Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to recover this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'Cancel'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById(name + '_' + id).submit();
            }
        })
}

window.cannot = function(message){
    Swal.fire(
        'Błąd',
        message,
        'error'
    )
}
