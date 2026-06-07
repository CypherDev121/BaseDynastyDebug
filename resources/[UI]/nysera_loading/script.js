const progressBar = document.getElementById('progress-bar');
const progressText = document.getElementById('loading-percentage');
const statusText = document.getElementById('loading-status');

// Fix pour la musique (le navigateur bloque souvent l'autoplay si l'utilisateur ne clique pas, mais FiveM autorise l'autoplay)
const audio = document.getElementById('loading-music');
if(audio) audio.volume = 0.3; // Volume à 30%

let count = 0;
let thisCount = 0;

const handlers = {
    startInitFunctionOrder(data) {
        count = data.count;
    },
    initFunctionInvoking(data) {
        let percent = Math.round((data.idx / count) * 100);
        updateProgress(percent, "Initialisation de la base...");
    },
    startDataFileEntries(data) {
        count = data.count;
    },
    performMapLoadFunction(data) {
        thisCount++;
        let percent = Math.round((thisCount / count) * 100);
        updateProgress(percent, "Chargement de la ville...");
    },
    onLogLine(data) {
        // statusText.innerHTML = data.message;
    }
};

window.addEventListener('message', function (e) {
    (handlers[e.data.eventName] || function () { })(e.data);
});

function updateProgress(percentage, status) {
    if (percentage > 100) percentage = 100;
    progressBar.style.width = percentage + "%";
    progressText.innerHTML = percentage + "%";
    if (status) statusText.innerHTML = status;
}

// Fallback simulation for local testing in browser
if (!window.invokeNative) {
    let p = 0;
    setInterval(() => {
        if(p < 100) {
            p += 1;
            updateProgress(p, "Chargement des ressources... (Simulation)");
        }
    }, 100);
}
