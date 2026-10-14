/**
 * Fundación Moderna - Misión Navidad
 * Interactive Logic & Micro-animations
 */

document.addEventListener('DOMContentLoaded', () => {
  initSnowCanvas();
  initCounters();
  initNavbarScroll();
  initModal();
});

// ==========================================================================
// 1. LIENZO DE EFECTO NIEVE Y ESTRELLAS DORADAS FESTIVAS
// ==========================================================================
function initSnowCanvas() {
  const canvas = document.getElementById('snow-canvas');
  if (!canvas) return;

  const ctx = canvas.getContext('2d');
  let width = (canvas.width = window.innerWidth);
  let height = (canvas.height = window.innerHeight);

  window.addEventListener('resize', () => {
    width = canvas.width = window.innerWidth;
    height = canvas.height = window.innerHeight;
  });

  const particlesCount = 45;
  const particles = [];

  for (let i = 0; i < particlesCount; i++) {
    particles.push({
      x: Math.random() * width,
      y: Math.random() * height,
      radius: Math.random() * 2.2 + 0.8,
      density: Math.random() * 1 + 0.5,
      opacity: Math.random() * 0.7 + 0.3,
      isGold: Math.random() > 0.75, // 25% son destellos dorados
      swing: Math.random() * 2,
    });
  }

  function render() {
    ctx.clearRect(0, 0, width, height);

    for (let i = 0; i < particlesCount; i++) {
      const p = particles[i];
      ctx.beginPath();
      ctx.arc(p.x, p.y, p.radius, 0, Math.PI * 2, false);

      if (p.isGold) {
        ctx.fillStyle = `rgba(253, 224, 71, ${p.opacity})`;
        ctx.shadowBlur = 6;
        ctx.shadowColor = 'rgba(253, 224, 71, 0.8)';
      } else {
        ctx.fillStyle = `rgba(255, 255, 255, ${p.opacity})`;
        ctx.shadowBlur = 4;
        ctx.shadowColor = 'rgba(255, 255, 255, 0.5)';
      }

      ctx.fill();
      ctx.shadowBlur = 0;

      // Movimiento suave y oscilante
      p.y += Math.cos(p.density) + 0.8 + p.radius / 2;
      p.x += Math.sin(p.swing) * 0.5;
      p.swing += 0.02;

      // Si sale de pantalla, reaparece arriba
      if (p.y > height) {
        p.y = -10;
        p.x = Math.random() * width;
      }
      if (p.x > width) p.x = 0;
      if (p.x < 0) p.x = width;
    }

    requestAnimationFrame(render);
  }

  render();
}

// ==========================================================================
// 2. CONTADOR NUMÉRICO ANIMADO (KPIs)
// ==========================================================================
function initCounters() {
  const statNumbers = document.querySelectorAll('.stat-number[data-target]');
  if (!statNumbers.length) return;

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          const el = entry.target;
          const target = parseInt(el.getAttribute('data-target'), 10);
          const prefix = el.getAttribute('data-prefix') || '';
          const suffix = el.getAttribute('data-suffix') || '';
          animateCounter(el, target, prefix, suffix);
          observer.unobserve(el);
        }
      });
    },
    { threshold: 0.5 }
  );

  statNumbers.forEach((num) => observer.observe(num));
}

function animateCounter(element, target, prefix, suffix) {
  let start = 0;
  const duration = 1600;
  const stepTime = 25;
  const steps = duration / stepTime;
  const increment = target / steps;

  const timer = setInterval(() => {
    start += increment;
    if (start >= target) {
      start = target;
      clearInterval(timer);
    }
    element.textContent = `${prefix}${Math.floor(start)}${suffix}`;
  }, stepTime);
}

// ==========================================================================
// 3. SCROLL NAVBAR EFECTO
// ==========================================================================
function initNavbarScroll() {
  const navbar = document.querySelector('.navbar');
  if (!navbar) return;

  window.addEventListener('scroll', () => {
    if (window.scrollY > 40) {
      navbar.classList.add('scrolled');
    } else {
      navbar.classList.remove('scrolled');
    }
  });
}

// ==========================================================================
// 4. MODAL DE DONACIÓN / COLECTAS
// ==========================================================================
function initModal() {
  const modal = document.getElementById('donation-modal');
  const openButtons = document.querySelectorAll('[data-open-modal]');
  const closeBtn = document.querySelector('.modal-close');

  if (!modal) return;

  openButtons.forEach((btn) => {
    btn.addEventListener('click', (e) => {
      e.preventDefault();
      modal.classList.add('active');
    });
  });

  if (closeBtn) {
    closeBtn.addEventListener('click', () => {
      modal.classList.remove('active');
    });
  }

  modal.addEventListener('click', (e) => {
    if (e.target === modal) {
      modal.classList.remove('active');
    }
  });
}

// Función global para copiar datos bancarios
window.copiarAlPortapapeles = function (texto, boton) {
  navigator.clipboard.writeText(texto).then(() => {
    const originalText = boton.textContent;
    boton.textContent = '¡Copiado! ✓';
    boton.style.background = '#16a34a';
    boton.style.color = '#fff';

    setTimeout(() => {
      boton.textContent = originalText;
      boton.style.background = '';
      boton.style.color = '';
    }, 2000);
  });
};
