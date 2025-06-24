window.Download = function(link) {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("Download", [link]);
};

window.Show = function (data) {
    const resultDiv = document.getElementById("tt-result");

    if (!resultDiv) return;

    const mp3 = data?.mp3 ?? null;
    const mp4Without = data?.mp4_without_watermark ?? null;
    const mp4With = data?.mp4_with_watermark ?? null;
    const filename = data?.filename ?? null;

    resultDiv.innerHTML = `
        <p><strong>✅ Filename:</strong> ${filename}</p>
        ${mp3 ? `<p>🎵 MP3: <a href="${mp3}" target="_blank">Open</a></p>` : ""}
        ${mp4With ? `<p>📹 MP4 w/ Watermark: <a href="${mp4With}" target="_blank">Open</a></p>` : ""}
        ${mp4Without ? `<p>📹 MP4 wo/ Watermark: <a href="${mp4Without}" target="_blank">Open</a></p>` : ""}
    `;
};