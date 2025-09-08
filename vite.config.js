import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  build: {
    rollupOptions: {
      input: './index.html', // make sure index.html is at the root
    },
  },
  resolve: {
    alias: {
      '@': '/src', // optional, for cleaner imports
    },
  },
});
