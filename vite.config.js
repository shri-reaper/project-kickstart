import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  build: {
    outDir: 'dist',        // Vercel default output folder for static sites
    rollupOptions: {
      input: './index.html' // entry point for Vite
    }
  },
  resolve: {
    alias: {
      '@': '/src'
    }
  }
});
