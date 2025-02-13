import { fileURLToPath, URL } from 'node:url';

import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import vueJsx from '@vitejs/plugin-vue-jsx';
import Layouts from 'vite-plugin-vue-layouts';
import DefineOptions from 'unplugin-vue-define-options/vite';
import AutoImport from 'unplugin-auto-import/vite';
import Pages from 'vite-plugin-pages';

import VueI18nPlugin from '@intlify/unplugin-vue-i18n/vite';

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => {
  // Get all VITE_ prefixed env variables with dummy values
  const processEnv: Record<string, string> = {
    VITE_PASSWORD_PROTECTION_ENABLED: 'VITE_PASSWORD_PROTECTION_ENABLED',
    VITE_SITE_PASSWORD: 'VITE_SITE_PASSWORD',
  };

  return {
    define: {
      'process.env': processEnv,
      // Also add for import.meta.env access
      'import.meta.env': processEnv,
    },
    plugins: [
      vue({
        template: {
          compilerOptions: {
            isCustomElement: (tag) =>
              [
                'ping-connect-wallet',
                'ping-token-convert',
                'ping-tx-dialog',
              ].includes(tag),
          },
        },
      }),
      vueJsx(),
      Pages({
        dirs: ['./src/modules', './src/pages'],
        exclude: ['**/*.ts'], // only load .vue as modules
      }),
      Layouts({
        layoutsDirs: './src/layouts/',
      }),
      AutoImport({
        imports: [
          'vue',
          'vue-router',
          '@vueuse/core',
          '@vueuse/math',
          'vue-i18n',
          'pinia',
        ],
        vueTemplate: true,
      }),
      VueI18nPlugin({
        runtimeOnly: true,
        compositionOnly: true,
        include: [
          fileURLToPath(
            new URL('./src/plugins/i18n/locales/**', import.meta.url),
          ),
        ],
      }),
      DefineOptions(),
    ],
    resolve: {
      alias: {
        '@': fileURLToPath(new URL('./src', import.meta.url)),
      },
    },
    optimizeDeps: {
      entries: ['./src/**/*.vue'],
    },
  };
});
