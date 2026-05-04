document.addEventListener('DOMContentLoaded', () => {
    console.log('GymPulse Initialized');
    
    // Smooth transitions for interaction
    const buttons = document.querySelectorAll('button');
    buttons.forEach(btn => {
        btn.addEventListener('mousedown', () => {
            btn.style.transform = 'scale(0.98)';
        });
        btn.addEventListener('mouseup', () => {
            btn.style.transform = 'scale(1)';
        });
    });
});
