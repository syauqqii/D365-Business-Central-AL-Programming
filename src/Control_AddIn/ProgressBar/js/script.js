function SetProgress(progress) {
    let e = document.getElementById("myBar");

    e.style.width = progress + "%";
    e.innerHTML = progress + "%";

    if (progress < 40) {
        e.style.backgroundColor = "#aa2804";
    } else if (progress < 70) {
        e.style.backgroundColor = "#d8d509";
    } else {
        e.style.backgroundColor = "#04AA6D";
    }
}