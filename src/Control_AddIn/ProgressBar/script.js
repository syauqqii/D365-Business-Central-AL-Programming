function SetProgress(progress) {
    let e = document.getElementById("myBar");

    e.style.width = progress + "%";
    e.innerHTML = progress + "%";
}