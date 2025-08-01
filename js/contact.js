// Contact page functionality
document.addEventListener('DOMContentLoaded', function() {
    const copyElement = document.getElementById('copy-npub');
    const npubText = document.getElementById('npub-text');
    
    if (copyElement && npubText) {
        copyElement.addEventListener('click', async function() {
            try {
                await navigator.clipboard.writeText(npubText.textContent);
                
                // Visual feedback
                copyElement.classList.add('copy-success');
                copyElement.title = 'Copied!';
                
                // Reset after 2 seconds
                setTimeout(() => {
                    copyElement.classList.remove('copy-success');
                    copyElement.title = 'Click to copy npub';
                }, 2000);
                
            } catch (err) {
                // Fallback for older browsers
                const textArea = document.createElement('textarea');
                textArea.value = npubText.textContent;
                document.body.appendChild(textArea);
                textArea.select();
                
                try {
                    document.execCommand('copy');
                    copyElement.classList.add('copy-success');
                    copyElement.title = 'Copied!';
                    
                    setTimeout(() => {
                        copyElement.classList.remove('copy-success');
                        copyElement.title = 'Click to copy npub';
                    }, 2000);
                } catch (fallbackErr) {
                    console.error('Failed to copy text: ', fallbackErr);
                }
                
                document.body.removeChild(textArea);
            }
        });
    }
});