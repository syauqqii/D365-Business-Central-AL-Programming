const ParentDiv = document.getElementById('controlAddIn');

if (ParentDiv) {
    ParentDiv.innerHTML = `
        <h3>Tiktok Downloader</h3>
        <div class="tt-container">
            <input type="text" id="tt-url" placeholder="Paste TikTok link here..." />
            <button id="tt-download-btn">Download</button>
            <div id="tt-result" class="tt-result"></div>
        </div>
    `;
}

document.getElementById("tt-download-btn").addEventListener("click", async function () {
    const url = document.getElementById("tt-url").value;
    const resultDiv = document.getElementById("tt-result");

    if (!url) {
        alert("Please enter a TikTok link.");
        return;
    }

    resultDiv.innerHTML = "⏳ Processing...";

    try {
        if (typeof window.Download === 'function') {
            await window.Download(url);
        } else {
            resultDiv.innerHTML = "⚠️ Download function not found.";
        }
    } catch (e) {
        resultDiv.innerHTML = `❌ Error: ${e.message}`;
    }
});