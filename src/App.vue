<script setup lang="ts">
import { themeChange } from 'theme-change';
import { onMounted, ref } from 'vue';
import TxDialog from './components/TxDialog.vue';
import PasswordProtectionModal from './components/PasswordProtectionModa.vue';

const passwordProtectionEnabled =
  import.meta.env.VITE_PASSWORD_PROTECTION_ENABLED ?? false;

const isAuthenticated = ref(!passwordProtectionEnabled);

onMounted(() => {
  themeChange(false);
  isAuthenticated.value = !passwordProtectionEnabled;
});

function handleAuthentication() {
  isAuthenticated.value = true;
}
</script>

<template>
  <div v-if="isAuthenticated">
    <RouterView />
    <TxDialog />
  </div>
  <div v-else>
    <PasswordProtectionModal @success="handleAuthentication" />
  </div>
</template>
