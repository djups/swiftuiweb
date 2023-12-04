function show(param_div_id) {
    const main = document.getElementById('main_place');
    const original = document.getElementsByClassName(param_div_id)[0];
    main.replaceWith(original);
}

if (document.readyState == 'complete') {
    show('test_main_to_change');
} else {
    document.onreadystatechange = function () {
        if (document.readyState === "complete") {
            show('test_main_to_change');
        }
    }
}
