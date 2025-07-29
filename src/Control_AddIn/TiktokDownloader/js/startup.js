// Enhanced TikTok Downloader - Interactive JavaScript
const ParentDiv = document.getElementById('controlAddIn');

if (ParentDiv) {
    // Create the enhanced HTML structure
    ParentDiv.innerHTML = `
        <h3>🎵 TikTok Downloader</h3>
        <div class="tt-container">
            <input type="text" id="tt-url" placeholder="✨ Paste your TikTok link here and watch the magic happen..." />
            <button id="tt-download-btn" class="btn-base">
                <span>Download Video</span>
            </button>
            <button id="tt-clear-btn" class="btn-base" style="margin-left: 12px;">
                <span>Clear All</span>
            </button>
            <div id="tt-result"></div>
        </div>
    `;

    // Add enhanced functionality after DOM creation
    setTimeout(initializeEnhancedFeatures, 100);
}

function initializeEnhancedFeatures() {
    const urlInput = document.getElementById("tt-url");
    const downloadBtn = document.getElementById("tt-download-btn");
    const clearBtn = document.getElementById("tt-clear-btn");
    const resultDiv = document.getElementById("tt-result");

    // Enhanced input validation and real-time feedback
    urlInput.addEventListener('input', function() {
        const url = this.value.trim();
        const isValidTikTok = isValidTikTokUrl(url);
        
        if (url && !isValidTikTok) {
            this.style.borderColor = 'rgba(220, 53, 69, 0.5)';
            this.style.boxShadow = '0 0 0 2px rgba(220, 53, 69, 0.1)';
        } else if (isValidTikTok) {
            this.style.borderColor = 'rgba(40, 167, 69, 0.5)';
            this.style.boxShadow = '0 0 0 2px rgba(40, 167, 69, 0.1)';
        } else {
            this.style.borderColor = '';
            this.style.boxShadow = '';
        }
        
        // Enable/disable download button based on URL validity
        downloadBtn.style.opacity = (url && isValidTikTok) ? '1' : '0.7';
        downloadBtn.style.pointerEvents = (url && isValidTikTok) ? 'auto' : 'none';
    });

    // Enhanced paste detection
    urlInput.addEventListener('paste', function(e) {
        setTimeout(() => {
            const pastedText = this.value.trim();
            if (isValidTikTokUrl(pastedText)) {
                showNotification('✅ Valid TikTok URL detected!', 'success');
                this.style.borderColor = 'rgba(40, 167, 69, 0.5)';
                addRippleEffect(this);
            }
        }, 10);
    });

    // Enhanced download functionality
    downloadBtn.addEventListener("click", async function() {
        const url = urlInput.value.trim();
        
        if (!url) {
            showEnhancedAlert("⚠️ Please enter a TikTok link first!", 'warning');
            urlInput.focus();
            addShakeEffect(urlInput);
            return;
        }

        if (!isValidTikTokUrl(url)) {
            showEnhancedAlert("❌ Please enter a valid TikTok URL!", 'error');
            urlInput.focus();
            addShakeEffect(urlInput);
            return;
        }

        // Start loading state
        setLoadingState(true);
        showProcessingAnimation();

        try {
            // Check if Download function exists
            if (typeof window.Download === 'function') {
                await window.Download(url);
                showSuccessState("🎉 Video downloaded successfully!");
            } else {
                throw new Error("Download function not available");
            }
        } catch (error) {
            showErrorState(`❌ Error: ${error.message}`);
            console.error('Download error:', error);
        } finally {
            setLoadingState(false);
        }
    });

    // Enhanced clear functionality
    clearBtn.addEventListener("click", function() {
        // Add confirmation for non-empty fields
        if (urlInput.value.trim() || resultDiv.innerHTML.trim()) {
            if (!confirm("🗑️ Are you sure you want to clear all data?")) {
                return;
            }
        }

        // Animated clear
        urlInput.style.transition = 'all 0.3s ease';
        resultDiv.style.transition = 'all 0.3s ease';
        
        urlInput.style.transform = 'scale(0.95)';
        resultDiv.style.transform = 'scale(0.95)';
        
        setTimeout(() => {
            urlInput.value = '';
            resultDiv.innerHTML = '';
            resetInputStyles();
            
            urlInput.style.transform = 'scale(1)';
            resultDiv.style.transform = 'scale(1)';
            
            showNotification('🧹 All cleared!', 'info');
        }, 150);
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl/Cmd + Enter to download
        if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
            e.preventDefault();
            downloadBtn.click();
        }
        
        // Escape to clear
        if (e.key === 'Escape') {
            clearBtn.click();
        }
    });

    // Auto-focus input when page loads
    setTimeout(() => urlInput.focus(), 500);
}

// Utility Functions
function isValidTikTokUrl(url) {
    const tikTokPatterns = [
        /^https?:\/\/(www\.)?(tiktok\.com|vm\.tiktok\.com)/i,
        /^https?:\/\/(www\.)?tiktok\.com\/@[\w.-]+\/video\/\d+/i,
        /^https?:\/\/vm\.tiktok\.com\/[A-Za-z0-9]+/i,
        /^https?:\/\/(www\.)?tiktok\.com\/t\/[A-Za-z0-9]+/i
    ];
    
    return tikTokPatterns.some(pattern => pattern.test(url));
}

function setLoadingState(isLoading) {
    const downloadBtn = document.getElementById("tt-download-btn");
    const urlInput = document.getElementById("tt-url");
    
    if (isLoading) {
        downloadBtn.innerHTML = '<div class="loading-spinner"></div><span>Processing...</span>';
        downloadBtn.disabled = true;
        downloadBtn.style.opacity = '0.8';
        urlInput.disabled = true;
    } else {
        downloadBtn.innerHTML = '<span>Download Video</span>';
        downloadBtn.disabled = false;
        downloadBtn.style.opacity = '1';
        urlInput.disabled = false;
    }
}

function showProcessingAnimation() {
    const resultDiv = document.getElementById("tt-result");
    resultDiv.className = 'processing';
    resultDiv.innerHTML = `
        <div class="loading-spinner"></div>
        <span>🎬 Processing your TikTok video...</span>
    `;
}

function showSuccessState(message) {
    const resultDiv = document.getElementById("tt-result");
    resultDiv.className = 'success';
    resultDiv.innerHTML = message;
    
    // Add celebration effect
    createConfetti();
}

function showErrorState(message) {
    const resultDiv = document.getElementById("tt-result");
    resultDiv.className = 'error';
    resultDiv.innerHTML = message;
}

function resetInputStyles() {
    const urlInput = document.getElementById("tt-url");
    urlInput.style.borderColor = '';
    urlInput.style.boxShadow = '';
}

function addRippleEffect(element) {
    const ripple = document.createElement('div');
    ripple.style.cssText = `
        position: absolute;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.3);
        transform: scale(0);
        animation: ripple 0.6s linear;
        pointer-events: none;
    `;
    
    const rect = element.getBoundingClientRect();
    const size = Math.max(rect.width, rect.height);
    ripple.style.width = ripple.style.height = size + 'px';
    ripple.style.left = (rect.width / 2 - size / 2) + 'px';
    ripple.style.top = (rect.height / 2 - size / 2) + 'px';
    
    element.style.position = 'relative';
    element.appendChild(ripple);
    
    setTimeout(() => ripple.remove(), 600);
}

function addShakeEffect(element) {
    element.style.animation = 'errorShake 0.6s ease-out';
    setTimeout(() => element.style.animation = '', 600);
}

function showEnhancedAlert(message, type = 'info') {
    // Create custom alert overlay
    const alertOverlay = document.createElement('div');
    alertOverlay.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 10000;
        backdrop-filter: blur(5px);
    `;
    
    const alertBox = document.createElement('div');
    const bgColor = type === 'error' ? 'rgba(220, 53, 69, 0.1)' : 
                   type === 'warning' ? 'rgba(255, 193, 7, 0.1)' : 
                   'rgba(23, 162, 184, 0.1)';
    
    alertBox.style.cssText = `
        background: ${bgColor};
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-radius: 16px;
        padding: 24px;
        color: white;
        font-size: 16px;
        text-align: center;
        max-width: 300px;
        animation: alertSlideIn 0.3s ease-out;
    `;
    
    alertBox.innerHTML = `
        <div style="margin-bottom: 16px;">${message}</div>
        <button onclick="this.parentElement.parentElement.remove()" 
                style="background: rgba(255, 255, 255, 0.2); 
                       border: none; 
                       color: white; 
                       padding: 8px 16px; 
                       border-radius: 8px; 
                       cursor: pointer;">
            OK
        </button>
    `;
    
    alertOverlay.appendChild(alertBox);
    document.body.appendChild(alertOverlay);
    
    // Add CSS animation
    const style = document.createElement('style');
    style.textContent = `
        @keyframes alertSlideIn {
            0% { transform: scale(0.8) translateY(-20px); opacity: 0; }
            100% { transform: scale(1) translateY(0); opacity: 1; }
        }
    `;
    document.head.appendChild(style);
    
    // Auto remove after 3 seconds
    setTimeout(() => {
        if (alertOverlay.parentNode) {
            alertOverlay.remove();
            style.remove();
        }
    }, 3000);
}

function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    const bgColor = type === 'success' ? '#28a745' : 
                   type === 'error' ? '#dc3545' : 
                   type === 'warning' ? '#ffc107' : '#17a2b8';
    
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: ${bgColor};
        color: white;
        padding: 12px 20px;
        border-radius: 8px;
        font-size: 14px;
        z-index: 10000;
        animation: slideInRight 0.3s ease-out, fadeOut 0.3s ease-out 2.7s;
        backdrop-filter: blur(10px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    `;
    
    notification.textContent = message;
    document.body.appendChild(notification);
    
    // Add CSS animations
    const style = document.createElement('style');
    style.textContent = `
        @keyframes slideInRight {
            0% { transform: translateX(100%); opacity: 0; }
            100% { transform: translateX(0); opacity: 1; }
        }
        @keyframes fadeOut {
            0% { opacity: 1; }
            100% { opacity: 0; }
        }
    `;
    document.head.appendChild(style);
    
    setTimeout(() => {
        notification.remove();
        style.remove();
    }, 3000);
}

function createConfetti() {
    const colors = ['#ff6b6b', '#4ecdc4', '#45b7d1', '#96ceb4', '#feca57', '#ff9ff3'];
    
    for (let i = 0; i < 50; i++) {
        const confetti = document.createElement('div');
        confetti.style.cssText = `
            position: fixed;
            width: 10px;
            height: 10px;
            background: ${colors[Math.floor(Math.random() * colors.length)]};
            left: ${Math.random() * 100}vw;
            top: -10px;
            z-index: 10000;
            pointer-events: none;
            animation: confettiFall ${2 + Math.random() * 3}s linear forwards;
        `;
        
        document.body.appendChild(confetti);
        
        setTimeout(() => confetti.remove(), 5000);
    }
    
    // Add CSS animation for confetti
    const style = document.createElement('style');
    style.textContent = `
        @keyframes confettiFall {
            0% {
                transform: translateY(-10px) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(100vh) rotate(720deg);
                opacity: 0;
            }
        }
    `;
    document.head.appendChild(style);
    
    setTimeout(() => style.remove(), 5000);
}

// Initialize when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', function() {
        if (document.getElementById('controlAddIn')) {
            // Re-run initialization if DOM wasn't ready
            setTimeout(initializeEnhancedFeatures, 100);
        }
    });
}

// Enhanced error handling
window.addEventListener('error', function(e) {
    console.error('TikTok Downloader Error:', e.error);
    const resultDiv = document.getElementById("tt-result");
    if (resultDiv) {
        showErrorState(`❌ Unexpected error occurred: ${e.error?.message || 'Unknown error'}`);
    }
});

// Performance monitoring
const performanceObserver = new PerformanceObserver((list) => {
    const entries = list.getEntries();
    entries.forEach((entry) => {
        if (entry.duration > 100) {
            console.warn(`Slow operation detected: ${entry.name} took ${entry.duration}ms`);
        }
    });
});

if ('PerformanceObserver' in window) {
    performanceObserver.observe({ entryTypes: ['measure', 'navigation'] });
}