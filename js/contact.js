// Contact page functionality
document.addEventListener('DOMContentLoaded', function() {
    const NPUB = 'npub16vzjeglr653mrmyqvu0trwaq29az753wr9th3hyrm5p63kz2zu8qzumhgd';
    
    const copyElement = document.getElementById('copy-npub');
    const npubText = document.getElementById('npub-text');
    const qrContainer = document.querySelector('.nostr-qr');
    const profileLink = document.getElementById('nostr-profile-link');
    
    // Populate all npub-dependent elements
    if (npubText) npubText.textContent = NPUB;
    
    if (profileLink) {
        const newUrl = `https://njump.me/${NPUB}`;
        profileLink.href = newUrl;
    }
    
    if (qrContainer) {
        const qrUrl = `https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${encodeURIComponent(`nostr:${NPUB}`)}`;
        qrContainer.src = qrUrl;
        qrContainer.alt = 'Nostr QR Code';
    }
    
    // Copy functionality
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
                    // Silently fail - user will notice nothing happened
                    console.error('Failed to copy text: ', fallbackErr);
                }
                
                document.body.removeChild(textArea);
            }
        });
    }
});