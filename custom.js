show('_tokamak-stack _tokamak-hstack');


function show(param_div_id) {
    const main = document.getElementById('body_for_swiftUI');
    const original = document.getElementsByClassName(param_div_id)[0];
    main.replaceWith(original);
}
