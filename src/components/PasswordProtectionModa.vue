<script lang="ts" setup>
import { ref } from 'vue';

interface Props {
  onSuccess: () => void;
}

const props = defineProps<Props>();
const password = ref('');
const errorMessage = ref('');

const handleSubmit = (e: Event) => {
  e.preventDefault();

  // Compare with environment variable
  if (password.value === process.env.VITE_SITE_PASSWORD) {
    props.onSuccess();
    errorMessage.value = '';
  } else {
    errorMessage.value = 'Incorrect password. Please try again.';
  }
};
</script>

<template>
  <div
    class="fixed inset-0 bg-[#0B1829] bg-opacity-95 flex items-center justify-center z-50"
  >
    <div class="bg-base-100 rounded-lg p-6 w-full max-w-md shadow-xl">
      <h2 class="text-lg font-bold mb-1">Password protected site</h2>
      <p class="text-gray-600 dark:text-gray-400 mb-4">
        Please enter your password to get access.
      </p>

      <form @submit="handleSubmit" class="flex flex-col gap-y-2">
        <input
          v-model="password"
          type="password"
          placeholder="Password"
          class="input w-full mb-2 !border-1 !border-gray-300"
        />

        <div v-if="errorMessage" class="text-error text-sm mb-4">
          {{ errorMessage }}
        </div>

        <button type="submit" class="btn btn-primary w-full">Submit</button>
      </form>
    </div>
  </div>
</template>
